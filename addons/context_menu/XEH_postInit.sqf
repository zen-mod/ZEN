#include "script_component.hpp"

[QEGVAR(common,displayCuratorLoad), {
    params ["_display"];

    // No EHs needed if completely disabled
    if (GVAR(enabled) == 0) exitWith {};

    // Just mouse button EH to close when keybind only
    if (GVAR(enabled) == 1) exitWith {
        {
            private _ctrl = _display displayCtrl _x;
            _ctrl ctrlAddEventHandler ["MouseButtonDown", {
                call FUNC(closeMenu);
            }];
        } forEach [
            IDC_RSCDISPLAYCURATOR_MAINMAP,
            IDC_RSCDISPLAYCURATOR_MOUSEAREA
        ];
    };

    // Add full mouse EHs if keybind and mouse enabled
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
                if (
                    GVAR(canContext)
                    && {_selectedWaypoints isEqualTo []}
                    && {_selectedGroups findIf {!isPlayer leader _x} == -1}
                    && {_selectedObjects findIf {!isPlayer leader _x && {!isNull group _x}} == -1}
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
