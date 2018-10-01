/*
 * Author: mharis001
 * Initializes the "Teleport Players" Zeus module display.
 *
 * Arguments:
 * 0: teleportPlayers controls group <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_modules_fnc_ui_teleportPlayers
 *
 * Public: No
 */
#include "script_component.hpp"

#define TAB_BUTTON_IDCS [\
    IDC_TELEPORTPLAYERS_BUTTON_SIDES,\
    IDC_TELEPORTPLAYERS_BUTTON_GROUPS,\
    IDC_TELEPORTPLAYERS_BUTTON_PLAYERS\
]

#define TAB_GROUP_IDCS [\
    IDC_TELEPORTPLAYERS_TAB_SIDES,\
    IDC_TELEPORTPLAYERS_TAB_GROUPS,\
    IDC_TELEPORTPLAYERS_TAB_PLAYERS\
]

#define SIDE_IDCS [\
    IDC_TELEPORTPLAYERS_OPFOR,\
    IDC_TELEPORTPLAYERS_BLUFOR,\
    IDC_TELEPORTPLAYERS_INDEPENDENT,\
    IDC_TELEPORTPLAYERS_CIVILIAN\
]

params ["_control"];

// Generic init
private _display = ctrlParent _control;
private _ctrlButtonOK = _display displayCtrl IDC_OK;
private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
TRACE_1("Logic Object",_logic);

_control ctrlRemoveAllEventHandlers "SetFocus";

// Set selection variables
_display setVariable [QGVAR(selectedSides), []];
_display setVariable [QGVAR(selectedGroups), []];
_display setVariable [QGVAR(selectedPlayers), []];

// Handle switching tabs
private _fnc_onTabClick = {
    params ["_ctrlButton"];

    private _display = ctrlParent _ctrlButton;

    // Get tab index of button
    private _tab = _ctrlButton getVariable QGVAR(tab);

    // Disable clicked button, enable others
    {
        private _ctrlButton = _display displayCtrl _x;
        _ctrlButton ctrlEnable (_tab != _forEachIndex);
    } forEach TAB_BUTTON_IDCS;

    // Show selected tab, hide others
    {
        private _ctrlTab = _display displayCtrl _x;
        private _showTab = _tab == _forEachIndex;
        _ctrlTab ctrlEnable _showTab;
        _ctrlTab ctrlShow _showTab;
    } forEach TAB_GROUP_IDCS;
};

{
    private _ctrlButton = _display displayCtrl _x;
    _ctrlButton setVariable [QGVAR(tab), _forEachIndex];
    _ctrlButton ctrlSetText toUpper ctrlText _ctrlButton;
    _ctrlButton ctrlAddEventHandler ["ButtonClick", _fnc_onTabClick];
} forEach TAB_BUTTON_IDCS;

// Set default tab to players list
(_display displayCtrl IDC_TELEPORTPLAYERS_BUTTON_PLAYERS) call _fnc_onTabClick;

// Init side buttons with colors and scales
private _fnc_onSideClick = {
    params ["_ctrlSide"];

    // Get selected sides
    private _display = ctrlParent _ctrlSide;
    private _selected = _display getVariable QGVAR(selectedSides);

    // Get side color
    private _color = _ctrlSide getVariable QGVAR(color);
    private _scale = 1;

    // Update selected sides list
    private _side = [ctrlIDC _ctrlSide - IDC_TELEPORTPLAYERS_OPFOR] call BIS_fnc_sideType;
    if (_side in _selected) then {
        _selected deleteAt (_selected find _side);
        _color set [3, 0.5];
    } else {
        _selected pushBack _side;
        _color set [3, 1];
        _scale = 1.2;
    };

    // Update color and scale
    _ctrlSide ctrlSetTextColor _color;
    [_ctrlSide, _scale, 0.1] call BIS_fnc_ctrlSetScale;
};

{
    private _ctrlSide = _display displayCtrl _x;
    private _color = [_forEachIndex] call BIS_fnc_sideColor;
    _ctrlSide setVariable [QGVAR(color), _color];
    _ctrlSide ctrlSetActiveColor _color;

    _color set [3, 0.5];
    _ctrlSide ctrlSetTextColor _color;

    _ctrlSide ctrlAddEventHandler ["ButtonClick", _fnc_onSideClick];
} forEach SIDE_IDCS;

// Init group list
private _allGroups = allGroups select {units _x findIf {isPlayer _x} > -1}; // Get groups with at least one player
_display setVariable [QGVAR(allGroups), _allGroups]; // Cant store groups in lbData

private _fnc_updateGroupList = {
    params ["_display"];

    private _ctrlGroupList = _display displayCtrl IDC_TELEPORTPLAYERS_GROUPS;
    private _ctrlGroupSearch = _display displayCtrl IDC_TELEPORTPLAYERS_GROUPS_SEARCH;

    // Get filter and currently selected groups
    private _filter = toLower ctrlText _ctrlGroupSearch;
    private _selected = _display getVariable QGVAR(selectedGroups);

    // Rebuild player list
    lbClear _ctrlGroupList;

    {
        if (groupID _x find _filter > -1) then {
            private _index = _ctrlGroupList lbAdd groupID _x;
            _ctrlGroupList lbSetValue [_index, _forEachIndex];
            _ctrlGroupList lbSetPicture [_index, [ICON_UNCHECKED, ICON_CHECKED] select (_forEachIndex in _selected)];
            _ctrlGroupList lbSetPictureRight [_index, GET_SIDE_ICON(_x)];

            private _tooltip = (units _x apply {name _x}) joinString "\n";
            _ctrlGroupList lbSetTooltip [_index, _tooltip];
        };
    } forEach (_display getVariable QGVAR(allGroups));

    // Alert user to no search matches
    if (lbSize _ctrlGroupList == 0) then {
        _ctrlGroupSearch ctrlSetTextColor [0.95, 0, 0, 1];
    } else {
        _ctrlGroupSearch ctrlSetTextColor [1, 1, 1, 1];
    };
};

_display setVariable [QFUNC(updateGroupList), _fnc_updateGroupList];
_display call _fnc_updateGroupList;

private _ctrlGroupList = _display displayCtrl IDC_TELEPORTPLAYERS_GROUPS;
_ctrlGroupList ctrlAddEventHandler ["LBSelChanged", {
    params ["_ctrlGroupList", "_index"];

    private _display = ctrlParent _ctrlGroupList;
    private _selected = _display getVariable QGVAR(selectedGroups);
    private _value = _ctrlGroupList lbValue _index;

    // Update icon and add/remove from selected list
    if (_value in _selected) then {
        _ctrlGroupList lbSetPicture [_index, ICON_UNCHECKED];
        _selected deleteAt (_selected find _value);
    } else {
        _ctrlGroupList lbSetPicture [_index, ICON_CHECKED];
        _selected pushBack _value;
    };
}];

private _ctrlGroupSearch = _display displayCtrl IDC_TELEPORTPLAYERS_GROUPS_SEARCH;
_ctrlGroupSearch ctrlAddEventHandler ["KeyUp", {
    params ["_ctrlGroupSearch"];

    // Refresh group list
    private _display = ctrlParent _ctrlGroupSearch;
    _display call (_display getVariable QFUNC(updateGroupList));
}];

private _ctrlGroupButton = _display displayCtrl IDC_TELEPORTPLAYERS_GROUPS_BUTTON;
_ctrlGroupButton ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlGroupButton"];

    private _display = ctrlParent _ctrlGroupButton;

    // Clear serach box
    private _ctrlGroupSearch = _display displayCtrl IDC_TELEPORTPLAYERS_GROUPS_SEARCH;
    _ctrlGroupSearch ctrlSetText "";

    // Refresh group list
    _display call (_display getVariable QFUNC(updateGroupList));
}];

// Init player list
private _fnc_updatePlayerList = {
    params ["_display"];

    private _ctrlPlayerList = _display displayCtrl IDC_TELEPORTPLAYERS_PLAYERS;
    private _ctrlPlayerSearch = _display displayCtrl IDC_TELEPORTPLAYERS_PLAYERS_SEARCH;

    // Get filter and currently selected players
    private _filter = toLower ctrlText _ctrlPlayerSearch;
    private _selected = _display getVariable QGVAR(selectedPlayers);

    // Rebuild player list
    lbClear _ctrlPlayerList;

    {
        if (alive _x && {toLower name _x find _filter > -1}) then {
            private _index = _ctrlPlayerList lbAdd name _x;
            _ctrlPlayerList lbSetData [_index, getPlayerUID _x];
            _ctrlPlayerList lbSetPicture [_index, [ICON_UNCHECKED, ICON_CHECKED] select (getPlayerUID _x in _selected)];
            _ctrlPlayerList lbSetPictureRight [_index, GET_SIDE_ICON(_x)];
        };
    } forEach call CBA_fnc_players;

    // Alert user to no search matches
    if (lbSize _ctrlPlayerList == 0) then {
        _ctrlPlayerSearch ctrlSetTextColor [0.95, 0, 0, 1];
    } else {
        _ctrlPlayerSearch ctrlSetTextColor [1, 1, 1, 1];
    };
};

_display setVariable [QFUNC(updatePlayerList), _fnc_updatePlayerList];
_display call _fnc_updatePlayerList;

private _ctrlPlayerList = _display displayCtrl IDC_TELEPORTPLAYERS_PLAYERS;
_ctrlPlayerList ctrlAddEventHandler ["LBSelChanged", {
    params ["_ctrlPlayerList", "_index"];

    private _display = ctrlParent _ctrlPlayerList;
    private _selected = _display getVariable QGVAR(selectedPlayers);
    private _playerUID = _ctrlPlayerList lbData _index;

    // Update icon and add/remove from selected list
    if (_playerUID in _selected) then {
        _ctrlPlayerList lbSetPicture [_index, ICON_UNCHECKED];
        _selected deleteAt (_selected find _playerUID);
    } else {
        _ctrlPlayerList lbSetPicture [_index, ICON_CHECKED];
        _selected pushBack _playerUID;
    };
}];

private _ctrlPlayerSearch = _display displayCtrl IDC_TELEPORTPLAYERS_PLAYERS_SEARCH;
_ctrlPlayerSearch ctrlAddEventHandler ["KeyUp", {
    params ["_ctrlPlayerSearch"];

    // Refresh player list
    private _display = ctrlParent _ctrlPlayerSearch;
    _display call (_display getVariable QFUNC(updatePlayerList));
}];

private _ctrlPlayerButton = _display displayCtrl IDC_TELEPORTPLAYERS_PLAYERS_BUTTON;
_ctrlPlayerButton ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlPlayerButton"];

    private _display = ctrlParent _ctrlPlayerButton;

    // Clear serach box
    private _ctrlPlayerSearch = _display displayCtrl IDC_TELEPORTPLAYERS_PLAYERS_SEARCH;
    _ctrlPlayerSearch ctrlSetText "";

    // Refresh player list
    _display call (_display getVariable QFUNC(updatePlayerList));
}];

private _fnc_onUnload = {
    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    if (isNull _logic) exitWith {};

    deleteVehicle _logic;
};

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    if (isNull _display) exitWith {};

    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    if (isNull _logic) exitWith {};

    // Get selected units based on active tab
    private _activeTab = TAB_BUTTON_IDCS findIf {!ctrlEnabled (_display displayCtrl _x)};
    private _units = switch (_activeTab) do {
        case 0: {
            private _selected = _display getVariable QGVAR(selectedSides);
            call CBA_fnc_players select {side _x in _selected};
        };
        case 1: {
            private _selected = _display getVariable QGVAR(selectedGroups);
            private _allGroups = _display getVariable QGVAR(allGroups);
            private _temp = [];
            {
                _temp append units (_allGroups select _x);
            } forEach _selected;
            _temp
        };
        case 2: {
            private _selected = _display getVariable QGVAR(selectedPlayers);
            _selected apply {_x call BIS_fnc_getUnitByUID};
        };
    };

    // Teleport units, check for attached vehicle
    private _attached = attachedTo _logic;
    private _position = if (isNull _attached) then {_logic modelToWorld [0, 0, 0]} else {_attached};

    {
        [QGVAR(moveToRespawnPosition), [_x, _position], _x] call CBA_fnc_targetEvent;
    } forEach _units;

    deleteVehicle _logic;
};

_display displayAddEventHandler ["Unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
