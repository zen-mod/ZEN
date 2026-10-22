#include "script_component.hpp"
/*
 * Author: mharis001
 * Renders the picture, comparison, or slideshow of a feature or section.
 * Media keeps the aspect ratio of its picture, or the first picture of comparisons and slideshows.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Position <ARRAY>
 *   - The height is determined by the aspect ratio.
 * 2: Feature or Section <CONFIG>
 *
 * Return Value:
 * Media <CONTROL>
 *
 * Example:
 * [CONTROL, [0, 0, 1], _config] call zen_tour_fnc_renderMedia
 *
 * Public: No
 */

// Height for the given width and aspect ratio, using screen pixels to stay accurate on any screen
#define PICTURE_HEIGHT(WIDTH,RATIO) ((WIDTH) / pixelW * pixelH / (RATIO))

params ["_controlsGroup", "_position", "_config"];
_position params ["_posX", "_posY", "_posW"];

private _comparison = getArray (_config >> "comparison");
private _slides = getArray (_config >> "slides");

// Each type of media is created from its own class and initialized from the config by its own function
// The (first) picture determines the aspect ratio
private _mediaParams = switch (true) do {
    case (_comparison isNotEqualTo []): {
        [QGVAR(comparison), FUNC(initComparison), _comparison select 0]
    };
    case (_slides isNotEqualTo []): {
        [QGVAR(slideshow), FUNC(initSlideshow), _slides select 0 select 0]
    };
    default {
        [QGVAR(picture), FUNC(initPicture), getText (_config >> "picture")]
    };
};

_mediaParams params ["_class", "_function", "_picture"];
getTextureInfo _picture params ["_textureW", "_textureH"];

private _ratio = if (_textureW > 0 && {_textureH > 0}) then {
    _textureW / _textureH
} else {
    16 / 9
};

private _ctrlMedia = ctrlParent _controlsGroup ctrlCreate [_class, -1, _controlsGroup];
_ctrlMedia ctrlSetPosition [_posX, _posY, _posW, PICTURE_HEIGHT(_posW,_ratio)];
_ctrlMedia ctrlCommit 0;

// Animated media is updated by the display's animation handler while it is scrolled into view
private _isAnimated = [_ctrlMedia, _config] call _function;

if (_isAnimated) then {
    private _media = ctrlParent _controlsGroup getVariable QGVAR(media);
    _media pushBack _ctrlMedia;
};

_ctrlMedia
