#include "script_component.hpp"

["zen_curatorDisplayLoaded", LINKFUNC(handleLoad)] call CBA_fnc_addEventHandler;
["zen_curatorDisplayUnloaded", LINKFUNC(handleUnload)] call CBA_fnc_addEventHandler;
[QGVAR(modeChanged), LINKFUNC(fixSideButtons)] call CBA_fnc_addEventHandler;

[QGVAR(pingCurator), {
    params ["_object"];

    if (isNull curatorCamera) exitWith {};
    [_curatorLogic, _object] call BIS_fnc_curatorPinged;
    [[
        ["ICON", [_object, "\a3\ui_f_curator\Data\Logos\arma3_curator_eye_256_ca.paa"]]
    ], 3, _object] call EFUNC(common,drawHint);
}] call CBA_fnc_addEventHandler;
