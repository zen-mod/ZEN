#include "script_component.hpp"
/*
 * Author: mharis001
 * Opens a dialog for entering the category and name of a composition.
 *
 * Arguments:
 * 0: Mode <STRING>
 * 1: Composition <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["create", ["", "", []]] call zen_compositions_fnc_openDisplay
 *
 * Public: No
 */

params ["_mode", "_composition"];

createDialog QGVAR(display);
private _display = uiNamespace getVariable QGVAR(display);

// Add previously entered category names to list for QOL
private _ctrlList = _display displayCtrl IDC_DISPLAY_LIST;
_ctrlList ctrlAddEventHandler ["LBSelChanged", {
    params ["_ctrlList", "_index"];

    private _display = ctrlParent _ctrlList;
    private _ctrlCategory = _display displayCtrl IDC_DISPLAY_CATEGORY;
    _ctrlCategory ctrlSetText (_ctrlList lbText _index);

    _display call (_display getVariable QFUNC(verify));
}];

{
    _ctrlList lbAdd _x;
} forEach keys GET_COMPOSITIONS;

// Verify entered values (not empty, unique category and name combination)
_display setVariable [QFUNC(verify), {
    params ["_display"];

    private _ctrlCategory = _display displayCtrl IDC_DISPLAY_CATEGORY;
    private _ctrlName     = _display displayCtrl IDC_DISPLAY_NAME;
    private _ctrlButtonOK = _display displayCtrl IDC_OK;

    private _category = ctrlText _ctrlCategory;
    private _name = ctrlText _ctrlName;

    if (_category == "") exitWith {
        _ctrlButtonOK ctrlEnable false;
        _ctrlButtonOK ctrlSetTooltip localize LSTRING(CategoryCannotBeEmpty);
    };

    if (_name == "") exitWith {
        _ctrlButtonOK ctrlEnable false;
        _ctrlButtonOK ctrlSetTooltip localize LSTRING(NameCannotBeEmpty);
    };

    private _enabled = isNil {GET_COMPOSITION(_category,_name)};
    private _tooltip = if (_enabled) then {""} else {localize LSTRING(CompositionAlreadyExists)};

    _ctrlButtonOK ctrlEnable _enabled;
    _ctrlButtonOK ctrlSetTooltip _tooltip;
}];

// Verify every time inputs are changed
private _fnc_update = {
    params ["_ctrl"];

    private _display = ctrlParent _ctrl;
    _display call (_display getVariable QFUNC(verify));
};

private _ctrlCategory = _display displayCtrl IDC_DISPLAY_CATEGORY;
_ctrlCategory ctrlAddEventHandler ["KeyDown", _fnc_update];
_ctrlCategory ctrlAddEventHandler ["KeyUp", _fnc_update];

private _ctrlName = _display displayCtrl IDC_DISPLAY_NAME;
_ctrlName ctrlAddEventHandler ["KeyDown", _fnc_update];
_ctrlName ctrlAddEventHandler ["KeyUp", _fnc_update];

// Set the title based on the mode
private _title = [LSTRING(EditCustomComposition), LSTRING(CreateCustomComposition)] select (_mode == "create");
private _ctrlTitle = _display displayCtrl IDC_DISPLAY_TITLE;
_ctrlTitle ctrlSetText localize _title;

// Set the current composition category and name
_composition params ["_category", "_name", "_data"];
_ctrlCategory ctrlSetText _category;
_ctrlName ctrlSetText _name;

// Run initial verification of values
_display call (_display getVariable QFUNC(verify));

private _ctrlButtonOK = _display displayCtrl IDC_OK;

[_ctrlButtonOK, "ButtonClick", {
    params ["_ctrlButtonOK"];
    _thisArgs params ["_mode", "_data"];

    private _display = ctrlParent _ctrlButtonOK;
    private _ctrlCategory = _display displayCtrl IDC_DISPLAY_CATEGORY;
    private _ctrlName     = _display displayCtrl IDC_DISPLAY_NAME;

    // Set the new composition category and name
    private _category = ctrlText _ctrlCategory;
    private _name = ctrlText _ctrlName;

    // Add the composition to saved data
    private _compositions = GET_COMPOSITIONS;
    private _categoryHash = _compositions getOrDefault [_category, createHashMap, true];
    _categoryHash set [_name, _data];

    if (_mode == "edit") then {
        // In edit mode, remove the old composition from the tree
        [true] call FUNC(removeFromTree);
    };

    SET_COMPOSITIONS(_compositions);

    // Add the new/updated composition to the tree
    GVAR(treeAdditions) pushBack [_category, _name, +_data];
    [findDisplay IDD_RSCDISPLAYCURATOR] call FUNC(processTreeAdditions);

    saveProfileNamespace;
}, [_mode, _data]] call CBA_fnc_addBISEventHandler;
