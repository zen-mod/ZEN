#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the Zeus Display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_context_menu_fnc_initDisplayCurator
 *
 * Public: No
 */

params ["_display"];

// No EHs needed if completely disabled
if (GVAR(enabled) == 0) exitWith {};

// Add EHs to close menu when user interacts with other display elements
{
    private _ctrl = _display displayCtrl _x;
    _ctrl ctrlAddEventHandler ["MouseButtonDown", {
        call FUNC(closeMenu);
    }];
} forEach [
    IDC_RSCDISPLAYCURATOR_ADD,
    IDC_RSCDISPLAYCURATOR_ADDBAR,
    IDC_RSCDISPLAYCURATOR_MISSION,
    IDC_RSCDISPLAYCURATOR_MISSIONBAR,
    IDC_RSCDISPLAYCURATOR_COMPASS,
    IDC_RSCDISPLAYCURATOR_CLOCK,
    IDC_RSCDISPLAYCURATOR_MAIN
];

// Just mouse button EH to close menu when keybind only
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
                && {!call EFUNC(common,isPlacementActive)}
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
