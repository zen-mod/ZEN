#include "script_component.hpp"
/*
 * Author: mharis001
 * Closes the display if the given entity is altered.
 *
 * Arguments:
 * 0: Display <OBJECT>
 * 1: Entity <OBJECT|GROUP|ARRAY|STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY, _entity] call zen_attributes_fnc_check
 *
 * Public: No
 */

params ["_display", "_entity"];

if (_entity isEqualType objNull) exitWith {
    [{
        params ["_display", "_entity", "_wasAlive"];

        isNull _display || {isNull _entity} || {_wasAlive && {!alive _entity}}
    }, {
        params ["_display"];

        _display closeDisplay IDC_CANCEL;
    }, [_display, _entity, alive _entity]] call CBA_fnc_waitUntilAndExecute;
};

if (_entity isEqualType grpNull) exitWith {
    [{
        params ["_display", "_entity"];

        isNull _display || {isNull _entity}
    }, {
        params ["_display"];

        _display closeDisplay IDC_CANCEL;
    }, [_display, _entity]] call CBA_fnc_waitUntilAndExecute;
};

if (_entity isEqualType []) exitWith {
    [{
        params ["_display", "_entity"];
        _entity params ["_group", "_index"];

        isNull _display || {isNull _group} || {count waypoints _group <= _index}
    }, {
        params ["_display"];

        _display closeDisplay IDC_CANCEL;
    }, [_display, _entity]] call CBA_fnc_waitUntilAndExecute;
};

if (_entity isEqualType "") exitWith {
    [{
        params ["_display", "_entity"];

        isNull _display || {markerType _entity == ""}
    }, {
        params ["_display"];

        _display closeDisplay IDC_CANCEL;
    }, [_display, _entity]] call CBA_fnc_waitUntilAndExecute;
};
