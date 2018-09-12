#include "script_component.hpp"

// Add keybind to toggle include crew
[ELSTRING(Common,Category), QGVAR(toggleIncludeCrew), LSTRING(ToggleIncludeCrew), {
    if (!isNull curatorCamera) then {
        GVAR(includeCrew) = !GVAR(includeCrew);
        (findDisplay IDD_RSCDISPLAYCURATOR displayCtrl IDC_INCLUDE_CREW) cbSetChecked GVAR(includeCrew);
    };
}, {}, [0, [false, false, false]]] call CBA_fnc_addKeybind; // Default: Unbound

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
