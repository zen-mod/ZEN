#include "script_component.hpp"
/*
 * Author: mharis001
 * Removes the action with the given path from the ZEN context menu.
 *
 * Arguments:
 * 0: Action Path <ARRAY>
 *
 * Return Value:
 * Removed <BOOL>
 *
 * Example:
 * [_actionPath] call zen_context_menu_fnc_removeAction
 *
 * Public: Yes
 */

if (canSuspend) exitWith {
    [FUNC(removeAction), _this] call CBA_fnc_directCall;
};

if (!hasInterface) exitWith {
    false
};

private _params = _this;

if (_params select 0 isEqualType "") then {
    _params = [_params];
};

_params params [["_actionPath", [], [[]]]];

scopeName "Main";

private _pathLength = count _actionPath;
private _parentNode = [[], GVAR(actions)];

{
    private _actionName = _x;
    _parentNode params ["", "_children"];

    // Find the action with the given name at this level
    private _index = _children findIf {
        (_x select 0 select 0) isEqualTo _actionName;
    };

    // Exit if an action with the given name at this level does not exist
    if (_index == -1) then {
        ERROR_1("Failed to remove action %1, invalid action path.",_actionPath);
        false breakOut "Main";
    };

    // Delete the found action if the end of the path has been reached and exit
    if (_pathLength == _forEachIndex + 1) then {
        _children deleteAt _index;
        true breakOut "Main";
    };

    // Move to the next level of the action path with the found action as the parent node
    _parentNode = _children select _index;
} forEach _actionPath;

false
