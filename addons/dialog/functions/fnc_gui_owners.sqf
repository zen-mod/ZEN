#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the OWNERS content control.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Row Index <NUMBER>
 * 2: Current Value <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 0, [1, [west], [], []]] call zen_dialog_fnc_gui_owners
 *
 * Public: No
 */

params ["_controlsGroup", "_rowIndex", "_currentValue"];
_currentValue params ["_sides", "_groups", "_players", "_tab"];

_controlsGroup setVariable [QGVAR(params), [_groups, _players]];

private _fnc_onTabClick = {
    params ["_ctrlButton"];
    (_ctrlButton getVariable QGVAR(params)) params ["_currentValue"];

    private _controlsGroup = ctrlParentControlsGroup _ctrlButton;
    private _selectedTab = IDCS_ROW_OWNERS_BTNS find ctrlIDC _ctrlButton;

    {
        private _ctrlButton = _controlsGroup controlsGroupCtrl _x;
        _ctrlButton ctrlEnable (_forEachIndex != _selectedTab);
    } forEach IDCS_ROW_OWNERS_BTNS;

    {
        private _ctrlTab = _controlsGroup controlsGroupCtrl _x;
        _ctrlTab ctrlShow (_forEachIndex == _selectedTab);
    } forEach IDCS_ROW_OWNERS_TABS;

    ctrlSetFocus (_controlsGroup controlsGroupCtrl (IDC_ROW_OWNERS_TABS select _selectedTab));

    _currentValue set [3, _selectedTab];
};

{
    private _ctrlButton = _controlsGroup controlsGroupCtrl _x;
    _ctrlButton setVariable [QGVAR(params), [_currentValue]];
    _ctrlButton ctrlAddEventHandler ["ButtonClick", _fnc_onTabClick];

    if (_forEachIndex == _tab) then {
        _ctrlButton call _fnc_onTabClick;
    };
} forEach IDCS_ROW_OWNERS_BTNS;

private _fnc_onSideClick = {
    params ["_ctrlSide"];
    (_ctrlSide getVariable QGVAR(params)) params ["_sides", "_side", "_color"];

    private _scale = 1;

    if (_side in _sides) then {
        _sides deleteAt (_sides find _side);
        _color set [3, 0.5];
    } else {
        _sides pushBack _side;
        _color set [3, 1];
        _scale = 1.2;
    };

    _ctrlSide ctrlSetTextColor _color;
    [_ctrlSide, _scale, 0.1] call BIS_fnc_ctrlSetScale;
};

{
    private _ctrlSide = _controlsGroup controlsGroupCtrl _x;
    private _color = [_forEachIndex] call BIS_fnc_sideColor;
    private _side  = [_forEachIndex] call BIS_fnc_sideType;

    _ctrlSide setVariable [QGVAR(params), [_sides, _side, _color]];
    _ctrlSide ctrlAddEventHandler ["ButtonClick", _fnc_onSideClick];

    _ctrlSide ctrlSetActiveColor _color;

    if (_side in _sides) then {
        [_ctrlSide, 1.2, 0] call BIS_fnc_ctrlSetScale;
    } else {
        _color set [3, 0.5];
    };

    _ctrlSide ctrlSetTextColor _color;
} forEach IDCS_ROW_OWNERS_SIDES;

private _ctrlGroupList = _controlsGroup controlsGroupCtrl IDC_ROW_OWNERS_GROUPS_LIST;
_ctrlGroupList ctrlAddEventHandler ["LBSelChanged", {
    params ["_ctrlGroupList", "_index"];

    private _controlsGroup = ctrlParentControlsGroup ctrlParentControlsGroup _ctrlGroupList;
    (_controlsGroup getVariable QGVAR(params)) params ["_groups"];

    private _group = _ctrlGroupList getVariable (_ctrlGroupList lbData _index);

    if (_group in _groups) then {
        _ctrlGroupList lbSetPicture [_index, ICON_UNCHECKED];
        _groups deleteAt (_groups find _group);
    } else {
        _ctrlGroupList lbSetPicture [_index, ICON_CHECKED];
        _groups pushBack _group;
    };
}];

private _ctrlGroupSearch = _controlsGroup controlsGroupCtrl IDC_ROW_OWNERS_GROUPS_SEARCH;
_ctrlGroupSearch ctrlAddEventHandler ["KeyUp", {
    params ["_ctrlGroupSearch"];

    private _controlsGroup = ctrlParentControlsGroup ctrlParentControlsGroup _ctrlGroupSearch;
    _controlsGroup call (_controlsGroup getVariable QFUNC(updateGroupList));
}];

private _ctrlGroupButton = _controlsGroup controlsGroupCtrl IDC_ROW_OWNERS_GROUPS_BTN;
_ctrlGroupButton ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlGroupButton"];

    private _controlsGroup = ctrlParentControlsGroup ctrlParentControlsGroup _ctrlGroupButton;

    private _ctrlGroupSearch = _controlsGroup controlsGroupCtrl IDC_ROW_OWNERS_GROUPS_SEARCH;
    _ctrlGroupSearch ctrlSetText "";

    _controlsGroup call (_controlsGroup getVariable QFUNC(updateGroupList));
}];

private _fnc_updateGroupList = {
    params ["_controlsGroup"];
    (_controlsGroup getVariable QGVAR(params)) params ["_groups"];

    private _ctrlList = _controlsGroup controlsGroupCtrl IDC_ROW_OWNERS_GROUPS_LIST;
    private _ctrlSearch = _controlsGroup controlsGroupCtrl IDC_ROW_OWNERS_GROUPS_SEARCH;

    private _filter = toLower ctrlText _ctrlSearch;
    lbClear _ctrlList;

    {
        if (units _x findIf {isPlayer _x} != -1 && {_filter in toLower groupID _x}) then {
            private _index = _ctrlList lbAdd groupID _x;
            _ctrlList lbSetPicture [_index, [ICON_UNCHECKED, ICON_CHECKED] select (_x in _groups)];
            _ctrlList lbSetPictureRight [_index, [_x] call EFUNC(common,getSideIcon)];

            private _tooltip = units _x select {isPlayer _x} apply {name _x} joinString "\n";
            _ctrlList lbSetTooltip [_index, _tooltip];

            _ctrlList lbSetData [_index, str _index];
            _ctrlList setVariable [str _index, _x];
        };
    } forEach allGroups;

    if (lbSize _ctrlList == 0) then {
        _ctrlSearch ctrlSetTextColor [0.9, 0, 0, 1];
    } else {
        _ctrlSearch ctrlSetTextColor [1, 1, 1, 1];
    };
};

_controlsGroup setVariable [QFUNC(updateGroupList), _fnc_updateGroupList];
_controlsGroup call _fnc_updateGroupList;

private _ctrlPlayerList = _controlsGroup controlsGroupCtrl IDC_ROW_OWNERS_PLAYERS_LIST;
_ctrlPlayerList ctrlAddEventHandler ["LBSelChanged", {
    params ["_ctrlPlayerList", "_index"];

    private _controlsGroup = ctrlParentControlsGroup ctrlParentControlsGroup _ctrlPlayerList;
    (_controlsGroup getVariable QGVAR(params)) params ["", "_players"];

    private _player = _ctrlPlayerList getVariable (_ctrlPlayerList lbData _index);

    if (_player in _players) then {
        _ctrlPlayerList lbSetPicture [_index, ICON_UNCHECKED];
        _players deleteAt (_players find _player);
    } else {
        _ctrlPlayerList lbSetPicture [_index, ICON_CHECKED];
        _players pushBack _player;
    };
}];

private _ctrlPlayerSearch = _controlsGroup controlsGroupCtrl IDC_ROW_OWNERS_PLAYERS_SEARCH;
_ctrlPlayerSearch ctrlAddEventHandler ["KeyUp", {
    params ["_ctrlPlayerSearch"];

    private _controlsGroup = ctrlParentControlsGroup ctrlParentControlsGroup _ctrlPlayerSearch;
    _controlsGroup call (_controlsGroup getVariable QFUNC(updatePlayerList));
}];

private _ctrlPlayerButton = _controlsGroup controlsGroupCtrl IDC_ROW_OWNERS_PLAYERS_BTN;
_ctrlPlayerButton ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlPlayerButton"];

    private _controlsGroup = ctrlParentControlsGroup ctrlParentControlsGroup _ctrlPlayerButton;

    private _ctrlPlayerSearch = _controlsGroup controlsGroupCtrl IDC_ROW_OWNERS_PLAYERS_SEARCH;
    _ctrlPlayerSearch ctrlSetText "";

    _controlsGroup call (_controlsGroup getVariable QFUNC(updatePlayerList));
}];

private _fnc_updatePlayerList = {
    params ["_controlsGroup"];
    (_controlsGroup getVariable QGVAR(params)) params ["", "_players"];

    private _ctrlList = _controlsGroup controlsGroupCtrl IDC_ROW_OWNERS_PLAYERS_LIST;
    private _ctrlSearch = _controlsGroup controlsGroupCtrl IDC_ROW_OWNERS_PLAYERS_SEARCH;

    private _filter = toLower ctrlText _ctrlSearch;
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
        _ctrlSearch ctrlSetTextColor [0.9, 0, 0, 1];
    } else {
        _ctrlSearch ctrlSetTextColor [1, 1, 1, 1];
    };
};

_controlsGroup setVariable [QFUNC(updatePlayerList), _fnc_updatePlayerList];
_controlsGroup call _fnc_updatePlayerList;
