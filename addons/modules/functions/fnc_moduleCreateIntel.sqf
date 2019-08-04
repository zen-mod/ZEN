#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to create an intel object.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleCreateIntel
 *
 * Public: No
 */

#define INTEL_CLASSES ["Land_File1_F", "Land_File2_F", "Land_FilePhotos_F", "Land_File_research_F", "Land_Document_01_F", "Land_Map_F", "Land_Map_unfolded_F", "Land_Laptop_unfolded_F", "Land_Laptop_F", "Land_Laptop_device_F", "Land_MobilePhone_smart_F", "Land_Tablet_02_F", "Land_Tablet_01_F"]

params ["_logic"];

private _object = attachedTo _logic;

private _intelParams = _object getVariable [QGVAR(intelParams), []];
_intelParams params [["_share", 0], ["_delete", true], ["_actionText", localize LSTRING(ModuleCreateIntel_PickUpIntel)], ["_duration", 1], ["_title", ""], ["_text", ""]];

private _options = [
    ["TOOLBOX", LSTRING(ModuleCreateIntel_ShareWith), [_share, 1, 3, ["str_eval_typeside", "str_word_allgroup", "str_disp_intel_none_friendly"]]],
    ["TOOLBOX:YESNO", LSTRING(ModuleCreateIntel_DeleteOnCompletion), _delete],
    ["EDIT", LSTRING(ModuleCreateIntel_ActionText), _actionText],
    ["SLIDER", LSTRING(ModuleCreateIntel_ActionDuration), [0, 60, _duration, 0]],
    ["EDIT", LSTRING(ModuleCreateIntel_IntelTitle), _title],
    ["EDIT:MULTI", LSTRING(ModuleCreateIntel_IntelText), _text]
];

if (isNull _object) then {
    private _names = INTEL_CLASSES apply {getText (configFile >> "CfgVehicles" >> _x >> "displayName")};

    // Push front
    reverse _options;
    _options pushBack ["COMBO", LSTRING(ModuleCreateIntel_ObjectType), [INTEL_CLASSES, _names, 0]];
    reverse _options;

    _object = getPosATL _logic;
} else {
    {
        _x set [3, true];
    } forEach _options;
};

[LSTRING(ModuleCreateIntel), _options, {
    params ["_values", "_object"];

    if (_object isEqualType []) then {
        _object = createVehicle [_values deleteAt 0, _object, [], 0, "NONE"];
        [QEGVAR(common,addObjects), [[_object]]] call CBA_fnc_serverEvent;
    };

    _object setVariable [QGVAR(intelParams), _values, true];

    _values params ["_share", "_delete", "_actionText", "_duration", "_title", "_text"];
    _text = _text splitString endl joinString "<br />";

    private _jipID = [QGVAR(moduleCreateIntel), [_object, _share, _delete, _actionText, _duration, _title, _text]] call CBA_fnc_globalEventJIP;
    [_jipID, _object] call CBA_fnc_removeGlobalEventJIP;
}, {}, _object] call EFUNC(dialog,create);

deleteVehicle _logic;
