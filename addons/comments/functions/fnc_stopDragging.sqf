#include "script_component.hpp"
/*
 * Author: mharis001
 * Stops dragging the comment being dragged, if any.
 * The dragged position is either applied by updating the comment or reverted.
 *
 * Arguments:
 * 0: Apply Position <BOOL> (default: false)
 *
 * Return Value:
 * None
 *
 * Example:
 * [true] call zen_comments_fnc_stopDragging
 *
 * Public: No
 */

params [["_applyPosition", false]];

if (GVAR(draggedComment) == "") exitWith {};

// The dragged position was only applied locally, update the comment if it was moved or move it back
private _ctrlIcon = GVAR(icons) get GVAR(draggedComment);
private _data = GVAR(comments) get GVAR(draggedComment);
private _originalPos = _ctrlIcon getVariable QGVAR(dragOriginalPos);

if (_applyPosition) then {
    private _draggedPos = _data select DATA_INDEX_POSITION;

    if (_draggedPos isNotEqualTo _originalPos) then {
        [GVAR(draggedComment), _draggedPos] call FUNC(updateComment);
    };
} else {
    _data set [DATA_INDEX_POSITION, _originalPos];
};

GVAR(draggedComment) = "";

[_ctrlIcon] call FUNC(updateIconColor);
