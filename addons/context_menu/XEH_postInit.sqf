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

    {
        private _ctrl = _display displayCtrl _x;

        _ctrl ctrlAddEventHandler ["MouseButtonDown", {
            params ["", "_button"];

            if (_button isEqualTo 1) then {
                GVAR(holdingRMB) = true;
            } else {
                call FUNC(closeMenu);
            };
        }];

        _ctrl ctrlAddEventHandler ["MouseButtonUp", {
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

        _ctrl ctrlAddEventHandler ["MouseMoving", {
            if (GVAR(holdingRMB)) then {
                GVAR(canContext) = false;
            };
        }];

        _ctrl ctrlAddEventHandler ["MouseHolding", {
            if (!GVAR(holdingRMB)) then {
                GVAR(canContext) = true;
            };
        }];
    } forEach [
        IDC_RSCDISPLAYCURATOR_MAINMAP,
        IDC_RSCDISPLAYCURATOR_MOUSEAREA
    ];
}] call CBA_fnc_addEventHandler;
