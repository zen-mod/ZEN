#include "script_component.hpp"
/*
 * Author: mharis001
 * Opens the preferred arsenal type on the given unit.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call zen_common_fnc_openArsenal
 *
 * Public: No
 */

params ["_unit"];

if (GVAR(preferredArsenal) == 1 && {isClass (configFile >> "CfgPatches" >> "ace_arsenal")} && {!(_unit call FUNC(isRemoteControlled))}) then {
    player remoteControl _unit;
    ace_arsenal_moduleUsed = true;

    [_unit, _unit, true] call ace_arsenal_fnc_openBox;
} else {
    GVAR(arsenalCenter) = _unit;

    // Connect CBRN hoses when arsenal is closed
    if (isNil QGVAR(arsenalCbrnEH)) then {
        GVAR(arsenalCbrnEH) = [
            missionNamespace,
            "arsenalClosed", {
                GVAR(arsenalCenter) call BIN_fnc_CBRNHoseInit;
                GVAR(arsenalCenter) = nil;
            }
        ] call BIS_fnc_addScriptedEventHandler;
    };

    ["Open", [true, nil, _unit]] call BIS_fnc_arsenal;
};
