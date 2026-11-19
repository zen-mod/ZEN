#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles pressing a key in the display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Key Code <NUMBER>
 *
 * Return Value:
 * Handled <BOOL>
 *
 * Example:
 * [DISPLAY, 0] call zen_tour_fnc_handleKeyDown
 *
 * Public: No
 */

params ["_display", "_keyCode"];

// Returns the scroll value that brings the given area of a scrolling group into view
private _fnc_calculateScrollValue = {
    params ["_controlsGroup", "_contentH", "_areaY", "_areaH"];

    private _viewH = ctrlPosition _controlsGroup select 3;
    private _range = _contentH - _viewH;
    if (_range <= 0) exitWith {0};

    private _top = ((ctrlScrollValues _controlsGroup select 0) max 0) * _range;
    _top = _areaY min _top max (_areaY + _areaH - _viewH);
    _top / _range
};

// Arrow keys move through the features
if (_keyCode in [DIK_UP, DIK_DOWN]) exitWith {
    private _features = _display getVariable QGVAR(features);
    private _count = count _features;
    private _current = _features find (_display getVariable QGVAR(feature));
    private _step = [-1, 1] select (_keyCode == DIK_DOWN);

    // Wrap around past the first and last features
    private _feature = _features select ((_current + _step + _count) mod _count);
    [_display, _feature] call FUNC(selectFeature);

    // Keep the selected entry visible when the list does not fit
    private _ctrlEntry = (_display getVariable QGVAR(entries)) get _feature;
    ctrlPosition _ctrlEntry params ["", "_entryY", "", "_entryH"];

    private _ctrlSidebar = _display displayCtrl IDC_SIDEBAR;
    private _sidebarH = _display getVariable [QGVAR(sidebarHeight), 0];
    private _scroll = [_ctrlSidebar, _sidebarH, _entryY, _entryH] call _fnc_calculateScrollValue;
    _ctrlSidebar ctrlSetScrollValues [_scroll, -1];

    true
};

// Page keys scroll the page
if (_keyCode in [DIK_PRIOR, DIK_NEXT, DIK_HOME, DIK_END]) exitWith {
    private _ctrlPage = _display displayCtrl IDC_PAGE;
    private _pageH = _display getVariable [QGVAR(pageHeight), 0];
    private _viewH = ctrlPosition _ctrlPage select 3;

    private _range = _pageH - _viewH;
    if (_range <= 0) exitWith {true};

    private _currentScroll = (ctrlScrollValues _ctrlPage select 0) max 0;
    private _pageStep = _viewH * (1 - PAGE_SCROLL_OVERLAP) / _range;

    private _scroll = switch (_keyCode) do {
        case DIK_PRIOR: {_currentScroll - _pageStep};
        case DIK_NEXT: {_currentScroll + _pageStep};
        case DIK_HOME: {0};
        case DIK_END: {1};
    };

    _ctrlPage ctrlSetScrollValues [0 max _scroll min 1, -1];

    true
};

false
