#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to add an intel action to an object.
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Share With (0 - Side, 1 - Group, 2 - Nobody) <NUMBER>
 * 2: Delete On Completion <BOOL>
 * 3: Action Text <STRING>
 * 4: Action Duration <NUMBER>
 * 5: Intel Title <STRING>
 * 6: Intel Text <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [notebook, 0, true, "Pick Up Intel", 1, "Intel!", "Notes..."] call zen_modules_fnc_moduleCreateIntelLocal
 *
 * Public: No
 */

#define MAX_DISTANCE 3

params ["_object", "_share", "_delete", "_actionText", "_duration", "_title", "_text"];

private _actionID = _object getVariable QGVAR(intelActionID);

if (!isNil "_actionID") then {
    [_object, _actionID] call BIS_fnc_holdActionRemove;
};

_actionID = [
    _object,
    _actionText,
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
    QUOTE(_target distance _this < MAX_DISTANCE),
    QUOTE(_target distance _caller < MAX_DISTANCE),
    {},
    {},
    {
        params ["_object", "_unit", "", "_args"];
        _args params ["_title", "_text", "_share", "_delete"];

        private _targets = switch (_share) do {
            case 0: {
                call CBA_fnc_players select {side group _x == side _unit}
            };
            case 1: {
                units _unit select {isPlayer _x}
            };
            case 2: {
                [_unit]
            };
        };

        [["\a3\ui_f\data\igui\cfg\simpletasks\types\documents_ca.paa", 1.25], [localize LSTRING(ModuleCreateIntel_IntelFound)], true] call CBA_fnc_notify;
        [QGVAR(addIntel), [_title, _text], _targets] call CBA_fnc_targetEvent;

        if (_delete) then {
            deleteVehicle _object;
        };
    },
    {},
    [_title, _text, _share, _delete],
    _duration,
    100,
    true,
    false
] call BIS_fnc_holdActionAdd;

_object setVariable [QGVAR(intelActionID), _actionID];
