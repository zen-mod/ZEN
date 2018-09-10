#include "script_component.hpp"

[QEGVAR(common,moduleSetup), {
    params ["_module"];
    _module addEventHandler ["CuratorObjectPlaced", {call FUNC(handleObjectPlaced)}];
}] call CBA_fnc_addEventHandler;

[QEGVAR(common,displayCuratorLoad), {
    params ["_display"];

    if (GVAR(removeWatermark)) then {
        private _ctrlWatermark = _display displayCtrl IDC_RSCDISPLAYCURATOR_WATERMARK;
        _ctrlWatermark ctrlSetText "";
    };
}] call CBA_fnc_addEventHandler;
