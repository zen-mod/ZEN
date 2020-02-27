#include "script_component.hpp"
/*
 * Author: Dystopian
 * Creates a Zeus module and assigns the given player as its owner.
 *
 * Arguments:
 * 0: Player <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call zen_common_fnc_createZeus
 *
 * Public: No
 */

params ["_player"];

if (isNil QGVAR(createZeusDC)) then {
    GVAR(createZeusDC) = addMissionEventHandler ["HandleDisconnect", {
        params ["", "", "_owner"];

        private _zeusVarName = format [QGVAR(zeus_%1), _owner];
        private _zeus = missionNamespace getVariable _zeusVarName;

        if (!isNil "_zeus") then {
            if (!isNull _zeus) then {deleteVehicle _zeus};
            missionNamespace setVariable [_zeusVarName, nil];
        };
    }];
};

private _owner = ["#adminLogged", getPlayerUID _player] select isMultiplayer;
private _group = createGroup [sideLogic, true];
private _zeus = _group createUnit ["ModuleCurator_F", [0, 0, 0], [], 0, "NONE"];
missionNamespace setVariable [format [QGVAR(zeus_%1), _owner], _zeus];

_zeus setVariable ["owner", _owner, true];
_zeus setVariable ["Addons", 3, true];
_zeus setVariable ["BIS_fnc_initModules_disableAutoActivation", false];

_zeus setCuratorCoef ["Place", 0];
_zeus setCuratorCoef ["Delete", 0];
