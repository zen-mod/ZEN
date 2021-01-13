#include "script_component.hpp"
/*
 * Author: mharis001
 * Checks if a position logic of the given type exists.
 *
 * Arguments:
 * 0: Type <STRING|OBJECT>
 *
 * Return Value:
 * Exists <BOOL>
 *
 * Example:
 * [_logicType] call zen_position_logics_fnc_exists
 *
 * Public: No
 */

call FUNC(get) isNotEqualTo []
