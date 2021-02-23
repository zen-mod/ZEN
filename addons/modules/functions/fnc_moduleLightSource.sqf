#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to create a light source.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_modules_fnc_moduleLightSource
 *
 * Public: No
 */

params ["_display"];

private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
_display closeDisplay IDC_CANCEL; // Close helper display

// Need to delay dialog creation by one frame to avoid weird input blocking bug
[{
    params ["_logic"];

    // Default values are that of a relatively small white light source
    private _lightParams = _logic getVariable [QGVAR(lightParams), [[1, 1, 1], [10, 75, 1, 1]]];
    _lightParams params ["_color", "_attenuation"];
    _attenuation params ["_range", "_constant", "_linear", "_quadratic"];

    [LSTRING(ModuleLightSource), [
        ["COLOR",  LSTRING(ModuleLightSource_Color), +_color, true],
        ["SLIDER:RADIUS", LSTRING(ModuleLightSource_Range), [1, 1000, _range, 0, _logic], true],
        ["SLIDER", LSTRING(ModuleLightSource_Constant), [0, 100, _constant, 1], true],
        ["SLIDER", LSTRING(ModuleLightSource_Linear), [0, 100, _linear, 1], true],
        ["SLIDER", LSTRING(ModuleLightSource_Quadratic), [0, 100, _quadratic, 1], true]
    ], {
        params ["_dialogValues", "_logic"];
        _dialogValues params ["_color", "_range", "_constant", "_linear", "_quadratic"];

        // Create lightpoint for logic if it does not exist already
        private _lightpoint = _logic getVariable QGVAR(lightpoint);

        if (isNil "_lightpoint") then {
            _lightpoint = createVehicle ["#lightpoint", [0, 0, 0], [], 0, "CAN_COLLIDE"];
            _logic setVariable [QGVAR(lightpoint), _lightpoint, true];

            // Add logic object to all curators once it has lightpoint for QOL
            [QEGVAR(common,addObjects), [[_logic]]] call CBA_fnc_serverEvent;

            // Add event handler to delete lightpoint if logic is deleted
            [QEGVAR(common,execute), [{
                params ["_logic"];

                _logic addEventHandler ["Deleted", {
                    params ["_logic"];
                    deleteVehicle (_logic getVariable [QGVAR(lightpoint), objNull]);
                }];
            }, _logic]] call CBA_fnc_serverEvent;
        };

        // Apply new light source parameters
        [QEGVAR(common,execute), [{
            params ["_logic", "_lightpoint", "_color", "_attenuation"];

            _lightpoint lightAttachObject [_logic, [0, 0, 0]];
            _lightpoint setLightBrightness 1;
            _lightpoint setLightAmbient _color;
            _lightpoint setLightColor _color;
            _lightpoint setLightAttenuation _attenuation;
        }, [_logic, _lightpoint, _color, [_range, _constant, _linear, _quadratic]]]] call CBA_fnc_globalEventJIP;

        _logic setVariable [QGVAR(lightParams), [_color, [_range, _constant, _linear, _quadratic]], true];
    }, {
        params ["", "_logic"];

        // Delete logic on cancel if it does not have an attached lightpoint
        private _lightpoint = _logic getVariable QGVAR(lightpoint);
        if (isNil "_lightpoint") then {deleteVehicle _logic};
    }, _logic] call EFUNC(dialog,create);
}, _logic] call CBA_fnc_execNextFrame;
