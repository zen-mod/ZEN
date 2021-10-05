#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to make units perform suppressive fire.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleSuppressiveFire
 *
 * Public: No
 */

params ["_logic"];

private _unit = attachedTo _logic;
deleteVehicle _logic;

if (isNull _unit) exitWith {
    [LSTRING(NoUnitSelected)] call EFUNC(common,showMessage);
};

if (!alive _unit) exitWith {
    [LSTRING(OnlyAlive)] call EFUNC(common,showMessage);
};

if (isPlayer _unit) exitWith {
    ["str_a3_cfgvehicles_moduleremotecontrol_f_errorPlayer"] call EFUNC(common,showMessage);
};

if !(side group _unit in [west, east, independent, civilian]) exitWith {
    [LSTRING(OnlySpecificSide)] call EFUNC(common,showMessage);
};

[ELSTRING(ai,SuppressiveFire), [
    [
        "SLIDER",
        [ELSTRING(common,Duration_Units), LSTRING(SuppressiveFire_Duration_Tooltip)],
        [10, 180, 20, 0]
    ],
    [
        "COMBO",
        ["STR_A3_RscAttributeUnitPos_Title", LSTRING(SuppressiveFire_Stance_Tooltip)],
        [
            [
                "UP",
                "MIDDLE",
                "DOWN"
            ],
            [
                ["STR_A3_RscAttributeUnitPos_Up_tooltip",     "", "\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_stand_ca.paa"],
                ["STR_A3_RscAttributeUnitPos_Crouch_tooltip", "", "\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_crouch_ca.paa"],
                ["STR_A3_RscAttributeUnitPos_Down_tooltip",   "", "\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_prone_ca.paa"]
            ],
            1
        ]
    ],
    [
        "TOOLBOX:YESNO",
        [LSTRING(SuppressiveFire_EntireGroup), LSTRING(SuppressiveFire_EntireGroup_Tooltip)],
        true
    ]
], {
    params ["_values", "_unit"];
    _values params ["_duration", "_stance", "_entireGroup"];

    private _units = if (_entireGroup) then {units _unit} else {[_unit]};
    _units = _units apply {vehicle _x};
    _units = _units arrayIntersect _units;

    [_units, {
        params ["_successful", "_units", "_position", "_args"];
        _args params ["_duration", "_stance"];

        if (_successful) then {
            curatorMouseOver params ["_type", "_entity"];

            private _target = [ASLtoATL _position, _entity] select (_type == "OBJECT");
            {
                [_x, _target, _duration, _stance] call EFUNC(ai,suppressiveFire);
            } forEach _units;
        };
    }, [_duration, _stance], ELSTRING(ai,SuppressiveFire)] call EFUNC(common,selectPosition);
}, {}, _unit] call EFUNC(dialog,create);
