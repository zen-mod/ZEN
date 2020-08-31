#include "script_component.hpp"
/*
 * Author: Ampersand
 * Zeus module function to choose a throwable and make unit throw it.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleThrowSelect
 *
 * Public: No
 */

params ["_logic"];

private _unit = attachedTo _logic;
deleteVehicle _logic;

if (isNull _unit) exitWith {
    [LSTRING(NoObjectSelected)] call EFUNC(common,showMessage);
};

if !(_unit isKindOf "Man") exitWith {
    [LSTRING(OnlyInfantry)] call EFUNC(common,showMessage);
};

if !(alive _unit) exitWith {
    [LSTRING(OnlyAlive)] call EFUNC(common,showMessage);
};

private _mags = magazines _unit;
private _throwables = (_mags arrayIntersect _mags) select {_x call BIS_fnc_isThrowable};

private _action = [];
{
    _action = [
        _x,
        getText (configFile >> "CfgMagazines" >> _x >> "displayName"),
        getText (configFile >> "CfgMagazines" >> _x >> "picture"),
        {
            (_this # 6) params ["_unit", "_magazine"];
            // Get target position
            [_unit, {
                params ["_successful", "_unit", "_mousePosASL", "_arguments"];
                if (_successful) then {
                    _arguments params ["_magazine"];
                    private _muzzle = configName (("_magazine in (getArray (_x >> 'magazines'))" configClasses (configFile >> "CfgWeapons" >> "Throw")) # 0);
                    private _firemode = _muzzle;
                    [_unit, _magazine, _muzzle, _firemode, _mousePosASL] call FUNC(projectiles_zeus);
                };
            }, [_magazine], LSTRING(ModuleThrowSelect)] call EFUNC(common,selectPosition);

        },
        {true},
        [_unit, _x]
    ] call EFUNC(context_menu,createAction);
    [_action, [], 0] call EFUNC(context_menu,addAction);
} forEach _throwables;
[] call EFUNC(context_menu,open);

// remove actions on menu close
[{
    EGVAR(context_menu,contextGroups) isEqualTo []
},{
    _this apply {[_x] call zen_context_menu_fnc_removeAction};
}, _throwables, 15, {}] call CBA_fnc_waitUntilAndExecute;
