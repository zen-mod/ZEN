#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the given owners control.
 * The sides, groups, and players arrays are modified by reference.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Default Value <ARRAY>
 *   0: Sides <ARRAY>
 *   1: Groups <ARRAY>
 *   2: Players <ARRAY>
 *   3: Tab <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, [[], [], [], 0]] call zen_common_fnc_initOwnersControl
 *
 * Public: No
 */

params [["_controlsGroup", controlNull, [controlNull]], ["_defaultValue", [], [[]]]];
_defaultValue params [["_sides", [], [[]]], ["_groups", [], [[]]], ["_players", [], [[]]], ["_tab", 2, [0]]];

_controlsGroup setVariable [QGVAR(value), [_sides, _groups, _players, _tab]];

// Initialize tab buttons, change tabs when buttons are clicked
private _fnc_tabClicked = {
    params ["_ctrlButton"];

    private _controlsGroup = ctrlParentControlsGroup _ctrlButton;
    private _tab = IDCS_OWNERS_BTNS find ctrlIDC _ctrlButton;

    {
        private _ctrlButton = _controlsGroup controlsGroupCtrl _x;
        _ctrlButton ctrlEnable (_forEachIndex != _tab);
    } forEach IDCS_OWNERS_BTNS;

    {
        private _ctrlTab = _controlsGroup controlsGroupCtrl _x;
        _ctrlTab ctrlShow (_forEachIndex == _tab);
    } forEach IDCS_OWNERS_TABS;

    private _value = _controlsGroup getVariable QGVAR(value);
    _value set [3, _tab];
};

{
    private _ctrlButton = _controlsGroup controlsGroupCtrl _x;
    _ctrlButton ctrlAddEventHandler ["ButtonClick", _fnc_tabClicked];

    if (_forEachIndex == _tab) then {
        _ctrlButton call _fnc_tabClicked;
    };
} forEach IDCS_OWNERS_BTNS;

// Initialize sides tab, sides array is modified by reference
private _ctrlTabSides = _controlsGroup controlsGroupCtrl IDC_OWNERS_TAB_SIDES;
[_ctrlTabSides, _sides] call FUNC(initSidesControl);

// Initialize groups tab, groups array is modified by reference
private _ctrlTabGroups = _controlsGroup controlsGroupCtrl IDC_OWNERS_TAB_GROUPS;
_ctrlTabGroups setVariable [QGVAR(groups), _groups];

// Handle checking/unchecking groups by clicking list items
private _ctrlGroupList = _ctrlTabGroups controlsGroupCtrl IDC_OWNERS_GROUPS_LIST;
_ctrlGroupList ctrlAddEventHandler ["LBSelChanged", {
    params ["_ctrlGroupList", "_index"];

    private _ctrlTabGroups = ctrlParentControlsGroup _ctrlGroupList;
    private _groups = _ctrlTabGroups getVariable QGVAR(groups);

    private _group = _ctrlGroupList getVariable (_ctrlGroupList lbData _index);

    if (_group in _groups) then {
        _ctrlGroupList lbSetPicture [_index, ICON_UNCHECKED];
        _groups deleteAt (_groups find _group);
    } else {
        _ctrlGroupList lbSetPicture [_index, ICON_CHECKED];
        _groups pushBack _group;
    };
}];

// Refresh groups list when the search field changes
private _ctrlGroupSearchBar = _ctrlTabGroups controlsGroupCtrl IDC_OWNERS_GROUPS_SEARCH_BAR;
_ctrlGroupSearchBar ctrlAddEventHandler ["KeyUp", {
    params ["_ctrlGroupSearchBar"];

    private _ctrlTabGroups = ctrlParentControlsGroup _ctrlGroupSearchBar;
    _ctrlTabGroups call (_ctrlTabGroups getVariable QFUNC(updateGroupList));
}];

// Clear group search when the search bar is right clicked
_ctrlGroupSearchBar ctrlAddEventHandler ["MouseButtonClick", {
    params ["_ctrlGroupSearchBar", "_button"];

    if (_button != 1) exitWith {};

    _ctrlGroupSearchBar ctrlSetText "";
    ctrlSetFocus _ctrlGroupSearchBar;

    private _ctrlTabGroups = ctrlParentControlsGroup _ctrlGroupSearchBar;
    _ctrlTabGroups call (_ctrlTabGroups getVariable QFUNC(updateGroupList));
}];

// Clear group search when the search button is clicked
private _ctrlGroupButtonSearch = _ctrlTabGroups controlsGroupCtrl IDC_OWNERS_GROUPS_SEARCH_BTN;
_ctrlGroupButtonSearch ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlGroupButtonSearch"];

    private _ctrlTabGroups = ctrlParentControlsGroup _ctrlGroupButtonSearch;

    private _ctrlGroupSearchBar = _ctrlTabGroups controlsGroupCtrl IDC_OWNERS_GROUPS_SEARCH_BAR;
    _ctrlGroupSearchBar ctrlSetText "";
    ctrlSetFocus _ctrlGroupSearchBar;

    _ctrlTabGroups call (_ctrlTabGroups getVariable QFUNC(updateGroupList));
}];

// Uncheck all groups when the uncheck button is clicked
private _ctrlGroupButtonUncheck = _ctrlTabGroups controlsGroupCtrl IDC_OWNERS_GROUPS_UNCHECK;
_ctrlGroupButtonUncheck ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlGroupButtonUncheck"];

    private _ctrlTabGroups = ctrlParentControlsGroup _ctrlGroupButtonUncheck;

    private _groups = _ctrlTabGroups getVariable QGVAR(groups);
    _groups resize 0;

    _ctrlTabGroups call (_ctrlTabGroups getVariable QFUNC(updateGroupList));
}];

// Check all groups when the check button is clicked
private _ctrlGroupButtonCheck = _ctrlTabGroups controlsGroupCtrl IDC_OWNERS_GROUPS_CHECK;
_ctrlGroupButtonCheck ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlGroupButtonCheck"];

    private _ctrlTabGroups = ctrlParentControlsGroup _ctrlGroupButtonCheck;

    private _groups = _ctrlTabGroups getVariable QGVAR(groups);
    _groups resize 0;
    _groups append (allGroups select {units _x findIf {isPlayer _x} != -1});

    _ctrlTabGroups call (_ctrlTabGroups getVariable QFUNC(updateGroupList));
}];

private _fnc_updateGroupList = {
    params ["_ctrlTabGroups"];

    private _groups = _ctrlTabGroups getVariable QGVAR(groups);

    private _ctrlSearch = _ctrlTabGroups controlsGroupCtrl IDC_OWNERS_GROUPS_SEARCH_BAR;
    private _filter = toLower ctrlText _ctrlSearch;

    private _ctrlList = _ctrlTabGroups controlsGroupCtrl IDC_OWNERS_GROUPS_LIST;
    lbClear _ctrlList;

    {
        if (units _x findIf {isPlayer _x} != -1 && {_filter in toLower groupId _x}) then {
            private _index = _ctrlList lbAdd groupId _x;
            _ctrlList lbSetPicture [_index, [ICON_UNCHECKED, ICON_CHECKED] select (_x in _groups)];
            _ctrlList lbSetPictureRight [_index, [_x] call EFUNC(common,getSideIcon)];

            private _tooltip = units _x select {isPlayer _x} apply {name _x} joinString "\n";
            _ctrlList lbSetTooltip [_index, _tooltip];

            _ctrlList lbSetData [_index, str _index];
            _ctrlList setVariable [str _index, _x];
        };
    } forEach allGroups;

    lbSort _ctrlList;

    if (lbSize _ctrlList == 0) then {
        _ctrlSearch ctrlSetTooltip localize LSTRING(NoGroupsFound);
        _ctrlSearch ctrlSetTextColor [0.9, 0, 0, 1];
    } else {
        _ctrlSearch ctrlSetTooltip "";
        _ctrlSearch ctrlSetTextColor [1, 1, 1, 1];
    };
};

_ctrlTabGroups setVariable [QFUNC(updateGroupList), _fnc_updateGroupList];
_ctrlTabGroups call _fnc_updateGroupList;

// Initialize players tab, players array is modified by reference
private _ctrlTabPlayers = _controlsGroup controlsGroupCtrl IDC_OWNERS_TAB_PLAYERS;
_ctrlTabPlayers setVariable [QGVAR(players), _players];

// Handle checking/unchecking players by clicking list items
private _ctrlPlayerList = _ctrlTabPlayers controlsGroupCtrl IDC_OWNERS_PLAYERS_LIST;
_ctrlPlayerList ctrlAddEventHandler ["LBSelChanged", {
    params ["_ctrlPlayerList", "_index"];

    private _ctrlTabPlayers = ctrlParentControlsGroup _ctrlPlayerList;
    private _players = _ctrlTabPlayers getVariable QGVAR(players);

    private _player = _ctrlPlayerList getVariable (_ctrlPlayerList lbData _index);

    if (_player in _players) then {
        _ctrlPlayerList lbSetPicture [_index, ICON_UNCHECKED];
        _players deleteAt (_players find _player);
    } else {
        _ctrlPlayerList lbSetPicture [_index, ICON_CHECKED];
        _players pushBack _player;
    };
}];

// Refresh groups list when the search field changes
private _ctrlPlayerSearchBar = _ctrlTabPlayers controlsGroupCtrl IDC_OWNERS_PLAYERS_SEARCH_BAR;
_ctrlPlayerSearchBar ctrlAddEventHandler ["KeyUp", {
    params ["_ctrlPlayerSearchBar"];

    private _ctrlTabPlayers = ctrlParentControlsGroup _ctrlPlayerSearchBar;
    _ctrlTabPlayers call (_ctrlTabPlayers getVariable QFUNC(updatePlayerList));
}];

// Clear group search when the search bar is right clicked
_ctrlPlayerSearchBar ctrlAddEventHandler ["MouseButtonClick", {
    params ["_ctrlPlayerSearchBar", "_button"];

    if (_button != 1) exitWith {};

    _ctrlPlayerSearchBar ctrlSetText "";
    ctrlSetFocus _ctrlPlayerSearchBar;

    private _ctrlTabPlayers = ctrlParentControlsGroup _ctrlPlayerSearchBar;
    _ctrlTabPlayers call (_ctrlTabPlayers getVariable QFUNC(updatePlayerList));
}];

// Clear group search when the search button is clicked
private _ctrlPlayerButtonSearch = _ctrlTabPlayers controlsGroupCtrl IDC_OWNERS_PLAYERS_SEARCH_BTN;
_ctrlPlayerButtonSearch ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlPlayerButtonSearch"];

    private _ctrlTabPlayers = ctrlParentControlsGroup _ctrlPlayerButtonSearch;

    private _ctrlPlayerSearchBar = _ctrlTabPlayers controlsGroupCtrl IDC_OWNERS_PLAYERS_SEARCH_BAR;
    _ctrlPlayerSearchBar ctrlSetText "";
    ctrlSetFocus _ctrlPlayerSearchBar;

    _ctrlTabPlayers call (_ctrlTabPlayers getVariable QFUNC(updatePlayerList));
}];

// Uncheck all groups when the uncheck button is clicked
private _ctrlPlayerButtonUncheck = _ctrlTabPlayers controlsGroupCtrl IDC_OWNERS_PLAYERS_UNCHECK;
_ctrlPlayerButtonUncheck ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlPlayerButtonUncheck"];

    private _ctrlTabPlayers = ctrlParentControlsGroup _ctrlPlayerButtonUncheck;

    private _players = _ctrlTabPlayers getVariable QGVAR(players);
    _players resize 0;

    _ctrlTabPlayers call (_ctrlTabPlayers getVariable QFUNC(updatePlayerList));
}];

// Check all groups when the check button is clicked
private _ctrlPlayerButtonCheck = _ctrlTabPlayers controlsGroupCtrl IDC_OWNERS_PLAYERS_CHECK;
_ctrlPlayerButtonCheck ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlPlayerButtonCheck"];

    private _ctrlTabPlayers = ctrlParentControlsGroup _ctrlPlayerButtonCheck;

    private _players = _ctrlTabPlayers getVariable QGVAR(players);
    _players resize 0;
    _players append (call CBA_fnc_players select {alive _x});

    _ctrlTabPlayers call (_ctrlTabPlayers getVariable QFUNC(updatePlayerList));
}];

private _fnc_updatePlayerList = {
    params ["_ctrlTabPlayers"];

    private _players = _ctrlTabPlayers getVariable QGVAR(players);

    private _ctrlSearch = _ctrlTabPlayers controlsGroupCtrl IDC_OWNERS_PLAYERS_SEARCH_BAR;
    private _filter = toLower ctrlText _ctrlSearch;

    private _ctrlList = _ctrlTabPlayers controlsGroupCtrl IDC_OWNERS_PLAYERS_LIST;
    lbClear _ctrlList;

    {
        if (alive _x && {_filter in toLower name _x}) then {
            private _index = _ctrlList lbAdd name _x;
            _ctrlList lbSetPicture [_index, [ICON_UNCHECKED, ICON_CHECKED] select (_x in _players)];
            _ctrlList lbSetPictureRight [_index, [_x] call EFUNC(common,getSideIcon)];

            _ctrlList lbSetData [_index, str _index];
            _ctrlList setVariable [str _index, _x];
        };
    } forEach call CBA_fnc_players;

    lbSort _ctrlList;

    if (lbSize _ctrlList == 0) then {
        _ctrlSearch ctrlSetTooltip localize LSTRING(NoPlayersFound);
        _ctrlSearch ctrlSetTextColor [0.9, 0, 0, 1];
    } else {
        _ctrlSearch ctrlSetTooltip "";
        _ctrlSearch ctrlSetTextColor [1, 1, 1, 1];
    };
};

_ctrlTabPlayers setVariable [QFUNC(updatePlayerList), _fnc_updatePlayerList];
_ctrlTabPlayers call _fnc_updatePlayerList;
