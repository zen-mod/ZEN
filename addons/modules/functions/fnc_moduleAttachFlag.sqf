#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to attach a flag to an object.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleAttachFlag
 *
 * Public: No
 */

params ["_logic"];

private _object = attachedTo _logic;
deleteVehicle _logic;

if (isNull _object) exitWith {
    [LSTRING(NoObjectSelected)] call EFUNC(common,showMessage);
};

if !(alive _object) exitWith {
    [LSTRING(OnlyAlive)] call EFUNC(common,showMessage);
};

if !(_object isKindOf "AllVehicles") exitWith {
    [LSTRING(OnlyVehicles)] call EFUNC(common,showMessage);
};

private _flagsCache = +(uiNamespace getVariable QGVAR(flagsCache));
_flagsCache params ["_flagTextures", "_displayNames"];

// Add flag textures as combo icons
private _comboLabels = [];
{
    _comboLabels pushBack [_x, "", _flagTextures select _forEachIndex];
} forEach _displayNames;

// Special handling to give "None" entry an icon
_comboLabels select 0 set [2, QPATHTOF(ui\flag_none_ca.paa)];

// Get current flag texture index
private _currentIndex = (_flagTextures find getForcedFlagTexture _object) max 0;

[LSTRING(ModuleAttachFlag), [
    ["LIST", LSTRING(ModuleAttachFlag_Type), [_flagTextures, _comboLabels, _currentIndex, 10], true]
], {
    params ["_dialogValues", "_object"];
    _dialogValues params ["_flagTexture"];

    _object forceFlagTexture _flagTexture;
}, {}, _object] call EFUNC(dialog,create);
