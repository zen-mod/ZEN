#include "script_component.hpp"

[QEGVAR(common,moduleSetup), {
    params ["_module"];

    _module addEventHandler ["CuratorMarkerPlaced", {
        params ["_curator", "_marker"];
        private _color = [GVAR(markerColorHash), markerType _marker] call CBA_fnc_hashGet;
        _marker setMarkerColor _color;
    }];
}] call CBA_fnc_addEventHandler;
