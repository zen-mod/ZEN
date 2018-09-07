#include "script_component.hpp"

call FUNC(compileActions);

// Add keybind
[ELSTRING(Common,Category), QGVAR(openKey), LSTRING(Keybind), {
    if (GVAR(enabled) && {!isNull curatorCamera}) then {
        call FUNC(openMenu);
    };
}, {}, [46, [false, false, false]]] call CBA_fnc_addKeybind; // Default: C

[QEGVAR(common,zeusDisplayLoad), {
    if (!GVAR(enabled)) exitWith {};

    params ["_display"];

    private _ctrlMouseArea = _display displayCtrl 53;

    _ctrlMouseArea ctrlAddEventHandler ["MouseButtonDown", {
        params ["", "_button"];

        if (_button isEqualTo 1) then {
            GVAR(holdingRMB) = true;
        } else {
            call FUNC(closeMenu);
        };
    }];

    _ctrlMouseArea ctrlAddEventHandler ["MouseButtonUp", {
        params ["", "_button"];

        if (_button isEqualTo 1) then {
            GVAR(holdingRMB) = false;

            curatorSelected params ["_selectedObjects", "_selectedGroups", "_selectedWaypoints"];
            if (GVAR(canContext) &&
                {_selectedWaypoints isEqualTo []} &&
                {_selectedGroups findIf {!isPlayer leader _x} == -1} &&
                {_selectedObjects findIf {_x isKindOf "CAManBase" && {!isPlayer leader _x}} == -1}
            ) then {
                call FUNC(openMenu);
            };
        };
    }];

    _ctrlMouseArea ctrlAddEventHandler ["MouseMoving", {
        if (GVAR(holdingRMB)) then {
            GVAR(canContext) = false;
        };
    }];

    _ctrlMouseArea ctrlAddEventHandler ["MouseHolding", {
        if (!GVAR(holdingRMB)) then {
            GVAR(canContext) = true;
        };
    }];
}] call CBA_fnc_addEventHandler;
