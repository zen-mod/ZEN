#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles clicking a slideshow, showing the clicked slide or the next one.
 *
 * Arguments:
 * 0: Mouse Area <CONTROL>
 * 1: Button <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 0] call zen_tour_fnc_handleSlideClick
 *
 * Public: No
 */

params ["_ctrlMouse", "_button"];

if (_button != 0) exitWith {};

private _ctrlSlideshow = ctrlParentControlsGroup _ctrlMouse;
private _current = _ctrlSlideshow getVariable QGVAR(slide);
private _index = _ctrlMouse getVariable QGVAR(slide);

if (_index == -1) then {
    _index = _current + 1;
};

if (_index == _current) exitWith {};

playSoundUI ["SoundClick", 0.03];
[_ctrlSlideshow, _index, SLIDESHOW_FADE_DURATION] call FUNC(selectSlide);
