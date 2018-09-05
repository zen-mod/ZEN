#include "script_component.hpp"

[QEGVAR(common,zeusDisplayLoad), {
    params ["_display"];

    private _ctrlMouseArea = _display displayCtrl 53;

    _ctrlMouseArea ctrlAddEventHandler ["MouseButtonDown", {
        params ["_ctrlMouseArea", "_button"];

        if (_button isEqualTo 1) then {
            GVAR(rightClick) = true;
        };
    }];

    _ctrlMouseArea ctrlAddEventHandler ["MouseButtonUp", {
        params ["_ctrlMouseArea", "_button"];

        if (_button isEqualTo 0) exitwith {
            [] call FUNC(close);
        };

        if (_button isEqualTo 1) then {
            GVAR(rightClick) = false;
            if (GVAR(canContext) && {curatorSelected isEqualTo [[], [], [], []]}) then {
                [] call FUNC(open);
            };
        };
    }];

    _ctrlMouseArea ctrlAddEventHandler ["MouseMoving", {
        params ["_ctrlMouseArea"];

        if (GVAR(rightClick)) then {
            GVAR(canContext) = false;
        };
    }];

    _ctrlMouseArea ctrlAddEventHandler ["MouseHolding", {
        params ["_ctrlMouseArea"];

        if (!GVAR(rightClick)) then {
            GVAR(canContext) = true;
        };
    }];
}] call CBA_fnc_addEventHandler;
