#include "script_component.hpp"
/*
 * Author: Ampersand
 * Zeus module function to shoot tracers.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_modules_fnc_moduleTracers
 *
 * Public: No
 */

 params ["_display"];

 private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
 _display closeDisplay IDC_CANCEL; // Close helper display

 // Need to delay dialog creation by one frame to avoid weird input blocking bug
 [{
    params ["_logic"];

    // Default values: green tracers, 10-20s between bursts
    private _tracersParams = _logic getVariable [QGVAR(tracersParams), [0, 10, 20, 2, "", "", 0, ""]];
    _tracersParams params ["_side", "_min", "_max", "_dispersion", "_weapon", "_magazine", "_targetType", "_target"];

    ["str_a3_cfgvehicles_moduletracers_f_0", [
        [
            "TOOLBOX",
            "str_a3_cfgvehicles_moduletracers_f_arguments_side_0",
            [_side, 1, 3, ["str_a3_texturesources_green0", "str_a3_texturesources_red0", "str_a3_texturesources_yellow0"]]
        ],
        [
            "SLIDER",
            ["str_a3_cfgvehicles_moduletracers_f_arguments_min_0", LSTRING(Tracers_MinDelay_Tooltip)],
             [0, 120, _min, 0],
             true
         ],
        [
            "SLIDER",
            ["str_a3_cfgvehicles_moduletracers_f_arguments_max_0", LSTRING(Tracers_MaxDelay_Tooltip)],
            [0, 120, _max, 0],
            true
        ],
        [
            "TOOLBOX",
            LSTRING(Tracers_Dispersion),
            [_dispersion, 1, 5, [
                ELSTRING(common,VeryLow),
                ELSTRING(common,Low),
                ELSTRING(common,Medium),
                ELSTRING(common,High),
                ELSTRING(common,VeryHigh)
            ]]
        ],
        [
            "EDIT",
            "str_a3_itemtype_category_weapon",
            _weapon,
            true
        ],
        [
            "EDIT",
            "str_a3_itemtype_category_magazine",
            _magazine,
            true
        ],
        [
            "TOOLBOX",
            ["str_a3_cfgvehicles_modulelivefeedsettarget_f_arguments_targettype_0", LSTRING(Tracers_TargetType_Tooltip)],
            [0, 1, 3, ["str_a3_no_target", ELSTRING(camera,DisplayName), ELSTRING(common,Cursor)]]
        ]
    ], {
        params ["_values", "_logic"];
        _values params ["_side", "_min", "_max", "_dispersion", "_weapon", "_magazine", "_targetType"];

        private _target = objNull;
        // select tracer target using cursor
        if (_targetType == 2) exitWith {
            [_logic, {
                params ["_successful", "_logic", "_position", "_args"];
                _args params ["_side", "_min", "_max", "_dispersion", "_weapon", "_magazine"];

                if (_successful) then {
                    curatorMouseOver params ["_type", "_entity"];

                    private _target = [_position, _entity] select (_type == "OBJECT");

                    [QGVAR(moduleTracers), [_logic, _side, _min, _max, _dispersion, _weapon, _magazine, _target]] call CBA_fnc_serverEvent;
                };
            }, [_side, _min, _max, _dispersion, _weapon, _magazine], LSTRING(Tracers_TracersTarget)] call EFUNC(common,selectPosition);
        };

        if (_targetType == 1) then {
            _target = AGLToASL positionCameraToWorld [0, 0, 0];
        };

        [QGVAR(moduleTracers), [_logic, _side, _min, _max, _dispersion, _weapon, _magazine, _target]] call CBA_fnc_serverEvent;

    }, {}, _logic] call EFUNC(dialog,create);
}, _logic] call CBA_fnc_execNextFrame;
