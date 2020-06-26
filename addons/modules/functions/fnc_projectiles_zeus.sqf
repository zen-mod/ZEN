/*
 Author: Ampers
 Check if projectile can reach target, then remote executes on the unit.

 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Magazine <STRING>
 * 2: Muzzle <STRING>
 * 3: Fire Mode <STRING>
 * 4: Target Pos ASL <ARRAY>
 *
 * Return Value:
 * NONE

 * Example:
 * [_unit, _magazine, _muzzle, _firemode, _mousePosASL] call tft_zeus_fnc_zeusProjectile;
 */

params ["_unit", "_magazine", "_muzzle", "_firemode", "_mousePosASL"];

// get location of target in zeus cam view
private _position0 = positionCameraToWorld [0, 0, 0];
private _intersections = lineIntersectsSurfaces [AGLToASL _position0, _mousePosASL, cameraOn, objNull, true, 1, "GEOM"];

private _targetPos = _mousePosASL;
if !(_intersections isEqualTo []) then {
    _targetPos = _intersections # 0 # 0;
    //systemChat str _targetPos;
};

// check if can reach
private _speed = getNumber (configFile >> "CfgAmmo" >> (getText (configFile >> "CfgMagazines" >> _magazine >> "ammo")) >> "maxSpeed");
if (_speed == 0) then  {
    _speed = getNumber (configFile >> "CfgMagazines" >> _magazine >> "initSpeed");
};

private _speed = getNumber (configFile >> "CfgMagazines" >> _magazine >> "initSpeed");
private _eyePos = eyePos _unit;
private _distance = _eyePos distance2D _targetPos;
private _height = _eyePos # 2 - _targetPos # 2;
private _g = 9.8066;
private _angle = (acos((_g * _distance^2/_speed^2-_height)/(_eyePos distance _targetPos)) + atan (_distance / _height)) / 2;

if !(_angle isEqualType 0) then {
    // if can't reach, notify zeus. Will try to throw as far as possible
    [objNull, format ["Can't reach target! D:%1 H:%2", _distance, _height]] call bis_fnc_showCuratorFeedbackMessage;
};

if (isNil "zen_projectiles_throwFlatTrajectory") then {zen_projectiles_throwFlatTrajectory = true;};

// trace bullet
//BIS_tracedShooter = nil;
//[_unit, 1] call BIS_fnc_traceBullets;

[_unit, _magazine, _muzzle, _firemode, _targetPos, zen_projectiles_throwFlatTrajectory] remoteExecCall ["zen_modules_fnc_projectiles_unit", _unit];

true
