#include "script_component.hpp"

["ZEN_displayCuratorLoad", {
    if (GVAR(enabled)) then {
        call FUNC(start);
    };
}] call CBA_fnc_addEventHandler;

["ZEN_displayCuratorUnload", {
    call FUNC(stop);
}] call CBA_fnc_addEventHandler;

["CBA_SettingChanged", {
    params ["_setting", "_value"];
    if (_setting isEqualTo QGVAR(enabled)) then {
        if (isNull (findDisplay IDD_RSCDISPLAYCURATOR)) exitWith {};
        if (_value) then {
            call FUNC(start);
        } else {
            call FUNC(stop);
        };
    };
}] call CBA_fnc_addEventHandler;
