/*
 * Author: mharis001
 * Sends AI communication over chat.
 *
 * Arguments:
 * 0: Message <STRING>
 * 1: Use Side <BOOL>
 * 2: Side <SIDE>
 * 3: Channel <NUMBER>
 * 4: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["Hello World"] call zen_modules_fnc_moduleChatter
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_message", "_useSide", "_side", "_channel", "_unit"];
TRACE_1("Module Chatter",_this);

if (_useSide) then {
    // Send message from HQ is using side
    [QEGVAR(common,sideChat), [[_side, "HQ"], _message]] call CBA_fnc_globalEvent;
} else {
    // Get chat type from channel number
    private _chatType = [
        QEGVAR(common,globalChat),
        QEGVAR(common,sideChat),
        QEGVAR(common,commandChat),
        QEGVAR(common,groupChat),
        QEGVAR(common,vehicleChat)
    ] select _channel;

    // Edit message to indicate AI communication
    _message = format ["(%1 [AI]) %2", name _unit, _message];

    // Ensure vehicle of unit if vehicle chat
    if (_channel isEqualTo 4) then {
        _unit = vehicle _unit;
    };

    // Send message over given chat channel
    [_chatType, [_unit, _message]] call CBA_fnc_globalEvent;
};
