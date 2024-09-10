#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to assign a player as Zeus.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleAssignZeus
 *
 * Public: No
 */

params ["_logic"];

private _unit = attachedTo _logic;
deleteVehicle _logic;

if (isNull _unit) exitWith {
    [LSTRING(NoUnitSelected)] call EFUNC(common,showMessage);
};

if !(_unit isKindOf "CAManBase" && {isPlayer _unit}) exitWith {
    [LSTRING(OnlyPlayers)] call EFUNC(common,showMessage);
};

if (!isNull getAssignedCuratorLogic _unit) exitWith {
    [LSTRING(ModuleAssignZeus_AlreadyZeus)] call EFUNC(common,showMessage);
};

[QEGVAR(common,createZeus), _unit] call CBA_fnc_serverEvent;
[QEGVAR(common,hint), localize LSTRING(ModuleAssignZeus_Promoted), _unit] call CBA_fnc_targetEvent;
