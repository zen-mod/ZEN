/*
 Author: Ampersand
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
 * [_unit, _magazine, _muzzle, _firemode, _targetPos, _throwFlatTrajectory] call zen_modules_fnc_projectiles_unit;
 * [_unit, _magazine, _muzzle, _firemode, _targetPos, _throwFlatTrajectory] remoteExecCall ["zen_modules_fnc_projectiles_unit", _unit];

// Zeus selected unit throw a thing at mouse position
private _unit =  (curatorSelected # 0 # 0);
(currentThrowable _unit) params ["_magazine", "_muzzle"];
private _firemode = _muzzle;
private _targetPos = AGLToASL screenToWorld getMousePosition;
[_unit, _magazine, _muzzle, _firemode, _targetPos, true] call zen_modules_fnc_projectiles_unit

// Zeus selected unit fire launcher at mouse position
private _unit =  (curatorSelected # 0 # 0);
private _targetPos = AGLToASL screenToWorld getMousePosition;
private _weapon = secondaryWeapon _unit;
private _magazine = getArray (configFile >> "CfgWeapons" >> _weapon >> "Magazines") # 0;
private _muzzle = _weapon;
private _firemode = "Single";
[_unit, _magazine, _muzzle, _firemode, _targetPos, true] call zen_modules_fnc_projectiles_unit

 */

params ["_unit", "_magazine", "_muzzle", "_firemode", "_targetPos", "_throwFlatTrajectory"];
if !(local _unit) exitWith {};

_unit setVariable ["zen_projectiles_throwParams", _this];
//_unit setVariable ["zen_projectiles_throwParams", [_targetPos, _throwFlatTrajectory]];

_unit disableAI "PATH";
_unit setBehaviour "COMBAT";
private _stance = stance _unit;
if (_stance isEqualTo "STAND") then {_unit setUnitPosWeak "UP";};
if (_stance isEqualTo "CROUCH") then {_unit setUnitPosWeak "Middle";};
if (_stance isEqualTo "PRONE") then {_unit setUnitPosWeak "DOWN";};

_unit doWatch ASLToAGL _targetPos;

// Launcher needs timely command of forceWeaponFire
_unit addEventHandler ["AnimChanged", {
    params ["_unit", "_anim"];
    if !(_unit getVariable ["zen_projectiles_thrown", false]) then {
        // haven't fired yet
        private _throwParams = _unit getVariable ["zen_projectiles_throwParams", []];
        if (_throwParams isEqualTo []) exitWith {};
        _throwParams params ["_unit", "_magazine", "_muzzle", "_firemode", "_targetPos", "_throwFlatTrajectory"];

        // fire again
        _unit forceWeaponFire [_muzzle, _firemode];

    } else {
        // fired, clean up
        _unit removeEventHandler ["AnimChanged", _thisEventHandler];
    };
}];

// set the projectile initial velocity
_unit addEventHandler ["Fired", {
    params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

    // clean up
    _unit removeEventHandler ["Fired", _thisEventHandler];
    _unit setVariable ["zen_projectiles_thrown", true];
    _unit enableAI "PATH";

    private _throwParams = _unit getVariable ["zen_projectiles_throwParams", []];
    if (_throwParams isEqualTo []) exitWith {};
    _throwParams params ["_unit", "_magazine", "_muzzle", "_firemode", "_targetPos", "_throwFlatTrajectory"];

    // SACLOS
    if (
        isNumber (configfile >> "CfgAmmo" >> _ammo >> "manualControl") &&
        {1 == (getNumber (configfile >> "CfgAmmo" >> _ammo >> "manualControl"))}
    ) then {
        _projectile setMissileTargetPos (ASLToAGL _targetPos);
    };

    private _projectilePosASL = getPosASL _projectile;
    private _distance = _projectilePosASL distance2D _targetPos;
    private _height = _projectilePosASL # 2 - _targetPos # 2;
    private _g = 9.8066;

    private _speed = getNumber (configFile >> "CfgAmmo" >> _ammo >> "maxSpeed");
    if (_speed == 0) then  {
        _speed = getNumber (configFile >> "CfgMagazines" >> _magazine >> "initSpeed");
    };

    _maneuvrability = getNumber (configFile >> "CfgAmmo" >> _ammo >> "maneuvrability");
    private _vectorLaunch = _projectilePosASL vectorFromTo _targetPos;
    if (_maneuvrability <= 1) then {
        // physics
        private _angle = (acos((_g * _distance^2/_speed^2-_height)/(_projectilePosASL distance _targetPos)) + atan (_distance / _height)) / 2;

        // initSpeed too low to reach target
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
            // just go as far as possible
            _angle = 45;
        };

        if (_angle < 0) then { _angle = _angle + 90; };

        private _speedY = _speed * sin _angle;
        private _speedx = _speed * cos _angle;

        private _vectorLOS = _projectilePosASL vectorFromTo _targetPos;
        private _vectorDir = [_projectilePosASL # 0,_projectilePosASL # 1, 0] vectorFromTo [_targetPos # 0, _targetPos # 1, 0];
        _vectorLaunch = vectorNormalized (_vectorDir vectorAdd [0,0,_speedY/_speedX]);

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
    };

    private _vectorFinal = _vectorLaunch vectorMultiply _speed;
    // projectile orientation
    private _vectorSide = _vectorFinal vectorCrossProduct [0,0,-1];
    private _vectorUp = _vectorFinal vectorCrossProduct _vectorSide;

    _projectile setVectorDirAndUp [
        _vectorFinal,
        _vectorUp
    ];

    // set velocity
    _projectile setVelocity _vectorFinal;

    /* test draw sight and aim lines
    amp_projectiles_unit = _unit;
    amp_projectiles_projectile = _projectile;
    amp_projectiles_projectilePos = getPos _projectile;
    amp_projectiles_targetPos = ASLToAGL _targetPos;
    amp_projectiles_velocity = _vectorFinal;
    onEachFrame {
        drawLine3D [amp_projectiles_projectilePos, amp_projectiles_targetPos, [0,1,0,1]]; // sight line
        drawLine3D [amp_projectiles_targetPos, amp_projectiles_targetPos vectorAdd [0,0,10], [0,1,0,1]]; // vertical goal post
        drawLine3D [amp_projectiles_projectilePos, amp_projectiles_projectilePos vectorAdd amp_projectiles_velocity, [0,0,1,1]]; // aim line, initial angle
    };
    */
}];

_unit setVariable ["zen_projectiles_thrown", false];
_unit setVariable ["zen_projectiles_time", diag_tickTime];

// add ammo to unit
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

[{
    params ["_unit", "_magazine", "_muzzle", "_firemode", "_targetPos", "_throwFlatTrajectory"];
    // make unit turn towards target
    private _dirUnit = getDir _unit;
    private _dirTarget = _unit getDir _targetPos;
    private _dirDiff = _dirTarget - _dirUnit;
    if (abs _dirDiff > 180) then {_dirDiff = abs _dirDiff - 360};
    (abs _dirDiff < 35)
},{
    params ["_unit", "_magazine", "_muzzle", "_firemode", "_targetPos", "_throwFlatTrajectory"];
    // close enough, make unit face target
    private _dirUnit = getDir _unit;
    private _dirTarget = _unit getDir _targetPos;
    private _dirDiff = _dirTarget - _dirUnit;
    if (abs _dirDiff > 5) then { _unit setDir _dirTarget;};
    [{
        params ["_unit", "_magazine", "_muzzle", "_firemode", "_targetPos", "_throwFlatTrajectory"];
        _unit forceWeaponFire [_muzzle, _firemode];
    }, _this, 0.1] call CBA_fnc_waitAndExecute;
}, _this, 15, {}] call CBA_fnc_waitUntilAndExecute;

_unit setVariable ["zen_projectiles_thrown", nil];
_unit enableAI "PATH";

if !_canAdd then {
    {
        _unit addItemToBackpack _x;
    } forEach _removedItems;
};
