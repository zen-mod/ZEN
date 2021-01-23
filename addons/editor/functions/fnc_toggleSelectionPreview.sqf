#include "script_component.hpp"
/*
 * Author: Ampersand, Kex
 * Toggle preview of the current selection
 *
 * Arguments:
 * 0: Turn on preview <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [true] call zen_editor_fnc_toggleSelectionPreview;
 *
 * Public: No
 */

params [["_turnOn", true, [true]]];

if (_turnOn) then {
    if (isNil QGVAR(selectionIconHandler)) then {
        GVAR(selectionIconHandler) = addMissionEventHandler ["Draw3D", {
            if (curatorMouseOver isEqualTo [""]) then {
                {
                    drawIcon3D [
                        GVAR(lastModuleIcon),
                        GVAR(colour), getPosVisual _x, 1, 1, 0
                    ];
                } forEach (GVAR(lastSelection) select 0);
            };
        }];
    };
} else {
    if !(isNil QGVAR(selectionIconHandler)) then {
        [GVAR(selectionIconHandler)] call CBA_fnc_removePerFrameHandler;
        GVAR(selectionIconHandler) = nil;
    };
};
