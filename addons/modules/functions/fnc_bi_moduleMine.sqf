#include "script_component.hpp"
/*
 * Author: Bohemia Interactive
 * Module function for spawning mines.
 * Edited to remove forced map markers, mines being revealed to players, and placement hint.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 * 1: Units <ARRAY>
 * 2: Activated <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC, [], true] call zen_modules_fnc_bi_moduleMine
 *
 * Public: No
 */

params ["_logic", "_units", "_activated"];

if (_activated) then {
    private _explosive = getText (configOf _logic >> "explosive");

    if (_explosive != "") then {
        _explosive = createVehicle [_explosive, _logic, [], 0, "NONE"];
        _explosive attachTo [_logic];

        // Support ace_zeus settings to control if mines are revealed
        private _revealMines = missionNamespace getVariable ["ace_zeus_revealMines", 0];

        if (_revealMines > 0) then {
            // Reveal the mine to curator's side
            {
                _side = (getAssignedCuratorLogic _x) call BIS_fnc_objectSide;
                _side revealMine _explosive;
            } forEach (objectCurators _logic);

            if (_revealMines > 1) then {
                // Mark minefields in the map
                [] spawn BIS_fnc_drawMinefields;
            };
        };

        waitUntil {sleep 0.1; isNull _explosive || isNull _logic || !alive _logic};
        if (isNull _logic) then {deleteVehicle _explosive} else {_explosive setDamage 1};
        deleteVehicle _logic;
    };
};
