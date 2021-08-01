MEASUREMENTS = [];

private _plane = createVehicle ["I_Plane_Fighter_03_CAS_F", [0, 0, 0], [], 0, "FLY"];
_plane setPosATL (_this#0 vectorAdd [-2000, 0, 300]);
_plane setVectorDirAndUp [[1, 0, 0], [0, 0, 1]];
_plane setVelocity [400/3.6, 0, 0];
private _pilot = (createGroup independent) createUnit ["I_Fighter_Pilot_F", [0, 0, 0], [], 0, "CAN_COLLIDE"]; 
_pilot moveInDriver _plane;
["zen_common_addObjects", [[_plane, _pilot]]] call CBA_fnc_serverEvent;

private _startPos = getPosASL _plane;
private _endPos = _startPos vectorAdd [2e3, 0, 0];
private _vel = [400 / 3.6, 0, 0];
private _vectDir = [1, 0, 0];
private _vectUp = [0, 0, 1];
private _startTime = time;
private _duration = (_endPos vectorDistance _startPos) / vectorMagnitude _vel;


private _handle = [
    {
        params ["_args", "_handle"];
        _args params ["_pilot", "_plane", "_startPos", "_endPos", "_vel", "_vectDir", "_vectUp", "_startTime", "_duration"];
        private _progress = (time - _startTime) / _duration;
        if (_progress > 1) exitWith {
            [_handle] call CBA_fnc_removePerFrameHandler;
            systemChat 'The End';
            deleteVehicle driver _plane;
            deleteVehicle _plane;
        };
        if (_progress >= 0.18 and (_plane getVariable ["firing", true])) then {
            _plane setVariable ["firing", false];
            [_pilot, _plane] spawn {
                params ["_pilot", "_plane"];
                for "_" from 1 to 5 do {
                    _pilot fireAtTarget [objNull, "GBU12BombLauncher_Plane_Fighter_03_F"];
                    _plane setVehicleAmmoDef 1;
                    sleep 1;
                };
            };
        };
        _plane setVelocityTransformation [_startPos, _endPos , _vel, _vel, _vectDir, _vectDir, _vectUp, _vectUp, _progress];
        _plane setVelocity _velCas;
    }, 0, [_pilot, _plane, _startPos, _endPos, _vel, _vectDir, _vectUp, _startTime, _duration]
] call CBA_fnc_addPerFrameHandler;

_plane addEventHandler ["Fired", {
    params ["", "", "", "", "", "", "_projectile"];
    private _startPos = getPosWorld _projectile;
    [
        {
            params ["_args", "_handle"];
            _args params ["_projectile", "_startPos", "_endPos"];
            if (alive _projectile) then {
                private _endPos = getPosWorld _projectile;
                _args set [2, _endPos];
                _this set [0, _args];
            } else {
                [_handle] call CBA_fnc_removePerFrameHandler;
                systemChat str (_startPos distance2D _endPos);
                MEASUREMENTS pushBack (_startPos distance2D _endPos);
            };
        }, 0, [_projectile, _startPos, _startPos]
    ] call CBA_fnc_addPerFrameHandler;
}];