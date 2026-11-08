#include "script_component.hpp"
/*
 * Author: Timi007
 * Creates an icon control for the given comment.
 * The icon is only created if comments of the given type are enabled
 * and an icon for the comment does not exist already.
 *
 * Arguments:
 * 0: Comment ID <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["zeus:0"] call zen_comments_fnc_createIcon
 *
 * Public: No
 */

params ["_id"];

if (
    _id in GVAR(icons)
    || {
        private _is3DENComment = [_id] call FUNC(is3DENComment);
        private _isEnabled = [GVAR(enabled), GVAR(enabled3DEN)] select _is3DENComment;
        !_isEnabled
    }
) exitWith {};

private _display = findDisplay IDD_RSCDISPLAYCURATOR;
if (isNull _display) exitWith {};

// Create the icon, which is hidden until the rendering loop updates it
private _ctrlContainer = _display displayCtrl IDC_CONTAINER;
private _ctrlIcon = _display ctrlCreate [QGVAR(icon), -1, _ctrlContainer];
_ctrlIcon setVariable [QGVAR(id), _id];
_ctrlIcon ctrlShow false;

GVAR(icons) set [_id, _ctrlIcon];
[_id] call FUNC(updateIcon);

// Start the rendering loop if it does not exist already (i.e., this is the first icon)
if (isNil QGVAR(draw3D)) then {
    GVAR(draw3D) = addMissionEventHandler ["Draw3D", {call FUNC(renderIcons)}];
};
