#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to hide or show Zeus.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleHideZeus
 *
 * Public: No
 */

params ["_logic"];

[LSTRING(ModuleHideZeus), [
    ["TOOLBOX:YESNO", LSTRING(ModuleHideZeus), !isObjectHidden player, true]
], {
    params ["_dialogValues"];
    _dialogValues params ["_invisible"];

    private _curator = getAssignedCuratorLogic player;

    player setCaptive _invisible;
    player allowDamage !_invisible;
    [QEGVAR(common,hideObjectGlobal), [player, _invisible]] call CBA_fnc_serverEvent;

    private _bird = _curator getVariable ["bird", objNull];
    if (!isNull _bird) then {
        [QEGVAR(common,hideObjectGlobal), [_bird, _invisible]] call CBA_fnc_serverEvent;
        [QEGVAR(common,enableSimulationGlobal), [_bird, !_invisible]] call CBA_fnc_serverEvent;
    };

    private _message = [LSTRING(ZeusIsNowVisible), LSTRING(ZeusIsNowHidden)] select _invisible;
    [_message] call EFUNC(common,showMessage);
}] call EFUNC(dialog,create);

deleteVehicle _logic;
