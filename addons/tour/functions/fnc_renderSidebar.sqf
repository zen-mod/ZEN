#include "script_component.hpp"
/*
 * Author: mharis001
 * Renders the sidebar, listing the new features from the given releases grouped by release.
 * Without releases, all features are listed alphabetically, tagging those that are new in the latest release.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Releases <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY, []] call zen_tour_fnc_renderSidebar
 *
 * Public: No
 */

params ["_display", "_releases"];

private _previousControls = _display getVariable [QGVAR(sidebarControls), []];

{
    ctrlDelete _x;
} forEach _previousControls;

// Returns the features from the given release
private _fnc_getFeatures = {
    params ["_release"];

    getArray (_release >> "features") apply {
        configFile >> QGVAR(features) >> _x
    } select {
        isClass _x
    }
};

private _isWhatsNew = _releases isNotEqualTo [];
private _groups = [];
private _newFeatures = [];

if (_isWhatsNew) then {
    _groups = _releases apply {
        private _heading = format [LLSTRING(NewIn), getText (_x >> "version")];
        private _features = [_x] call _fnc_getFeatures;
        [_heading, _features]
    };
} else {
    private _features = [
        configProperties [configFile >> QGVAR(features), "isClass _x"],
        [],
        {getText (_x >> "title")}
    ] call BIS_fnc_sortBy;

    _groups = [["", _features]];

    private _latest = [] call FUNC(getReleases) param [0, configNull];
    _newFeatures = [_latest] call _fnc_getFeatures;
};

private _title = [LLSTRING(Features), LLSTRING(WhatsNew)] select _isWhatsNew;
private _ctrlTitle = _display displayCtrl IDC_TITLE_TEXT;
_ctrlTitle ctrlSetText toUpper _title;

// The sidebar's footer has a button to browse all features while showing what's new
private _ctrlButton = _display displayCtrl IDC_BUTTON_ALL_FEATURES;
_ctrlButton ctrlSetText toUpper LLSTRING(ViewAllFeatures);
_ctrlButton ctrlShow _isWhatsNew;

private _ctrlSidebar = _display displayCtrl IDC_SIDEBAR;
private _textX = POS_W(SIDEBAR_INSET);
private _textW = POS_W(SIDEBAR_WIDTH - 2 * SIDEBAR_INSET);
private _controls = [];
private _features = [];
private _entries = createHashMap;
private _posY = POS_H(CONTENT_PADDING);

{
    _x params ["_heading", "_groupFeatures"];

    // Features from multiple releases are only listed under the newest one
    _groupFeatures = _groupFeatures select {!(_x in _entries)};

    if (_groupFeatures isEqualTo []) then {
        continue;
    };

    // Groups are spaced apart from the previous one
    if (_controls isNotEqualTo []) then {
        _posY = _posY + POS_H(SIDEBAR_GROUP_SPACING);
    };

    if (_heading != "") then {
        private _ctrlHeading = _display ctrlCreate [QGVAR(label), -1, _ctrlSidebar];
        _ctrlHeading ctrlSetPosition [_textX, _posY, _textW, POS_H(SIDEBAR_HEADING_HEIGHT)];
        _ctrlHeading ctrlSetText toUpper _heading;
        _ctrlHeading ctrlCommit 0;

        _controls pushBack _ctrlHeading;
        _posY = _posY + POS_H(SIDEBAR_HEADING_HEIGHT);
    };

    {
        private _ctrlEntry = _display ctrlCreate [QGVAR(entry), -1, _ctrlSidebar];
        _ctrlEntry ctrlSetPosition [0, _posY, POS_W(SIDEBAR_WIDTH), POS_H(ENTRY_HEIGHT)];
        _ctrlEntry ctrlCommit 0;

        private _ctrlBackground = _ctrlEntry controlsGroupCtrl IDC_ENTRY_BACKGROUND;
        private _ctrlAccent = _ctrlEntry controlsGroupCtrl IDC_ENTRY_ACCENT;

        {
            _x ctrlSetPixelPrecision PIXEL_PRECISION;
        } forEach [_ctrlEntry, _ctrlBackground, _ctrlAccent];

        // New features are tagged, leaving less room for their title
        private _isNew = _x in _newFeatures;
        private _ctrlTag = _ctrlEntry controlsGroupCtrl IDC_ENTRY_TAG;
        _ctrlTag ctrlShow _isNew;

        private _ctrlTitle = _ctrlEntry controlsGroupCtrl IDC_ENTRY_TITLE;
        private _titleW = [_textW, _textW - POS_W(ENTRY_TAG_WIDTH)] select _isNew;
        _ctrlTitle ctrlSetText getText (_x >> "title");
        _ctrlTitle ctrlSetPositionW _titleW;
        _ctrlTitle ctrlCommit 0;

        private _ctrlMouse = _ctrlEntry controlsGroupCtrl IDC_ENTRY_MOUSE;
        _ctrlMouse setVariable [QGVAR(feature), _x];

        _controls pushBack _ctrlEntry;
        _features pushBack _x;
        _entries set [_x, _ctrlEntry];
        _posY = _posY + POS_H(ENTRY_HEIGHT);
    } forEach _groupFeatures;
} forEach _groups;

// Keep entries and their tags clear of the scrollbar when the list does not fit
if (_posY > ctrlPosition _ctrlSidebar select 3) then {
    {
        _y ctrlSetPositionW POS_W(SIDEBAR_WIDTH - SCROLLBAR_WIDTH);
        _y ctrlCommit 0;

        private _ctrlTag = _y controlsGroupCtrl IDC_ENTRY_TAG;
        private _tagX = ctrlPosition _ctrlTag select 0;
        _ctrlTag ctrlSetPositionX (_tagX - POS_W(SCROLLBAR_WIDTH));
        _ctrlTag ctrlCommit 0;

        private _ctrlTitle = _y controlsGroupCtrl IDC_ENTRY_TITLE;
        private _titleW = ctrlPosition _ctrlTitle select 2;
        _ctrlTitle ctrlSetPositionW (_titleW - POS_W(SCROLLBAR_WIDTH));
        _ctrlTitle ctrlCommit 0;
    } forEach _entries;
};

_display setVariable [QGVAR(sidebarControls), _controls];
_display setVariable [QGVAR(sidebarHeight), _posY];

// Features are kept in order for navigating with the keyboard, along with their sidebar entries
_display setVariable [QGVAR(features), _features];
_display setVariable [QGVAR(entries), _entries];
