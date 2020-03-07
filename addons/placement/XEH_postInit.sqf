#include "script_component.hpp"

["zen_curatorDisplayLoaded", {
    if (!GVAR(enabled)) exitWith {};

    params ["_display"];

    {
        private _ctrl = _display displayCtrl _x;
        _ctrl ctrlAddEventHandler ["TreeSelChanged", {call FUNC(handleTreeSelect)}];
    } forEach [
        IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EAST,
        IDC_RSCDISPLAYCURATOR_CREATE_UNITS_WEST,
        IDC_RSCDISPLAYCURATOR_CREATE_UNITS_GUER,
        IDC_RSCDISPLAYCURATOR_CREATE_UNITS_CIV,
        IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EMPTY
    ];
}] call CBA_fnc_addEventHandler;

["zen_curatorDisplayUnloaded", {
    GVAR(updatePFH) call CBA_fnc_removePerFrameHandler;

    deleteVehicle GVAR(object);
    deleteVehicle GVAR(helper);
}] call CBA_fnc_addEventHandler;

[QEGVAR(editor,modeChanged), LINKFUNC(handleTreeChange)] call CBA_fnc_addEventHandler;
[QEGVAR(editor,sideChanged), LINKFUNC(handleTreeChange)] call CBA_fnc_addEventHandler;
