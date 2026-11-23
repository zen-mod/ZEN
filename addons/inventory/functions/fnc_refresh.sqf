#include "script_component.hpp"
/*
 * Author: mharis001
 * Refreshes the list by populating it with items.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_inventory_fnc_refresh
 *
 * Public: No
 */

params ["_display"];

private _ctrlList = _display displayCtrl IDC_LIST;
lnbClear _ctrlList;

// Allow for items to be searched using class names by adding the 'class ' prefix
private _filter = ctrlText (_display displayCtrl IDC_SEARCH_BAR);
private _filterByClass = _filter select [0, 6] == "class ";

if (_filterByClass) then {
    _filter = _filter select [6];
};

if (_filter != "") then {
    // Escape regex characters, TODO: switch to CBA function when that's a thing
    _filter = _filter regexReplace ["[.?*+^$[\]\\(){}|-]/gio", "\\$&"];
    _filter = ".*?" + (_filter splitString " " joinString ".*?") + ".*?/io";
} else {
    _filter = ".*?/io"
};

private _cfgMagazines = configFile >> "CfgMagazines";
private _cfgWeapons   = configFile >> "CfgWeapons";

// Function that adds a row to the list for the given item
private _fnc_addRow = {
    params ["_item", "_config", "_count", "_name", "_tooltip", ["_weapon", []]];

    // Handle searching items by display name or class name
    private _text = [_name, _item] select _filterByClass;

    if (_text regexMatch _filter) then {
        private _picture = getText (_config >> "picture");
        private _alpha = [ALPHA_NONE, ALPHA_SOME] select (_count > 0);

        private _index = _ctrlList lnbAddRow ["", _name, str _count];
        _ctrlList lnbSetPicture [[_index, 0], _picture];
        _ctrlList lnbSetTooltip [[_index, 0], _tooltip];
        _ctrlList lnbSetColor   [[_index, 1], [1, 1, 1, _alpha]];
        _ctrlList lnbSetColor   [[_index, 2], [1, 1, 1, _alpha]];
        _ctrlList lnbSetValue   [[_index, 2], _count];
        _ctrlList lnbSetData    [[_index, 0], _item];

        // Store the full weapon items array so attachments and magazines are kept when modifying
        if (_weapon isNotEqualTo []) then {
            _ctrlList lnbSetData [[_index, 1], str _weapon];
        };
    };
};

// Function that populates the list with the specified items using the amounts from the given cargo array
private _fnc_populate = {
    params ["_cargo", "_items"];
    _cargo params ["_types", "_counts"];

    // Add items from cargo if none are given (used for current cargo category)
    if (isNil "_items") then {
        _items = _types;
    };

    {
        private _config = [_x] call CBA_fnc_getItemConfig;
        private _name = getText (_config >> "displayName");
        private _tooltip = format ["%1\n%2", _name, _x];
        private _count = _counts param [_types find _x, 0];

        [_x, _config, _count, _name, _tooltip] call _fnc_addRow;
    } forEach _items;
};

// Function that populates the list with weapons, each unique configuration of attachments
// and magazines is shown as its own row so it can be inspected and modified separately
private _fnc_populateWeapons = {
    params ["_cargo", "_items"];
    _cargo params ["_types", "_counts"];

    private _weapons = if (isNil "_items") then {
        +_types
    } else {
        // Plain versions of all weapons in the category, followed by configured ones in cargo
        private _plain = _items apply {[_x, "", "", "", [], [], ""]};

        _plain + (_types select {
            _x params ["_weapon"];
            _weapon in _items && {_x isNotEqualTo [_weapon, "", "", "", [], [], ""]}
        })
    };

    {
        _x params ["_weapon", "_muzzle", "_pointer", "_optic", "_primaryMagazine", "_secondaryMagazine", "_bipod"];

        private _config = _cfgWeapons >> _weapon;
        private _weaponName = getText (_config >> "displayName");
        private _details = [];
        private _tooltip = [_weaponName, _weapon];

        {
            if (_x != "") then {
                private _attachmentName = getText (_cfgWeapons >> _x >> "displayName");
                _details pushBack _attachmentName;
                _tooltip pushBack format ["%1 (%2)", _attachmentName, _x];
            };
        } forEach [_optic, _pointer, _muzzle, _bipod];

        {
            _x params [["_magazine", ""], ["_ammo", 0]];

            if (_magazine != "") then {
                private _config = _cfgMagazines >> _magazine;
                private _magazineName = getText (_config >> "displayName");
                _details pushBack _magazineName;
                _tooltip pushBack format ["%1 [%2/%3] (%4)", _magazineName, _ammo, getNumber (_config >> "count"), _magazine];
            };
        } forEach [_primaryMagazine, _secondaryMagazine];

        private _name = if (_details isEqualTo []) then {
            _weaponName
        } else {
            format ["%1 (%2)", _weaponName, _details joinString ", "]
        };

        private _count = _counts param [_types find _x, 0];

        [_weapon, _config, _count, _name, _tooltip joinString "\n", _x] call _fnc_addRow;
    } forEach _weapons;
};

if (_display getVariable [QGVAR(weapon), ""] == "") then {
    private _category = lbCurSel (_display displayCtrl IDC_CATEGORY) - 1;

    if (_category == -1) then {
        // No specific category, add all items in current cargo
        {
            if (_forEachIndex == CARGO_WEAPONS) then {
                [_x] call _fnc_populateWeapons;
            } else {
                [_x] call _fnc_populate;
            };
        } forEach (_display getVariable QGVAR(cargo));
    } else {
        // Specific category selected, get items to add from the master items list
        private _cargo = _display call FUNC(getCargo);
        private _items = uiNamespace getVariable QGVAR(itemsList) select _category;

        if (_category in [ITEMS_PRIMARY, ITEMS_SECONDARY, ITEMS_HANDGUN, ITEMS_BINOCULARS]) then {
            [_cargo, _items] call _fnc_populateWeapons;
        } else {
            [_cargo, _items] call _fnc_populate;
        };
    };
} else {
    // In weapon specific mode, add items compatible with the selected weapon
    private _cargo = _display call FUNC(getCargo);
    private _items = _display call FUNC(getWeaponItems);
    [_cargo, _items] call _fnc_populate;
};

// Refresh the list's sorting
private _ctrlSorting = _display displayCtrl IDC_SORTING;
_ctrlSorting lnbSetCurSelRow -1;

// Update other display elements
_display call FUNC(update);
