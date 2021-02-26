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
        call FUNC(close);
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
            call FUNC(close);
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
            call FUNC(close);
        };
    }];

    _ctrl ctrlAddEventHandler ["MouseButtonUp", {
        params ["", "_button", "", "", "_shift"];

        if (_button isEqualTo 1) then {
            GVAR(holdingRMB) = false;

            if (GVAR(canContext) && {!EGVAR(common,selectPositionActive)} && {!call EFUNC(common,isPlacementActive)}) then {
                // Right clicking with AI selected normally places waypoints
                // Only open context menu when this is the case if overriding waypoints is enabled and the SHIFT key is held down
                private _canPlaceWaypoints = SELECTED_WAYPOINTS isNotEqualTo []
                    || {SELECTED_GROUPS findIf {!isPlayer leader _x && {side _x != sideLogic}} != -1}
                    || {SELECTED_OBJECTS findIf {!isPlayer leader _x && {!isNull group _x} && {side group _x != sideLogic}} != -1};

                if (!_canPlaceWaypoints || {GVAR(overrideWaypoints) && {!_shift}}) then {
                    [] call FUNC(open);

                    // Clear selected entities if waypoint placement can occur and restore next frame
                    // Using entities tree as an alternative to the lack of a command to set curator selected entities
                    if (_canPlaceWaypoints) then {
                        private _ctrlEntities = findDisplay IDD_RSCDISPLAYCURATOR displayCtrl IDC_RSCDISPLAYCURATOR_ENTITIES;
                        private _selection = tvSelection _ctrlEntities;
                        _ctrlEntities tvSetCurSel [-1];

                        [{
                            params ["_ctrlEntities", "_selection"];

                            {
                                _ctrlEntities tvSetSelected [_x, true];
                            } forEach _selection;
                        }, [_ctrlEntities, _selection]] call CBA_fnc_execNextFrame;
                    };
                };
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
