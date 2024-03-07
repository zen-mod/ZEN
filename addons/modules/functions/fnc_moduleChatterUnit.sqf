#include "script_component.hpp"
/*
 * Author: mharis001, Ampersand
 * Opens chatter dialog for given AI.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_unit] call zen_modules_fnc_moduleChatterUnit
 *
 * Public: No
 */

params ["_unit"];

if (isNull _unit) exitWith {};

if !(_unit isKindOf "CAManBase") exitWith {
    [LSTRING(OnlyInfantry)] call EFUNC(common,showMessage);
};

if !(alive _unit) exitWith {
    [LSTRING(OnlyAlive)] call EFUNC(common,showMessage);
};

if (isPlayer _unit) exitWith {
    ["str_a3_cfgvehicles_moduleremotecontrol_f_errorPlayer"] call EFUNC(common,showMessage);
};

[format ["%1 (%2)", localize LSTRING(ModuleChatter), name _unit], [
    ["EDIT", LSTRING(ModuleChatter_Message), "", true],
    ["COMBO", LSTRING(ModuleChatter_Channel), [[], [
        ["STR_channel_global",  "", "", [0.85, 0.85, 0.85, 1]],
        ["STR_channel_side",    "", "", [0.27, 0.83, 0.99, 1]],
        ["STR_channel_command", "", "", [1, 1, 0.27, 1]],
        ["STR_channel_group",   "", "", [0.71, 0.97, 0.38, 1]],
        ["STR_channel_vehicle", "", "", [1, 0.82, 0, 1]]
    ], 0, true]]
], {
    params ["_dialogValues", "_unit"];
    _dialogValues params ["_message", "_channel"];

    if (_message == "") exitWith {};

    // Get chat type from channel number
    private _chatType = [
        QEGVAR(common,globalChat),
        QEGVAR(common,sideChat),
        QEGVAR(common,commandChat),
        QEGVAR(common,groupChat),
        QEGVAR(common,vehicleChat)
    ] select _channel;

    // Edit message to indicate AI communication
    _message = format ["%1 [AI]: %2", name _unit, _message];

    // Ensure vehicle of unit if vehicle chat
    if (_channel == 4) then {
        _unit = vehicle _unit;
    };

    // Send message over given chat channel
    [_chatType, [_unit, _message]] call CBA_fnc_globalEvent;
}, {}, _unit] call EFUNC(dialog,create);
