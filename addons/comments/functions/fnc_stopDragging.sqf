#include "script_component.hpp"
/*
 * Author: mharis001
 * Stops dragging the comment being dragged, if any.
 * The comment is moved back to where the drag started.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_comments_fnc_stopDragging
 *
 * Public: No
 */

if (GVAR(draggedComment) == "") exitWith {};

// Move the comment back to its original position (the dragged position was only applied locally)
private _ctrlIcon = GVAR(icons) get GVAR(draggedComment);
private _data = GVAR(comments) get GVAR(draggedComment);
_data set [DATA_INDEX_POSITION, _ctrlIcon getVariable QGVAR(dragOriginalPos)];

[_ctrlIcon] call FUNC(updateIconColor);

GVAR(draggedComment) = "";
