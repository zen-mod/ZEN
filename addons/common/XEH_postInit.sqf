#include "script_component.hpp"

[QGVAR(hint), {
    params ["_message"];
    hint _message;
}] call CBA_fnc_addEventHandler;

[QGVAR(globalChat), {
    params ["_unit", "_message"];
    _unit globalChat _message;
}] call CBA_fnc_addEventHandler;

[QGVAR(sideChat), {
    params ["_unit", "_message"];
    _unit sideChat _message;
}] call CBA_fnc_addEventHandler;

[QGVAR(commandChat), {
    params ["_unit", "_message"];
    _unit commandChat _message;
}] call CBA_fnc_addEventHandler;

[QGVAR(groupChat), {
    params ["_unit", "_message"];
    _unit groupChat _message;
}] call CBA_fnc_addEventHandler;

[QGVAR(vehicleChat), {
    params ["_unit", "_message"];
    _unit vehicleChat _message;
}] call CBA_fnc_addEventHandler;

[QGVAR(setUnitPos), {
    params ["_unit", "_mode"];
    _unit setUnitPos _mode;
}] call CBA_fnc_addEventHandler;

[QGVAR(setBehaviour), {
    params ["_group", "_behaviour"];
    _group setBehaviour _behaviour;
}] call CBA_fnc_addEventHandler;

[QGVAR(setSpeedMode), {
    params ["_group", "_mode"];
    _group setSpeedMode _mode;
}] call CBA_fnc_addEventHandler;

if (isServer) then {
    [QGVAR(hideObjectGlobal), {
        params ["_object", "_hide"];
        _object hideObjectGlobal _hide;
    }] call CBA_fnc_addEventHandler;

    [QGVAR(enableSimulationGlobal), {
        params ["_object", "_enable"];
        _object enableSimulationGlobal _enable;
    }] call CBA_fnc_addEventHandler;

    [QGVAR(setFriend), {
        params ["_side1", "_side2", "_value"];
        _side1 setFriend [_side2, _value];
    }] call CBA_fnc_addEventHandler;

    [QGVAR(addObjects), {
        params ["_objects", ["_curator", objNull]];

        if (!isNull _curator) exitWith {
            _curator addCuratorEditableObjects [_objects, true];
        };

        {
            _x addCuratorEditableObjects [_objects, true];
        } forEach allCurators;
    }] call CBA_fnc_addEventHandler;

    [QGVAR(removeObjects), {
        params ["_objects", ["_curator", objNull]];

        if (!isNull _curator) exitWith {
            _curator removeCuratorEditableObjects [_objects, true];
        };

        {
            _x removeCuratorEditableObjects [_objects, true];
        } forEach allCurators;
    }] call CBA_fnc_addEventHandler;
};
