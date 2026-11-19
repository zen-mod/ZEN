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

// Slows the start and end of an animation for the given fraction of its progress
#define EASE(PROGRESS) ((PROGRESS) * (PROGRESS) * (3 - 2 * (PROGRESS)))

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
ctrlPosition _ctrlPage params ["", "", "_viewW", "_viewH"];
private _viewTop = _scroll * ((_pageH - _viewH) max 0);
private _viewBottom = _viewTop + _viewH;
private _now = diag_tickTime;

// Media can extend past the visible part of the page, where it cannot be hovered
// The mouse position within the page accounts for its scroll position
ctrlMousePosition _ctrlPage params ["_pageMouseX", "_pageMouseY"];

private _isMouseInView = (
    _pageMouseX >= 0
    && {_pageMouseX < _viewW}
    && {_pageMouseY >= _viewTop}
    && {_pageMouseY < _viewBottom}
);

// Returns the given progress moved towards its target, at the speed to complete it over the given duration
// Moving at a constant speed allows an animation to smoothly reverse at any point
private _fnc_step = {
    params ["_progress", "_target", "_duration"];

    private _step = diag_deltaTime / _duration;
    _target max (_progress - _step) min (_progress + _step)
};

// Updates media for the given progress of its animations, only when it has changed
private _fnc_setProgress = {
    params ["_ctrlMedia", "_progress"];

    if (_progress isEqualTo (_ctrlMedia getVariable QGVAR(progress))) exitWith {};

    _ctrlMedia setVariable [QGVAR(progress), _progress];

    if (_ctrlMedia getVariable QGVAR(type) == "comparison") then {
        _progress params ["_split"];

        [_ctrlMedia, linearConversion [0, 1, EASE(_split), 1, COMPARISON_SPLIT]] call FUNC(setComparisonSplit);
    } else {
        _progress params ["_zoom", "_highlight"];

        [_ctrlMedia, EASE(_zoom), EASE(_highlight)] call FUNC(setPictureFocus);
    };
};

// Changes the state of the current media
private _fnc_setState = {
    _state = _this;
    _timeSinceChange = 0;

    _ctrlMedia setVariable [QGVAR(state), _state];
    _ctrlMedia setVariable [QGVAR(changeTime), _now];
};

{
    private _ctrlMedia = _x;
    ctrlPosition _ctrlMedia params ["", "", "_mediaW", "_mediaH"];

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
        // The hover delay should restart when scrolled back under the mouse
        _ctrlMedia setVariable [QGVAR(hoverTime), _now];

        if (_state != MEDIA_STATE_MANUAL) then {
            _ctrlMedia setVariable [QGVAR(state), MEDIA_STATE_HIDDEN];

            if (_type != "slideshow") then {
                private _progress = _ctrlMedia getVariable QGVAR(progress) apply {0};
                [_ctrlMedia, _progress] call _fnc_setProgress;
            };
        };

        continue;
    };

    private _timeSinceChange = _now - (_ctrlMedia getVariable [QGVAR(changeTime), _now]);

    // Start once the center is in view, so that most of the media can be seen
    if (_state == MEDIA_STATE_HIDDEN) then {
        private _mediaCenterY = _mediaY + _mediaH / 2;

        if (_mediaCenterY > _viewTop && {_mediaCenterY < _viewBottom}) then {
            MEDIA_STATE_WAITING call _fnc_setState;
        };
    };

    switch (_type) do {
        // Slideshows advance while visible, with clicking through slides also restarting the interval
        case "slideshow": {
            if (_state != MEDIA_STATE_HIDDEN && {_timeSinceChange >= SLIDESHOW_INTERVAL}) then {
                private _nextSlide = (_ctrlMedia getVariable QGVAR(slide)) + 1;
                [_ctrlMedia, _nextSlide, SLIDESHOW_FADE_DURATION] call FUNC(selectSlide);
            };
        };
        // Comparisons only show their divider once, after which it is left to the player
        case "comparison": {
            if (_state == MEDIA_STATE_WAITING && {_timeSinceChange >= MEDIA_ANIMATION_DELAY}) then {
                MEDIA_STATE_ANIMATED call _fnc_setState;
            };

            if (_state == MEDIA_STATE_ANIMATED) then {
                _ctrlMedia getVariable QGVAR(progress) params ["_split"];

                _split = [_split, 1, MEDIA_ANIMATION_DURATION] call _fnc_step;
                [_ctrlMedia, [_split]] call _fnc_setProgress;

                if (_split == 1) then {
                    MEDIA_STATE_MANUAL call _fnc_setState;
                };
            };
        };
        // Pictures highlight their focus area on their own and leave zooming to the player, unless looping
        case "picture": {
            private _isLooping = _ctrlMedia getVariable QGVAR(loop);
            private _loopTime = MEDIA_ANIMATION_DURATION + MEDIA_LOOP_HOLD;

            switch (_state) do {
                case MEDIA_STATE_WAITING: {
                    if (_timeSinceChange >= MEDIA_ANIMATION_DELAY) then {
                        MEDIA_STATE_ANIMATED call _fnc_setState;
                    };
                };
                case MEDIA_STATE_ANIMATED: {
                    if (_isLooping && {_timeSinceChange >= _loopTime}) then {
                        MEDIA_STATE_REVERSED call _fnc_setState;
                    };
                };
                case MEDIA_STATE_REVERSED: {
                    if (_timeSinceChange >= _loopTime) then {
                        MEDIA_STATE_ANIMATED call _fnc_setState;
                    };
                };
            };

            ctrlMousePosition _ctrlMedia params ["_mouseX", "_mouseY"];

            private _isHovered = (
                _isMouseInView
                && {_mouseX >= 0}
                && {_mouseX < _mediaW}
                && {_mouseY >= 0}
                && {_mouseY < _mediaH}
            );

            // The delay prevents pictures from zooming as they are scrolled past or the mouse moves across them
            if (!_isHovered) then {
                _ctrlMedia setVariable [QGVAR(hoverTime), _now];
            };

            private _isHighlighted = _state == MEDIA_STATE_ANIMATED;
            private _isHoverZoomed = _now - (_ctrlMedia getVariable QGVAR(hoverTime)) >= PICTURE_HOVER_DELAY;
            private _isZoomed = [_isHoverZoomed, _isHighlighted] select _isLooping;
            private _zoomDuration = [_ctrlMedia getVariable QGVAR(zoomDuration), MEDIA_ANIMATION_DURATION] select _isLooping;

            _ctrlMedia getVariable QGVAR(progress) params ["_zoom", "_highlight"];

            [
                _ctrlMedia,
                [
                    [_zoom, parseNumber _isZoomed, _zoomDuration] call _fnc_step,
                    [_highlight, parseNumber _isHighlighted, PICTURE_HIGHLIGHT_DURATION] call _fnc_step
                ]
            ] call _fnc_setProgress;
        };
    };
} forEach _media;
