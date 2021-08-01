MEASUREMENTS = [];
POSITIONS = [];
POSITIONS_2 = [];


ZEN_common_fnc_estimateBezierArcLength = {
    // Reference: https://stackoverflow.com/a/37862545/15141722
    params ["_p0", "_p1", "_p2", "_p3"];
    private _chord = _p0 vectorDistance _p3;
    private _cont_net = (_p0 vectorDistance _p1) + (_p1 vectorDistance _p2) + (_p2 vectorDistance _p3);
    (_cont_net + _chord) / 2
};



ZEN_common_fnc_getLineIntersection = {
    // Reference: https://stackoverflow.com/a/2316923/15141722
    params ["_p0", "_v0", "_p1", "_v1"];
    private _vecNormLen = vectorMagnitude (_v0 vectorCrossProduct _v1);
    if (_vecNormLen == 0) exitWith {};
    private _t0 = vectorMagnitude ((_p1 vectorDiff _p0) vectorCrossProduct _v1) / _vecNormLen;
    (_v0 vectorMultiply _t0) vectorAdd _p0
};



test_fnc_traj02 = {
    params ["_pilot", "_plane"];

    private _startPos = getPosASL _plane;
    private _prevPos = _startPos;
    private _endPos = _startPos vectorAdd [120, 0, -100];
    private _vel = [500 / 3.6, 0, 0];
    private _startVectDir = [1000, 0, -2500];
    private _startVectUp = [2500, 0, 1000];
    private _endVectDir = [1, 0, 0];
    private _endVectUp = [0, 0, 1];
    private _intPos = [_startPos, _startVectDir, _endPos, _endVectDir] call ZEN_common_fnc_getLineIntersection;
    private _startTime = time;
    private _duration = ([_startPos, _intPos, _intPos, _endPos] call ZEN_common_fnc_estimateBezierArcLength) / vectorMagnitude _vel;

    private _handle = [
        {
            params ["_args", "_handle"];
            _args params ["_pilot", "_plane", "_startPos", "_prevPos", "_endPos", "_intPos", "_vel", "_startVectUp", "_endVectUp", "_startTime", "_duration"];
            private _progress = (time - _startTime) / _duration;
            if (_progress > 1) exitWith {
                [_handle] call CBA_fnc_removePerFrameHandler;
                systemChat "SWITCH 02";
                _plane spawn {
                    sleep 10;
                    systemChat 'THE END';
                    deleteVehicle driver _this;
                    deleteVehicle _this;
                };
            };
            private _curPos = _progress bezierInterpolation [_startPos, _intPos, _endPos];
            private _curVectDir = _curPos vectorDiff _prevPos;
            _args set [3, _curPos];
            _this set [0, _args];
            _plane setVelocityTransformation [_curPos, _curPos , _vel, _vel, _curVectDir, _curVectDir, _startVectUp, _endVectUp, _progress];
            _plane setVelocity _velCas;
            POSITIONS pushBack getPosASL _plane;
        }, 0, [_pilot, _plane, _startPos, _prevPos, _endPos, _intPos, _vel, _startVectUp, _endVectUp, _startTime, _duration]
    ] call CBA_fnc_addPerFrameHandler;
};



test_fnc_traj01 = {
    params ["_pilot", "_plane"];

    private _startPos = getPosASL _plane;
    private _endPos = _startPos vectorAdd [880, 0, -2200];
    private _vel = [500 / 3.6, 0, 0];
    private _vectDir = [1000, 0, -2500];
    private _vectUp = [2500, 0, 1000];
    private _startTime = time;
    private _duration = (_endPos vectorDistance _startPos) / vectorMagnitude _vel;

    private _handle = [
        {
            params ["_args", "_handle"];
            _args params ["_pilot", "_plane", "_startPos", "_endPos", "_vel", "_vectDir", "_vectUp", "_startTime", "_duration"];
            private _progress = (time - _startTime) / _duration;
            if (_progress > 1) exitWith {
                [_handle] call CBA_fnc_removePerFrameHandler;
                systemChat "SWITCH 01";
                [_pilot, _plane] call test_fnc_traj02;
            };
            if (_progress >= 0.95) then {
                _pilot fireAtTarget [objNull, "GBU12BombLauncher_Plane_Fighter_03_F"];
            };
            _plane setVelocityTransformation [_startPos, _endPos , _vel, _vel, _vectDir, _vectDir, _vectUp, _vectUp, _progress];
            _plane setVelocity _velCas;
            POSITIONS pushBack getPosASL _plane;
        }, 0, [_pilot, _plane, _startPos, _endPos, _vel, _vectDir, _vectUp, _startTime, _duration]
    ] call CBA_fnc_addPerFrameHandler;
};



private _plane = createVehicle ["I_Plane_Fighter_03_CAS_F", [0, 0, 0], [], 0, "FLY"];
_plane setPosATL (_this#0 vectorAdd [-1000, 0, 2500]);
_plane setVectorDirAndUp [[0.34, 0, -0.94], [0.94, 0, 0.34]];
_plane setVelocity [500/3.6, 0, 0];
private _pilot = (createGroup independent) createUnit ["I_Fighter_Pilot_F", [0, 0, 0], [], 0, "CAN_COLLIDE"]; 
_pilot moveInDriver _plane;
["zen_common_addObjects", [[_plane, _pilot]]] call CBA_fnc_serverEvent;
[_pilot, _plane] call test_fnc_traj01;

