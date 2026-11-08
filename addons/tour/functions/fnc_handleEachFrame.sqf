#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles each frame while the display is open, updating the animations of the page's media.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: PFH Handle <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY, 1] call zen_tour_fnc_handleEachFrame
 *
 * Public: No
 */

params ["_display", "_pfhID"];

if (isNull _display) exitWith {
    [_pfhID] call CBA_fnc_removePerFrameHandler;
};

private _media = _display getVariable [QGVAR(media), []];
if (_media isEqualTo []) exitWith {};

// Determine the visible part of the page from its scroll position
// Media animates once most of it is scrolled into view, and resets once scrolled out of view entirely
private _ctrlPage = _display displayCtrl IDC_PAGE;
private _scroll = (ctrlScrollValues _ctrlPage select 0) max 0;
private _pageH = _display getVariable [QGVAR(pageHeight), 0];
private _viewH = ctrlPosition _ctrlPage select 3;
private _viewTop = _scroll * ((_pageH - _viewH) max 0);
private _viewBottom = _viewTop + _viewH;
private _now = diag_tickTime;

// Moves media between its initial and animated states, where pictures focus and comparisons split in the middle
private _fnc_animate = {
    params ["_ctrlMedia", "_isAnimated", "_duration"];

    _ctrlMedia setVariable [QGVAR(changeTime), _now];

    if (_ctrlMedia getVariable QGVAR(type) == "comparison") then {
        [_ctrlMedia, [1, COMPARISON_SPLIT] select _isAnimated, _duration] call FUNC(setComparisonSplit);
    } else {
        [_ctrlMedia, _isAnimated, _duration] call FUNC(setPictureFocus);
    };
};

{
    private _ctrlMedia = _x;
    private _mediaH = ctrlPosition _ctrlMedia select 3;

    // Media can be nested in groups, so its position within the page adds up the positions of each group
    private _mediaY = 0;
    private _ctrl = _ctrlMedia;

    while {_ctrl isNotEqualTo _ctrlPage} do {
        _mediaY = _mediaY + (ctrlPosition _ctrl select 1);
        _ctrl = ctrlParentControlsGroup _ctrl;
    };

    private _type = _ctrlMedia getVariable QGVAR(type);
    private _state = _ctrlMedia getVariable [QGVAR(state), MEDIA_STATE_HIDDEN];

    // Reset only once out of view entirely, so that animations do not replay while partially visible
    private _isOutOfView = _mediaY + _mediaH < _viewTop || {_mediaY > _viewBottom};

    if (_isOutOfView) then {
        if !(_state in [MEDIA_STATE_HIDDEN, MEDIA_STATE_MANUAL]) then {
            if (_type != "slideshow") then {
                [_ctrlMedia, false, 0] call _fnc_animate;
            };

            _ctrlMedia setVariable [QGVAR(state), MEDIA_STATE_HIDDEN];
        };

        continue;
    };

    // Start once the center is in view, so that most of the media can be seen
    if (_state == MEDIA_STATE_HIDDEN) then {
        private _mediaCenterY = _mediaY + _mediaH / 2;

        if (_mediaCenterY > _viewTop && {_mediaCenterY < _viewBottom}) then {
            _ctrlMedia setVariable [QGVAR(changeTime), _now];
            _ctrlMedia setVariable [QGVAR(state), MEDIA_STATE_WAITING];
        };

        continue;
    };

    private _changeTime = _ctrlMedia getVariable QGVAR(changeTime);
    private _timeSinceChange = _now - _changeTime;

    // Slideshows advance while visible, with clicking through slides also restarting the interval
    if (_type == "slideshow") then {
        if (_timeSinceChange >= SLIDESHOW_INTERVAL) then {
            private _nextSlide = (_ctrlMedia getVariable QGVAR(slide)) + 1;
            [_ctrlMedia, _nextSlide, SLIDESHOW_FADE_DURATION] call FUNC(selectSlide);
        };

        continue;
    };

    switch (_state) do {
        case MEDIA_STATE_WAITING: {
            if (_timeSinceChange < MEDIA_ANIMATION_DELAY) exitWith {};

            [_ctrlMedia, true, MEDIA_ANIMATION_DURATION] call _fnc_animate;

            // Comparisons only show their divider once, after which it is left to the player
            private _nextState = [MEDIA_STATE_ANIMATED, MEDIA_STATE_MANUAL] select (_type == "comparison");
            _ctrlMedia setVariable [QGVAR(state), _nextState];
        };
        case MEDIA_STATE_ANIMATED: {
            private _isLooping = _ctrlMedia getVariable [QGVAR(loop), false];
            if (!_isLooping || {_timeSinceChange < MEDIA_ANIMATION_DURATION + MEDIA_LOOP_HOLD}) exitWith {};

            [_ctrlMedia, false, MEDIA_ANIMATION_DURATION] call _fnc_animate;
            _ctrlMedia setVariable [QGVAR(state), MEDIA_STATE_REVERSED];
        };
        case MEDIA_STATE_REVERSED: {
            if (_timeSinceChange < MEDIA_ANIMATION_DURATION + MEDIA_LOOP_HOLD) exitWith {};

            [_ctrlMedia, true, MEDIA_ANIMATION_DURATION] call _fnc_animate;
            _ctrlMedia setVariable [QGVAR(state), MEDIA_STATE_ANIMATED];
        };
    };
} forEach _media;
