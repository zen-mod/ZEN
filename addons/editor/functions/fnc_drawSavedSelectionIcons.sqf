#include "script_component.hpp"
/*
 * Author: Ampersand
 * Draws icons over saved selection entities.
 *
 * Arguments:
 * 0: Icon <STRING>
 *
 * Return Value:
 * 0: Draw3D mission EH handle <NUMBER>
 *
 * Example:
 * ["\a3\ui_f\data\Map\VehicleIcons\iconVirtual_ca.paa"] call zen_editor_fnc_drawSavedSelectionIcons
 *
 * Public: No
 */

if (GVAR(savedSelection) select 0 isEqualTo []) exitWith {
    -1
};

params ["_icon"];

private _mehID = addMissionEventHandler ["Draw3D", {
    {
        drawIcon3D [
            "\a3\ui_f\data\Map\VehicleIcons\iconVirtual_ca.paa",
            GVAR(colour), getPos _x, 1, 1, 0
        ];
    } forEach (GVAR(savedSelection) select 0);
}];

_mehID
