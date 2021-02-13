#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles pressing the create button in the custom compositions panel.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_compositions_fnc_buttonCreate
 *
 * Public: No
 */

private _data = [SELECTED_OBJECTS] call EFUNC(common,serializeObjects);

if (_data isEqualTo [[], []]) exitWith {
    [LSTRING(NoObjectsSelected)] call EFUNC(common,showMessage);
};

["create", ["", "", _data]] call FUNC(openDisplay);
