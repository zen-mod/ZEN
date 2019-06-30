/*
 * Author: mharis001
 * Opens base level context menu.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_context_menu_fnc_openMenu
 *
 * Public: No
 */
#include "script_component.hpp"

// Close previously opened context menu
[] call FUNC(closeMenu);

// Update variables for this context
GVAR(mousePos) = getMousePosition;
GVAR(selected) = curatorSelected;

// Handle hovered entity
curatorMouseOver params ["_type", "_entity"];
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

// Create base level context menu
[GVAR(actions)] call FUNC(createContextGroup);
