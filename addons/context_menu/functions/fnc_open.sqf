#include "script_component.hpp"
/*
 * Author: mharis001
 * Opens base level context menu.
 *
 * Arguments:
 * 0: Actions <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_context_menu_fnc_open
 *
 * Public: No
 */

params ["_actions"];

// Open context menu with full actions tree if none are given
if (isNil "_actions") then {
    _actions = GVAR(actions);
};

// Close previously opened context menu
[] call FUNC(close);

// Update variables for this context
GVAR(mousePos) = getMousePosition;
GVAR(selected) = curatorSelected;

// Handle currently hovered entity
curatorMouseOver params ["_type", "_entity", "_index"];

// curatorMouseOver returns group and index separately when hovering over a waypoint
if (_type == "ARRAY") then {
    _entity = [_entity, _index];
};

private _category = ["OBJECT", "GROUP", "ARRAY", "STRING"] find _type;

if (_category != -1) then {
    GVAR(selected) select _category pushBackUnique _entity;

    // Add one man groups of hovered units to the selected groups array
    // This makes opening the menu consistent when the unit is selected versus hovered
    if (_type == "OBJECT" && {!isNull group _entity} && {count units _entity == 1}) then {
        GVAR(selected) select 1 pushBackUnique group _entity;
    };

    // Add units of hovered groups to the selected units array to
    // simulate selecting the group and then opening the menu
    if (_type == "GROUP") then {
        {GVAR(selected) select 0 pushBackUnique _x} forEach units _entity;
    };

    GVAR(hovered) = _entity;
} else {
    GVAR(hovered) = objNull;
};

// Create the context menu
private _activeActions = [_actions] call FUNC(getActiveActions);
[_activeActions] call FUNC(createContextGroup);
