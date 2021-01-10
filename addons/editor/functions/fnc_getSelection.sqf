#include "script_component.hpp"
/*
 * Author: Ampersand, Kex
 * Retrieves and marks the entities a module is applied to.
 * This function is meant to be used inside module functions only.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * 0: List of selected objects <ARRAY>
 * 1: List of selected groups <ARRAY>
 * 2: List of selected waypoints <ARRAY>
 * 3: List of selected markers <ARRAY>
 *
 * Example:
 * (call zen_editor_fnc_getSelection) params ["_objects", "_groups"];
 *
 * Public: No
 */

BIS_fnc_curatorObjectPlaced_mouseOver params [["_entityType", ""], ["_entity", nil]];

// Retrieve selection
GVAR(savedSelection) = switch (_entityType) do {
    case "OBJECT": {
        [[_entity], [], [], []];
    };
    case "GROUP": {
        [[], [_entity], [], []];
    };
    case "ARRAY": {
        [[], [], [_entity], []];
    };
    case "STRING": {
        [[], [], [], [_entity]];
    };
    default {
        GVAR(savedSelection);
    };
};

// Turn on selection preview
GVAR(drawSavedSelectionIcons) = addMissionEventHandler ["Draw3D", {
    {
        drawIcon3D [
            GVAR(savedModuleIcon),
            GVAR(colour), getPos _x, 1, 1, 0
        ];
    } forEach (GVAR(savedSelection) select 0);
}];

// Turn off selection preview when dialog is colosed
GVAR(toggleSelectionIconEH) = [QEGVAR(dialog,close), {
    if !(isNil QGVAR(drawSavedSelectionIcons)) then {
        removeMissionEventHandler ["Draw3D", GVAR(drawSavedSelectionIcons)];
        GVAR(drawSavedSelectionIcons) = nil;
    };
    if !(isNil QGVAR(toggleSelectionIconEH)) then {
        [QEGVAR(dialog,close), GVAR(toggleSelectionIconEH)] call CBA_fnc_removeEventHandler;
        GVAR(toggleSelectionIconEH) = nil;
    };
}] call CBA_fnc_addEventHandler;

GVAR(savedSelection)
