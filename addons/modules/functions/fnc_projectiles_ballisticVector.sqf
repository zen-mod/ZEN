/*
 Author: Ampersand
 Find the

 * Arguments:
 * 0: Projectile <OBJECT>
 * 1: Target Pos ASL <ARRAY>
 * 2: Speed <NUMBER><OPTIONAL>
 * 3: useFlatTrajectory <BOOLEAN><OPTIONAL>
 *
 * Return Value:
 * 0: VectorDirAndUp <ARRAY>
 *
 * Speed <= 0 will boost speed to whatever is necessary to reach target pos.
 *
 * Example:
 * [_projectile, _targetPos, _throwFlatTrajectory] call zen_modules_fnc_projectiles_ballisticVector;

// Launch Zeus selection at mouse position
private _projectile =  (curatorSelected # 0 # 0);
private _targetPos = AGLToASL screenToWorld getMousePosition;
private _vector = [_projectile, _targetPos] execVM "fnc_projectiles_ballisticVector.sqf";
_projectile setVelocity = _vector;

 */

params ["_projectile", "_targetPos", ["_speed", 0, [0]], ["_throwFlatTrajectory", true, [true]]];

private _projectilePosASL = getPosASL _projectile;
private _distance = _projectilePosASL distance2D _targetPos;
private _height = _projectilePosASL # 2 - _targetPos # 2;
private _g = 9.8066;
private _angle = "";

// physics
if (_speed > 0) then {
    _angle = (acos((_g * _distance^2/_speed^2-_height)/(_projectilePosASL distance _targetPos)) + atan (_distance / _height)) / 2;
};

// initSpeed too low to reach target
if !(_angle isEqualType 0) then {

    if (_speed > 0) then {
        // just go as far as possible
        _angle = 45;
    } else {
        // boost speed
        while {_speed < 10000 && {!(_angle isEqualType 0)}} do {
            _speed = _speed + 1;
            _angle = (acos((_g * _distance^2/_speed^2-_height)/(_projectilePosASL distance _targetPos)) + atan (_distance / _height)) / 2;
        };
        _speed = _speed + 2;
        _angle = (acos((_g * _distance^2/_speed^2-_height)/(_projectilePosASL distance _targetPos)) + atan (_distance / _height)) / 2;
    };
};

if (_angle < 0) then { _angle = _angle + 90; };

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

[_vectorFinal,_vectorUp]
