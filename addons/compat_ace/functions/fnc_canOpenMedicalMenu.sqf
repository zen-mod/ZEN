#include "script_component.hpp"
/*
 * Author: OverlordZorn
 * Checks if the ace medical menu can be opened for an unit.
 *
 * Arguments:
 * 0: Entity <ANY>
 *
 * Return Value:
 * Can Open ACE Medical Menu <BOOL>
 *
 * Example:
 * [_entity] call zen_compat_ace_fnc_canOpenMedicalMenu
 *
 * Public: No
 */

params ["_entity"];

_entity isEqualType objNull
&&
{
    !isNull _entity
    &&
    {
        _entity isKindOf "CAManBase"
        &&
        {
        ["ace_medical_gui"] call ACEFUNC(common,isModLoaded)
        &&
        {
            [objNull, _entity] call ACEFUNC(medical_gui,canOpenMenu)
        }
        }
    }
}
