#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to send AI communication over chat.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleChatter
 *
 * Public: No
 */

params ["_logic"];

private _unit = effectiveCommander attachedTo _logic;
deleteVehicle _logic;

if (isNull _unit) then {
    [LSTRING(ModuleChatter), [
        ["EDIT", LSTRING(ModuleChatter_Message)],
        ["SIDES", ELSTRING(common,Side), west]
    ], {
        params ["_dialogValues"];
        _dialogValues params ["_message", "_side"];

        if (_message == "") exitWith {};

        // Send message from HQ is using side
        [QEGVAR(common,sideChat), [[_side, "HQ"], _message]] call CBA_fnc_globalEvent;
    }] call EFUNC(dialog,create);
} else {
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
        ["EDIT", LSTRING(ModuleChatter_Message)],
        ["COMBO", LSTRING(ModuleChatter_Channel), [[], [
            ["STR_channel_global",  "", "", [0.85, 0.85, 0.85, 1]],
            ["STR_channel_side",    "", "", [0.27, 0.83, 0.99, 1]],
            ["STR_channel_command", "", "", [1, 1, 0.27, 1]],
            ["STR_channel_group",   "", "", [0.71, 0.97, 0.38, 1]],
            ["STR_channel_vehicle", "", "", [1, 0.82, 0, 1]]
        ], 1]]
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
};
