/*
 Author: Ampers
 Makes unit throw the specified magazine to the specified location.

 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Magazine <STRING>
 * 2: Muzzle <STRING>
 * 3: Fire Mode <STRING>
 * 4: Target Pos ASL <ARRAY>
 * 5: Trajectory <BOOLEAN>
 *
 * Return Value:
 * NONE

 * Example:
 * [_unit, _magazine, _muzzle, _firemode, _targetPos, _throwFlatTrajectory] call tft_zeus_fnc_unitProjectile;
 * [_unit, _magazine, _muzzle, _firemode, _targetPos, _throwFlatTrajectory] remoteExecCall ["tft_zeus_fnc_unitProjectile", _unit];
*/

params ["_unit", "_magazine", "_muzzle", "_firemode", "_targetPos", "_throwFlatTrajectory"];
if !(local _unit) exitWith {};

_unit setVariable ["zen_projectiles_throwParams", [_targetPos, _throwFlatTrajectory]];

_unit disableAI "PATH";
_unit setBehaviour "COMBAT";
private _stance = stance _unit;
if (_stance isEqualTo "STAND") then {_unit setUnitPosWeak "UP";};
if (_stance isEqualTo "CROUCH") then {_unit setUnitPosWeak "Middle";};
if (_stance isEqualTo "PRONE") then {_unit setUnitPosWeak "DOWN";};

_unit doWatch ASLToAGL _targetPos;

_unit addEventHandler ["Fired", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
	
	private _throwParams = _unit getVariable ["zen_projectiles_throwParams", []];
	if (_throwParams isEqualTo []) exitWith {};

	_throwParams params ["_targetPos", "_throwFlatTrajectory"];
	private _projectilePosASL = getPosASL _projectile;
	private _distance = _projectilePosASL distance2D _targetPos;
	private _height = _projectilePosASL # 2 - _targetPos # 2;
	private _g = 9.8066;
	//private _speed = 10 + _distance / 2 - _height / 2;
	private _speed = getNumber (configFile >> "CfgMagazines" >> _magazine >> "initSpeed");
	
	private _angle = (acos((_g * _distance^2/_speed^2-_height)/(_projectilePosASL distance _targetPos)) + atan (_distance / _height)) / 2;
	
	if !(_angle isEqualType 0) then {
		/* boost speed
		systemChat format ["d:%1, h:%2, s:%3, a:%4",_distance, _height, _speed, _angle];
		while {_speed < 20 && {!(_angle isEqualType 0)}} do {
			_speed = _speed + 1;
			_angle = (acos((_g * _distance^2/_speed^2-_height)/(_projectilePosASL distance _targetPos)) + atan (_distance / _height)) / 2;
		};
		_speed = _speed + 2;
		_angle = (acos((_g * _distance^2/_speed^2-_height)/(_projectilePosASL distance _targetPos)) + atan (_distance / _height)) / 2;
		*/
		_angle = 45;
	};
	
	if (_angle < 0) then {
		_angle = _angle + 90;
	};
	
	if (_angle > 45) then {
		//_angle = 90 - _angle;
	};
	//systemChat format ["IA:%1",_angle];
	
	private _speedY = _speed * sin _angle;
	private _speedx = _speed * cos _angle;
	
	private _vectorLOS = _projectilePosASL vectorFromTo _targetPos;
	private _vectorDir = [_projectilePosASL # 0,_projectilePosASL # 1, 0] vectorFromTo [_targetPos # 0, _targetPos # 1, 0];
	private _vectorLaunch = vectorNormalized (_vectorDir vectorAdd [0,0,_speedY/_speedX]);
	
	// check if using high angle
	if _throwFlatTrajectory then {
		private _angleLOS_Vert = acos (_vectorLOS vectorCos [0,0,1]);
		private _angleHORZ_LOS = acos (_vectorDir vectorCos _vectorLOS);
		private _angleLOS_Launch = acos (_vectorLOS vectorCos _vectorLaunch);
		private _angleLaunch_Vert = acos (_vectorLaunch vectorCos [0,0,1]);
		//systemChat format ["LV:%1, HL:%2, LA:%3, AV:%4",_angleLOS_Vert, _angleHORZ_LOS, _angleLOS_Launch, _angleLaunch_Vert];
		
		if (_angleLOS_Launch > (_angleLOS_Vert / 2)) then {
			if (_angleLOS_Vert > 90) then {
				_angleHORZ_LOS = -1 * _angleHORZ_LOS;
			};
			_angle = _angleLaunch_Vert + _angleHORZ_LOS;
			//systemChat format ["FA:%1",_angle];
			
			_speedY = _speed * sin _angle;
			_speedx = _speed * cos _angle;
			_vectorLaunch = vectorNormalized (_vectorDir vectorAdd [0,0,_speedY/_speedX]);
		};
	};
	
	private _vectorFinal = _vectorLaunch vectorMultiply _speed;
	// projectile orientation
	private _vectorSide = _vectorFinal vectorCrossProduct [0,0,-1];
	private _vectorUp = _vectorFinal vectorCrossProduct _vectorSide;
	
	_projectile setVectorDirAndUp [
		_vectorFinal,
		_vectorUp
	];
	
	// 
	_projectile setVelocity _vectorFinal;
	
	// clean up
	_unit removeEventHandler ["Fired", _thisEventHandler];
	_unit setVariable ["zen_projectiles_thrown", true];
	_unit enableAI "PATH";
	
}];

_unit setVariable ["zen_projectiles_thrown", false];
_unit setVariable ["zen_projectiles_time", diag_tickTime];

_this spawn {
	params ["_unit", "_magazine", "_muzzle", "_firemode", "_targetPos", "_throwFlatTrajectory"];
		
	private _canAdd = _unit canAdd _magazine;
	private _removedItems = [];
	if !_canAdd then {
		private _backpackContainer = backpackContainer _unit;
		if (_backpackContainer isEqualTo objNull) then {
			_unit addBackpackGlobal "B_TacticalPack_blk";
			_backpackContainer = backpackContainer _unit;
		};
		
		while {!(_unit canAddItemToBackpack _magazine)} do {
			private _item = (backpackItems _unit) # 0;
			_unit removeItemFromBackpack _item;
			_removedItems pushBack _item;
		};
	};
	_unit addMagazineGlobal _magazine;
		
	waitUntil { 
		if (_unit getVariable ["zen_projectiles_thrown", false]) exitWith {
			//systemChat "Success.";
			true
		}; 
		if (diag_tickTime - (_unit getVariable ["zen_projectiles_time", 0]) > 15) exitWith {
			//systemChat "Timed out.";
			true
		}; 
		sleep 0.01;

		private _dirUnit = getDir _unit;
		private _dirTarget = _unit getDir _targetPos;
		private _dirDiff = _dirTarget - _dirUnit;
		if (abs _dirDiff > 180) then {_dirDiff = abs _dirDiff - 360};
		if (abs _dirDiff < 35) then {
			if (abs _dirDiff > 5) then { _unit setDir _dirTarget;};
			_unit forceWeaponFire [_muzzle, _firemode];
		};
		false
	};

	_unit setVariable ["zen_projectiles_thrown", nil];
	_unit enableAI "PATH";
	
	if !_canAdd then {
		{
			_unit addItemToBackpack _x;
		} forEach _removedItems;
	};
};