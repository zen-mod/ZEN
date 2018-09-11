/*
 * Author: mharis001
 *
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
call FUNC(closeMenu);

// Update global variables for this context
GVAR(mousePos) = getMousePosition;
GVAR(selected) = curatorSelected;

curatorMouseOver params ["_type", "_entity"];
private _category = ["OBJECT", "GROUP", "ARRAY", "STRING"] find _type;
if (_category != -1) then {
    GVAR(selected) select _category pushBackUnique _entity;
};

// Create base level context menu
[GVAR(actions)] call FUNC(createContextGroup);
