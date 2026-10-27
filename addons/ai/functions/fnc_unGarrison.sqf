#include "script_component.hpp"
/*
 * Author: Alganthe
 * Un-garrisons given units from their buildings.
 *
 * Arguments:
 * N: Units <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [unit1, unit2] call zen_ai_fnc_unGarrison
 *
 * Public: No
 */

{
    if (local _x && {!isPlayer _x} && {_x getVariable [QGVAR(garrisoned), false]}) then {
        _x enableAI "PATH";
        _x enableAI "FSM";

        private _leader = leader _x;

        if (_leader == _x) then {
            _x doMove (nearestBuilding _x buildingExit 0);
        } else {
            doStop _x;
            _x doFollow _leader;
        };

        if (units _x findIf {!isPlayer _x && {!(_x getVariable [QGVAR(garrisoned), false])}} == -1) then {
            group _x enableAttack true;
        };

        _x setVariable [QGVAR(garrisoned), false, true];

        // End fix for rotating garrisoned units
        _x doWatch objNull;
    };
} forEach _this;
