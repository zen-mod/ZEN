#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the "Lights" Zeus attribute.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_attributes_fnc_attributeLights
 *
 * Public: No
 */

#define IDCS [IDC_LIGHTS_OFF, IDC_LIGHTS_ON]

params ["_display"];

private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
private _ctrlButtonOK = _display displayCtrl IDC_OK;

if (!alive _entity) exitWith {
    private _ctrlLights = _display displayCtrl IDC_LIGHTS;
    _ctrlLights ctrlEnable false;
};

private _fnc_onButtonClick = {
    params ["_activeCtrl"];

    private _display = ctrlParent _activeCtrl;
    private _activeIDC = ctrlIDC _activeCtrl;

    {
        private _ctrl = _display displayCtrl _x;
        private _color = [1, 1, 1, 0.5];
        private _scale = 1;

        if (_activeIDC == _x) then {
            _color set [3, 1];
            _scale = 1.2;
        };

        _ctrl ctrlSetTextColor _color;
        [_ctrl, _scale, 0.1] call BIS_fnc_ctrlSetScale;
    } forEach IDCS;

    private _lights = IDCS find _activeIDC == 1;
    _display setVariable [QGVAR(lights), _lights];
};

private _activeIDC = IDCS select isLightOn _entity;

{
    private _ctrl = _display displayCtrl _x;
    _ctrl ctrlAddEventHandler ["ButtonClick", _fnc_onButtonClick];

    if (_activeIDC == _x) then {
        _ctrl ctrlSetTextColor [1, 1, 1, 1];
        [_ctrl, 1.2, 0] call BIS_fnc_ctrlSetScale;
    };
} forEach IDCS;

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    private _lights = _display getVariable QGVAR(lights);
    if (isNil "_lights") exitWith {};

    private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    {
        [QEGVAR(common,setPilotLight), [_x, _lights], _x] call CBA_fnc_targetEvent;
        [QEGVAR(common,setCollisionLight), [_x, _lights], _x] call CBA_fnc_targetEvent;

        // Prevent AI from switching forced lights state
        private _driver = driver _x;

        if !(isNull _driver || {isPlayer _driver}) then {
            [QEGVAR(common,disableAI), [_x, "LIGHTS"], _x] call CBA_fnc_targetEvent;
        };
    } forEach (_entity call FUNC(getAttributeEntities));
};

_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
