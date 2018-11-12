#include "script_component.hpp"

[QEGVAR(common,moduleSetup), {
    params ["_module"];

    _module addEventHandler ["CuratorMarkerPlaced", {
        params ["_curator", "_marker"];
        _marker setMarkerColor (_curator getVariable [QGVAR(lastMarkerColor), "Default"]);
    }];
}] call CBA_fnc_addEventHandler;
