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

private _dataVar = _ctrlListTextures lbData _selectedIndex;
private _texture = _ctrlListTextures getVariable _dataVar;

// Update vehicle textures
[GVAR(center), _texture] call EFUNC(common,customizeVehicle);
