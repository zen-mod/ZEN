#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to detonate a nuclear bomb.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleNuke
 *
 * Public: No
 */

params ["_logic"];

private _position = getPosASL _logic;
deleteVehicle _logic;

[LSTRING(AtomicBomb), [
    [
        "SLIDER:RADIUS",
        LSTRING(DestructionRadius),
        [0, 5000, 200, 0, ASLtoAGL _position, [1, 0, 0, 0.7]]
    ],
    [
        "EDIT",
        [LSTRING(DestructionRate), LSTRING(DestructionRate_Tooltip)],
        "300"
    ],
    [
        "TOOLBOX:ENABLED",
        LSTRING(ColorCorrections),
        false
    ]
], {
    params ["_values", "_position"];
    _values params ["_destructionRadius", "_destructionRate", "_colorCorrections"];

    [
        "",
        format ["<t size='0.8'>%1</t>", localize LSTRING(ConfirmDetonation)],
        {
            [QGVAR(moduleNuke), _this] call CBA_fnc_globalEvent;
        },
        {},
        [_position, _destructionRadius, parseNumber _destructionRate, _colorCorrections],
        QPATHTOF(ui\nuke_ca.paa)
    ] call EFUNC(common,messageBox);
}, {}, _position] call EFUNC(dialog,create);
