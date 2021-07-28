#include "script_component.hpp"
/*
 * Author: mharis001
 * Initiates the process of remote controlling the given unit.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [unit] call zen_remote_control_fnc_start
 *
 * Public: No
 */

params ["_unit"];

_unit = effectiveCommander _unit;

_unit setVariable [VAR_OWNER, player, true];
missionNamespace setVariable [VAR_UNIT, _unit];

private _cameraPos = _unit worldToModel ASLtoAGL getPosASL curatorCamera;
private _cameraDir = _unit vectorWorldToModel vectorDir curatorCamera;

(findDisplay IDD_RSCDISPLAYCURATOR) closeDisplay IDC_CANCEL;

[{
    params ["_unit", "_cameraPos", "_cameraDir"];

    private _vehicle = vehicle _unit;
    private _vehicleRole = assignedVehicleRole _unit;

    player remoteControl _unit;

    if (cameraOn != _vehicle) then {
        _vehicle switchCamera cameraView;
    };

    private _handle = player addEventHandler ["HandleRating", {0}];
    player setVariable [QGVAR(handle), _handle];

    ["zen_remoteControlStarted", _unit] call CBA_fnc_localEvent;

    [{
        [{
            params ["_unit", "_vehicle", "_vehicleRole"];

            if (alive _unit && {vehicle _unit != _vehicle || {assignedVehicleRole _unit isNotEqualTo _vehicleRole}}) then {
                player remoteControl _unit;
                _this set [1, vehicle _unit];
                _this set [2, assignedVehicleRole _unit];
            };

            !alive _unit
            || {!alive player}
            || {!isNull curatorCamera}
            || {cameraOn == vehicle player}
            || {isNull getAssignedCuratorLogic player}
        }, {
            params ["_unit", "", "", "_cameraPos", "_cameraDir"];

            if (!isNull _unit) then {
                private _params = switch (GVAR(cameraExitPosition)) do {
                    case CAMERA_EXIT_UNCHANGED: {
                        // Do nothing. Camera position remains unchanged
                    };
                    case CAMERA_EXIT_RELATIVE: {
                        [_unit modelToWorld _cameraPos, _unit vectorModelToWorld _cameraDir]
                    };
                    case CAMERA_EXIT_RELATIVE_LIMITED: {
                        private _offset = vectorNormalized _cameraPos vectorMultiply (vectorMagnitude _cameraPos min LIMITED_CAMERA_DISTANCE);
                        [_unit modelToWorld _offset, _unit vectorModelToWorld _cameraDir]
                    };
                    case CAMERA_EXIT_ABOVE_UNIT: {
                        [_unit modelToWorld [0, 0, 10], vectorDir _unit]
                    };
                    case CAMERA_EXIT_BEHIND_UNIT: {
                        [_unit modelToWorld [0, -10, 10], _unit]
                    };
                };

                if (!isNil "_params") then {
                    private _curator = getAssignedCuratorLogic player;
                    _curator setVariable ["bis_fnc_moduleCuratorSetCamera_params", _params];
                };
            };

            objNull remoteControl _unit;
            player switchCamera cameraView;

            _unit setVariable [VAR_OWNER, nil, true];
            missionNamespace setVariable [VAR_UNIT, nil];

            private _handle = player getVariable [QGVAR(handle), -1];
            player removeEventHandler ["HandleRating", _handle];

            ["zen_remoteControlStopped", _unit] call CBA_fnc_localEvent;

            {openCuratorInterface} call CBA_fnc_execNextFrame;
        }, _this] call CBA_fnc_waitUntilAndExecute;
    }, [_unit, _vehicle, _vehicleRole, _cameraPos, _cameraDir]] call CBA_fnc_execNextFrame;
}, [_unit, _cameraPos, _cameraDir]] call CBA_fnc_execNextFrame;
