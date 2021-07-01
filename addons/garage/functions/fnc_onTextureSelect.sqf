#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles selecting a texture. Called from LBSelChanged event.
 *
 * Arguments:
 * 0: Textures list <CONTROL>
 * 1: Selected index <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 0] call zen_garage_fnc_onTextureSelect
 *
 * Public: No
 */

params ["_ctrlListTextures", "_selectedIndex"];

// Uncheck all textures
for "_i" from 0 to (lbSize _ctrlListTextures - 1) do {
    _ctrlListTextures lbSetPicture [_i, ICON_UNCHECKED];
};

// Check selected texture
_ctrlListTextures lbSetPicture [_selectedIndex, ICON_CHECKED];

// Update vehicle textures
[QEGVAR(common,initVehicle), [GVAR(center), [_ctrlListTextures lbData _selectedIndex, 1]], GVAR(center)] call CBA_fnc_targetEvent;
