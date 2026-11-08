#include "script_component.hpp"
/*
 * Author: mharis001
 * Shows the slide at the given index in a slideshow, wrapping around past the last slide.
 *
 * Arguments:
 * 0: Slideshow <CONTROL>
 * 1: Index <NUMBER>
 * 2: Duration <NUMBER> (default: 0)
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 1] call zen_tour_fnc_selectSlide
 *
 * Public: No
 */

params ["_ctrlSlideshow", "_index", ["_duration", 0]];

private _ctrlSlides = _ctrlSlideshow getVariable QGVAR(slides);
_index = _index mod count _ctrlSlides;

{
    _x ctrlSetFade parseNumber (_forEachIndex != _index);
    _x ctrlCommit _duration;
} forEach _ctrlSlides;

private _ctrlDots = _ctrlSlideshow getVariable QGVAR(dots);

{
    private _alpha = [0.25, 1] select (_forEachIndex == _index);
    _x ctrlSetBackgroundColor [1, 1, 1, _alpha];
} forEach _ctrlDots;

private _ctrlCaption = _ctrlSlideshow controlsGroupCtrl IDC_SLIDESHOW_CAPTION;
private _caption = _ctrlSlideshow getVariable QGVAR(captions) select _index;
_ctrlCaption ctrlSetStructuredText _caption;

_ctrlSlideshow setVariable [QGVAR(slide), _index];
_ctrlSlideshow setVariable [QGVAR(changeTime), diag_tickTime];
