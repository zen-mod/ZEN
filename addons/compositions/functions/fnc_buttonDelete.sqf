#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles pressing the delete button in the custom compositions panel.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_compositions_fnc_buttonDelete
 *
 * Public: No
 */

[
    nil,
    format ["<t size='0.8'>%1</t>", localize LSTRING(DeleteConfirmation)],
    FUNC(removeFromTree)
] call EFUNC(common,messageBox);
