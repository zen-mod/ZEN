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

#define INTEL_CLASSES [ \
    "Land_File1_F", \
    "Land_File2_F", \
    "Land_FilePhotos_F", \
    "Land_File_research_F", \
    "Land_Document_01_F", \
    "Land_Map_F", \
    "Land_Map_unfolded_F", \
    "Land_Laptop_F", \
    "Land_Laptop_unfolded_F", \
    "Land_Laptop_Intel_01_F", \
    "Land_Laptop_device_F", \
    "Land_Laptop_02_F", \
    "Land_Laptop_02_unfolded_F", \
    "Land_laptop_03_closed_black_F", \
    "Land_laptop_03_closed_olive_F", \
    "Land_laptop_03_closed_sand_F", \
    "Land_Laptop_03_black_F", \
    "Land_Laptop_03_olive_F", \
    "Land_Laptop_03_sand_F", \
    "Land_PCSet_01_screen_F", \
    "Land_PCSet_Intel_01_F", \
    "Land_MultiScreenComputer_01_closed_olive_F", \
    "Land_MultiScreenComputer_01_olive_F", \
    "Land_MultiScreenComputer_01_closed_sand_F", \
    "Land_MultiScreenComputer_01_sand_F", \
    "Land_MobilePhone_old_F", \
    "Land_MobilePhone_smart_F", \
    "Land_Tablet_02_F", \
    "Land_Tablet_02_black_F", \
    "Land_Tablet_02_sand_F", \
    "Land_Tablet_01_F" \
]

#define SOUND_NAMES [ \
    "STR_A3_None", \
    LSTRING(ModuleCreateIntel_LaptopKeyboard), \
    LSTRING(ModuleCreateIntel_PCKeyboard), \
    LSTRING(ModuleCreateIntel_SearchBody) \
]

#define SOUND_CLASSES [ \
    [], \
    ["OMIntelGrabLaptop_01", "OMIntelGrabLaptop_02", "OMIntelGrabLaptop_03"], \
    ["OMIntelGrabPC_01", "OMIntelGrabPC_02", "OMIntelGrabPC_03"], \
    ["OMIntelGrabBody_01", "OMIntelGrabBody_02", "OMIntelGrabBody_03"] \
]

params ["_logic"];

private _object = attachedTo _logic;

private _intelParams = _object getVariable [QGVAR(intelParams), []];
_intelParams params [["_share", 0], ["_delete", true], ["_actionType", 0], ["_actionText", localize LSTRING(ModuleCreateIntel_PickUpIntel)], ["_actionSounds", []], ["_duration", 1], ["_title", ""], ["_text", ""]];

private _options = [
    ["TOOLBOX", LSTRING(ModuleCreateIntel_ShareWith), [_share, 1, 3, ["str_eval_typeside", "str_word_allgroup", "str_disp_intel_none_friendly"]]],
    ["TOOLBOX:YESNO", LSTRING(ModuleCreateIntel_DeleteOnCompletion), _delete],
    ["TOOLBOX", LSTRING(ModuleCreateIntel_ActionType), [_actionType, 1, 2, [LSTRING(ModuleCreateIntel_HoldAction), LSTRING(ModuleCreateIntel_InteractionMenu)]]],
    ["EDIT", LSTRING(ModuleCreateIntel_ActionText), _actionText],
    ["COMBO", LSTRING(ModuleCreateIntel_ActionSound), [SOUND_CLASSES, SOUND_NAMES, SOUND_CLASSES find _actionSounds]],
    ["SLIDER", LSTRING(ModuleCreateIntel_ActionDuration), [0, 60, _duration, 0]],
    ["EDIT", LSTRING(ModuleCreateIntel_IntelTitle), _title],
    ["EDIT:MULTI", LSTRING(ModuleCreateIntel_IntelText), _text]
];

if (!isClass (configFile >> "CfgPatches" >> "ace_interact_menu")) then {
    _options deleteAt 2;
};

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

    // Handle no action type option when ACE is not loaded
    private _actionType = if (count _values > 7) then {
        _values deleteAt 2
    } else {
        0 // Default to hold action
    };

    _values params ["_share", "_delete", "_actionText", "_actionSounds", "_duration", "_title", "_text"];

    _object setVariable [QGVAR(intelParams), [_share, _delete, _actionType, _actionText, _actionSounds, _duration, _title, _text], true];
    _text = _text splitString endl joinString "<br />";

    private _jipID = [QGVAR(addIntelAction), [_object, _share, _delete, _actionType, _actionText, _actionSounds, _duration, _title, _text]] call CBA_fnc_globalEventJIP;
    [_jipID, _object] call CBA_fnc_removeGlobalEventJIP;
}, {}, _object] call EFUNC(dialog,create);

deleteVehicle _logic;
