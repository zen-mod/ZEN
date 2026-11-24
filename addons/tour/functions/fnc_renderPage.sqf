#include "script_component.hpp"
/*
 * Author: mharis001
 * Renders the page for the given feature.
 * The page is made of blocks, from its media and header to each of its sections.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Feature <CONFIG>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY, _feature] call zen_tour_fnc_renderPage
 *
 * Public: No
 */

params ["_display", "_feature"];

private _ctrlPage = _display displayCtrl IDC_PAGE;
_ctrlPage ctrlSetScrollValues [0, -1];

private _previousBlocks = _display getVariable [QGVAR(blocks), []];

{
    ctrlDelete _x;
} forEach _previousBlocks;

// Contains the animated media while the blocks are rendered
_display setVariable [QGVAR(media), []];

// The scrollbar takes up space on the right, so it is left out to keep the margins on both sides equal
ctrlPosition _ctrlPage params ["", "", "_pageW", "_pageH"];

private _posY = 0;
private _width = _pageW - 2 * POS_W(PAGE_MARGIN) - POS_W(SCROLLBAR_WIDTH);
private _blocks = [];

// Renders a block below the previous one, after the given spacing
private _fnc_addBlock = {
    params ["_function", "_spacing", "_source"];

    private _ctrlBlock = [_ctrlPage, [POS_W(PAGE_MARGIN), _posY + _spacing, _width], _source] call _function;
    _blocks pushBack _ctrlBlock;

    ctrlPosition _ctrlBlock params ["", "_blockY", "", "_blockH"];
    _posY = _blockY + _blockH;
};

// Without media, the header is at the top of the page
private _hasMedia = ["picture", "comparison", "slides"] findIf {!isNull (_feature >> _x)} != -1;

if (_hasMedia) then {
    [FUNC(renderMedia), POS_H(CONTENT_PADDING), _feature] call _fnc_addBlock;
};

private _headerSpacing = [POS_H(CONTENT_PADDING), POS_H(PAGE_HEADER_SPACING)] select _hasMedia;
[FUNC(renderHeader), _headerSpacing, _feature] call _fnc_addBlock;

{
    [FUNC(renderSection), POS_H(PAGE_SECTION_SPACING), _x] call _fnc_addBlock;
} forEach configProperties [_feature, "isClass _x", true];

// Keep a margin below the last block when scrolled to the bottom
private _ctrlSpacer = _display ctrlCreate ["RscText", -1, _ctrlPage];
_ctrlSpacer ctrlSetPosition [0, _posY, POS_W(PAGE_MARGIN), POS_H(PAGE_BOTTOM_SPACING)];
_ctrlSpacer ctrlCommit 0;

_blocks pushBack _ctrlSpacer;
_posY = _posY + POS_H(PAGE_BOTTOM_SPACING);

_display setVariable [QGVAR(blocks), _blocks];
_display setVariable [QGVAR(pageHeight), _posY];

// Without a scrollbar, the page is shifted to keep the content centered in the space left for it
private _isScrollable = _posY > _pageH;
private _pageX = [POS_X(3 + SIDEBAR_WIDTH + SCROLLBAR_WIDTH / 2), POS_X(3 + SIDEBAR_WIDTH)] select _isScrollable;
_ctrlPage ctrlSetPositionX _pageX;
_ctrlPage ctrlCommit 0;
