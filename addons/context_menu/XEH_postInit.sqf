#include "script_component.hpp"

call FUNC(compileActions);

[QEGVAR(common,displayCuratorLoad), {
    if (GVAR(enabled) != 2) exitWith {};

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

                // Right clicking with AI selected places waypoints
                // Do not want to open context menu when this is the case
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
