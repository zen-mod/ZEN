#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes a slideshow from the given config, showing its pictures one at a time with a caption and dots below them.
 * The slideshow's height is extended to fit the caption.
 *
 * Arguments:
 * 0: Slideshow <CONTROL>
 * 1: Config <CONFIG>
 *
 * Return Value:
 * Animated <BOOL>
 *
 * Example:
 * [CONTROL, _config] call zen_tour_fnc_initSlideshow
 *
 * Public: No
 */

params ["_ctrlSlideshow", "_config"];

private _display = ctrlParent _ctrlSlideshow;
private _slides = getArray (_config >> "slides");
ctrlPosition _ctrlSlideshow params ["", "", "_slideW", "_slideH"];

// Slides are in their own group, which keeps them below the area clicked to show the next slide
private _ctrlSlidesGroup = _ctrlSlideshow controlsGroupCtrl IDC_SLIDESHOW_SLIDES;
_ctrlSlidesGroup ctrlSetPosition [0, 0, _slideW, _slideH];
_ctrlSlidesGroup ctrlCommit 0;

private _ctrlSlides = _slides apply {
    _x params ["_picture"];

    private _ctrlSlide = _display ctrlCreate ["RscPicture", -1, _ctrlSlidesGroup];
    _ctrlSlide ctrlSetPosition [0, 0, _slideW, _slideH];
    _ctrlSlide ctrlSetText _picture;
    _ctrlSlide ctrlCommit 0;
    _ctrlSlide
};

// Clicking a slide shows the next one
private _ctrlNext = _ctrlSlideshow controlsGroupCtrl IDC_SLIDESHOW_NEXT;
_ctrlNext ctrlSetPosition [0, 0, _slideW, _slideH];
_ctrlNext ctrlCommit 0;
_ctrlNext setVariable [QGVAR(slide), -1];

// Dots in the bottom right show each slide, and have a larger area to click than their size
private _captionY = _slideH + POS_H(SLIDESHOW_CAPTION_SPACING);
private _dotsX = _slideW - (count _slides - 1) * POS_W(SLIDESHOW_DOT_SPACING) - POS_W(SLIDESHOW_DOT_WIDTH);
private _dotY = _captionY + POS_H(SLIDESHOW_DOT_Y);
private _ctrlDots = [];

{
    private _dotX = _dotsX + _forEachIndex * POS_W(SLIDESHOW_DOT_SPACING);
    private _dotPosition = [_dotX, _dotY, POS_W(SLIDESHOW_DOT_WIDTH), POS_H(SLIDESHOW_DOT_HEIGHT)];
    private _ctrlDot = [_ctrlSlideshow, _dotPosition, [1, 1, 1, 1]] call FUNC(createBox);
    _ctrlDots pushBack _ctrlDot;

    private _ctrlDotMouse = _display ctrlCreate [QGVAR(slideshowMouse), -1, _ctrlSlideshow];
    private _clickX = _dotX - POS_W(SLIDESHOW_DOT_SPACING - SLIDESHOW_DOT_WIDTH) / 2;
    _ctrlDotMouse ctrlSetPosition [_clickX, _captionY, POS_W(SLIDESHOW_DOT_SPACING), POS_H(SLIDESHOW_CAPTION_HEIGHT)];
    _ctrlDotMouse ctrlCommit 0;
    _ctrlDotMouse setVariable [QGVAR(slide), _forEachIndex];
} forEach _slides;

// Leave room for the longest caption, so that the page does not shift between slides
private _captions = _slides apply {
    _x params ["", ["_caption", ""]];

    [_caption] call FUNC(toStructuredText)
};

private _ctrlCaption = _ctrlSlideshow controlsGroupCtrl IDC_SLIDESHOW_CAPTION;
private _captionW = _dotsX - POS_W(SLIDESHOW_CAPTION_GAP);

// Widened by the built-in margins of text controls, so that the text itself lines up with the slides
_ctrlCaption ctrlSetPosition [-TEXT_MARGIN, _captionY, _captionW + 2 * TEXT_MARGIN, 0];
_ctrlCaption ctrlCommit 0;

private _captionH = POS_H(SLIDESHOW_CAPTION_HEIGHT);

{
    _ctrlCaption ctrlSetStructuredText _x;
    _captionH = _captionH max ctrlTextHeight _ctrlCaption;
} forEach _captions;

_ctrlCaption ctrlSetPositionH _captionH;
_ctrlCaption ctrlCommit 0;

_ctrlSlideshow ctrlSetPositionH (_captionY + _captionH);
_ctrlSlideshow ctrlCommit 0;

_ctrlSlideshow setVariable [QGVAR(type), "slideshow"];
_ctrlSlideshow setVariable [QGVAR(state), MEDIA_STATE_HIDDEN];
_ctrlSlideshow setVariable [QGVAR(slides), _ctrlSlides];
_ctrlSlideshow setVariable [QGVAR(dots), _ctrlDots];
_ctrlSlideshow setVariable [QGVAR(captions), _captions];
[_ctrlSlideshow, 0] call FUNC(selectSlide);

true
