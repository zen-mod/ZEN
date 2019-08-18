#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles clicking the traits button.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_attributes_fnc_buttonTraits
 *
 * Public: No
 */

private _unit = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
private _options = [];

if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then {
    private _default = _unit getVariable ["ace_medical_medicClass", parseNumber (_unit getUnitTrait "medic")];
    _options pushBack ["TOOLBOX", LSTRING(MedicalTraining), [_default, 1, 3, ["STR_A3_None", "STR_support_medic", LSTRING(Doctor)]], true];
} else {
    _options pushBack ["TOOLBOX:YESNO", "STR_support_medic", _unit getUnitTrait "medic", true];
};

if (isClass (configFile >> "CfgPatches" >> "ace_repair")) then {
    private _default = _unit getVariable ["ACE_isEngineer", _unit getUnitTrait "engineer"];

    if (_default isEqualType false) then {
        _default = parseNumber _default;
    };

    _options pushBack ["TOOLBOX", LSTRING(EngineeringSkill), [_default, 1, 3, ["STR_A3_None", "str_b_engineer_f0", LSTRING(AdvEngineer)]], true];
} else {
    _options pushBack ["TOOLBOX:YESNO", "str_b_engineer_f0", _unit getUnitTrait "engineer", true];
};

if (isClass (configFile >> "CfgPatches" >> "ace_explosives")) then {
    _options pushBack ["TOOLBOX:YESNO", "str_b_soldier_exp_f0", _unit call ace_common_fnc_isEOD, true];
} else {
    _options pushBack ["TOOLBOX:YESNO", LSTRING(EOD), _unit getUnitTrait "explosiveSpecialist", true];
};

[LSTRING(ChangeTraits), _options, {
    params ["_values", "_unit"];
    _values params ["_medic", "_engineer", "_eod"];

    private _units = [_unit] call FUNC(getAttributeEntities);

    if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then {
        {
            _x setVariable ["ace_medical_medicClass", _medic, true];
        } forEach _units;
    } else {
        {
            [QEGVAR(common,setUnitTrait), [_x, "medic", _medic], _x] call CBA_fnc_targetEvent;
        } forEach _units;
    };

    if (isClass (configFile >> "CfgPatches" >> "ace_repair")) then {
        {
            _x setVariable ["ACE_isEngineer", _engineer, true];
        } forEach _units;
    } else {
        {
            [QEGVAR(common,setUnitTrait), [_x, "engineer", _engineer], _x] call CBA_fnc_targetEvent;
        } forEach _units;
    };

    if (isClass (configFile >> "CfgPatches" >> "ace_explosives")) then {
        {
            _x setVariable ["ACE_isEOD", _eod, true];
        } forEach _units;
    } else {
        {
            [QEGVAR(common,setUnitTrait), [_x, "explosiveSpecialist", _eod], _x] call CBA_fnc_targetEvent;
        } forEach _units;
    };
}, {}, _unit] call EFUNC(dialog,create);
