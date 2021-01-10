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
        GVAR(selectionIconHandler) = [{
            // Show preview if mouse is not over an entity
            if (curatorMouseOver isEqualTo [""]) then {
                if (isNil QGVAR(drawSelectioIcons)) then {
                    GVAR(drawSelectioIcons) = addMissionEventHandler ["Draw3D", {
                        {
                            drawIcon3D [
                                GVAR(lastModuleIcon),
                                GVAR(colour), getPos _x, 1, 1, 0
                            ];
                        } forEach (GVAR(lastSelection) select 0);
                    }];
                };
            } else {
                if !(isNil QGVAR(drawSelectioIcons)) then {
                    removeMissionEventHandler ["Draw3D", GVAR(drawSelectioIcons)];
                    GVAR(drawSelectioIcons) = nil
                };
            };
        }, 0] call CBA_fnc_addPerFrameHandler;
    };
} else {
    if !(isNil QGVAR(selectionIconHandler)) then {
        [GVAR(selectionIconHandler)] call CBA_fnc_removePerFrameHandler;
        GVAR(selectionIconHandler) = nil;
    };
    if !(isNil QGVAR(drawSelectioIcons)) then {
        removeMissionEventHandler ["Draw3D", GVAR(drawSelectioIcons)];
        GVAR(drawSelectioIcons) = nil;
    };
};
