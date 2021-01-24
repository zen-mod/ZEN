#include "script_component.hpp"
/*
 * Author: mharis001
 * Populates animations and textures lists.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_garage_fnc_addListItems
 *
 * Public: No
 */

private _display = findDisplay IDD_DISPLAY;

// Get animation and texture data for current vehicle
private _vehicleData = [GVAR(center)] call FUNC(getVehicleData);
_vehicleData params ["_vehicleAnimations", "_vehicleTextures"];
private _vehicleType = typeOf GVAR(center);

private _fnc_addToList = {
    params ["_ctrlList", "_variant", "_displayName", "_isChecked"];

    if (_isChecked isEqualType false) then {_isChecked = parseNumber _isChecked};

    private _index = _ctrlList lbAdd _displayName;
    private _dataVar = str _index;

    _ctrlList lbSetData [_index, _dataVar];
    _ctrlList lbSetValue [_index, _isChecked];
    _ctrlList lbSetTooltip [_index, _displayName];
    _ctrlList lbSetPicture [_index, [ICON_UNCHECKED, ICON_CHECKED] select _isChecked];

    _ctrlList setVariable [_dataVar, _variant];
};

// Add items to animations list
private _ctrlListAnimations = _display displayCtrl IDC_LIST_ANIMATIONS;
{
    _x params ["_configName", "_displayName"];

    private _source = getText (configFile >> "CfgVehicles" >> _vehicleType >> "animationSources" >> _configName >> "source");
    private _phase = switch (_source) do {
        case "door": {
            _vehicle doorPhase _configName;
        };
        case "user": {
            _vehicle animationSourcePhase _configName;
        };
        default {
            _vehicle animationPhase _configName;
        };
    };
    private _isChecked = _phase >= 0.5;
    [_ctrlListAnimations, _configName, _displayName, _isChecked] call _fnc_addToList;
} forEach _vehicleAnimations;

// Add items to textures list
private _ctrlListTextures = _display displayCtrl IDC_LIST_TEXTURES;
private _sourcesConfig = configOf GVAR(center) >> "textureSources";
private _currentTextures = getObjectTextures GVAR(center) apply {toLower _x};
{
    _x params ["_variant", "_displayName"];

    private _textures = if (_variant isEqualType "") then {
         getArray (_sourcesConfig >> _variant >> "textures");
    } else {
        _variant;
    };
    private _isChecked = true;
    if (count _textures == count _currentTextures) then {
        {if !((_currentTextures select _forEachIndex) in toLower _x) exitWith {_isChecked = false}} forEach _textures;
    } else {
        _isChecked = false;
    };

    [_ctrlListTextures, _variant, _displayName, _isChecked] call _fnc_addToList;
} forEach _vehicleTextures;

// Set font height and sort both lists
{
    _x ctrlSetFontHeight POS_H(0.8); // Todo: setting for font height?
    lbSort _x;
} forEach [_ctrlListAnimations, _ctrlListTextures];
