#include "script_component.hpp"

[QEGVAR(common,moduleSetup), {
    params ["_module"];
    _module addEventHandler ["CuratorObjectPlaced", {call FUNC(handleObjectPlaced)}];
}] call CBA_fnc_addEventHandler;
