#include "script_component.hpp"
/*
 * Author: Kex
 *
 * Orders a unit to reload defined magazine commence fire burst on the given
 * position (silently). Also supports VLS.
 *
 * Arguments:
 * 0: Artillery unit <OBJECT>
 * 1: Target position <ARRAY>
 * 2: Magazine class <STRING>
 * 3: Number of rounds <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [artilleryUnit, getPos player, magazineClass, 1] call zen_common_fnc_doArtilleryFire
 *
 * Public: No
 */

params ["_unit", "_targetPosition", "_magazineClass", "_rounds"];

if (_unit isKindOf CLASS_VLS_BASE) then
{
    private _weaponClass = (weapons _unit) param [0,""];

    if (_unit currentMagazineTurret [0] != _magazineClass) then {
        // Unfortunately, the reloaded EH is useless here
        private _magazineReloadTime = (1.3 * getNumber (configfile >> "CfgWeapons" >> _weaponClass >> "magazineReloadTime"));
        _unit loadMagazine [[0], _weaponClass, _magazineClass];
        [
            FUNC(vlsFireNoLoading),
            _this,
            _magazineReloadTime
        ] call CBA_fnc_waitAndExecute;
    } else {
        _this call FUNC(vlsFireNoLoading);
    };
} else {
    _unit doArtilleryFire [_position, _magazine, _rounds];
};
