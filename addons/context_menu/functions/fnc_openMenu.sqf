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
    GVAR(hovered) = _entity;
} else {
    GVAR(hovered) = objNull;
};

// Create base level context menu
[GVAR(actions)] call FUNC(createContextGroup);
