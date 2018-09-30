/*
 * Author: mharis001
 * Hides or unhides Zeus.
 *
 * Arguments:
 * 0: Invisible <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [true] call zen_modules_fnc_moduleHideZeus
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_invisible"];
TRACE_1("Module Hide Zeus",_this);

private _player = player;
private _logic = getAssignedCuratorLogic _player;

// Handle zeus player
_player setCaptive _invisible;
_player allowDamage !_invisible;
[QEGVAR(common,hideObjectGlobal), [_player, _invisible]] call CBA_fnc_serverEvent;

// Handle zeus bird
private _bird = _logic getVariable ["bird", objNull];
if (!isNull _bird) then {
    [QEGVAR(common,hideObjectGlobal), [_bird, _invisible]] call CBA_fnc_serverEvent;
    [QEGVAR(common,enableSimulationGlobal), [_bird, !_invisible]] call CBA_fnc_serverEvent;
};

// Show feedback message
private _message = [LSTRING(ZeusIsNowVisible), LSTRING(ZeusIsNowHidden)] select _invisible;
[_message] call EFUNC(common,showMessage);
