#include "script_component.hpp"
/*
 * Author: mharis001
 * Updates the mouse control to enable hover/drag interactions.
 * The given comment is set as the hovered comment and the mouse control is positioned over it.
 *
 * Arguments:
 * 0: Comment ID <STRING>
 *   - Empty string hovers no comment.
 * 1: Image Rectangle <ARRAY> (default: [])
 *   - Screen rectangle [x, y, w, h] of the comment's icon image, not used when no comment is given.
 *
 * Return Value:
 * None
 *
 * Example:
 * ["zeus:0", [0.5, 0.5, 0.025, 0.033]] call zen_comments_fnc_updateMouse
 *
 * Public: No
 */

params ["_id", ["_imageRect", []]];

private _display = findDisplay IDD_RSCDISPLAYCURATOR;
private _ctrlMouse = _display displayCtrl IDC_MOUSE;

// The mouse control is moved out of the way instead of hidden since ctrlAt skips hidden controls
private _isHovering = _id != "";
private _position = [[0, 0, 0, 0], _imageRect] select _isHovering;
_ctrlMouse ctrlSetPosition _position;
_ctrlMouse ctrlCommit 0;

// The comment is not hovered when the mouse control is behind a foreground interface element
// since that element receives the mouse events instead
// The dragged comment is always hovered so that it stays highlighted while being dragged over the interface
if (
    _isHovering
    && {GVAR(draggedComment) == ""}
    && {_display ctrlAt getMousePosition != _ctrlMouse}
) then {
    _id = "";
};

// Update the colors of the current and previous icons when the hovered comment changes
if (_id != GVAR(hoveredComment)) then {
    private _previousID = GVAR(hoveredComment);
    GVAR(hoveredComment) = _id;

    // The previous comment's icon may have been deleted since it was hovered
    {
        private _ctrlIcon = GVAR(icons) getOrDefault [_x, controlNull];

        if (!isNull _ctrlIcon) then {
            [_ctrlIcon] call FUNC(updateIconColor);
        };
    } forEach [_previousID, _id];
};

// Show the tooltip if a comment is hovered and is not being dragged
private _tooltip = if (
    _id != ""
    && {GVAR(draggedComment) == ""}
) then {
    GVAR(comments) get _id select DATA_INDEX_TOOLTIP
} else {
    ""
};

_ctrlMouse ctrlSetTooltip _tooltip;
