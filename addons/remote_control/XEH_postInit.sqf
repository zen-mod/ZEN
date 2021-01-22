#include "script_component.hpp"

if (isServer) then {
    // Reset owner variable if a player disconnects while remote controlling a unit
    addMissionEventHandler ["HandleDisconnect", {
        params ["_unit"];

        if (!isNull getAssignedCuratorLogic _unit) then {
            {
                if (_x getVariable [VAR_OWNER, objNull] == _unit) exitWith {
                    _x setVariable [VAR_OWNER, nil, true];
                };
            } forEach allUnits;
        };
    }];
};

["zen_curatorDisplayLoaded", {
    params ["_display"];

    {
        private _ctrl = _display displayCtrl _x;
        _ctrl ctrlAddEventHandler ["MouseButtonDblClick", {call FUNC(handleMouseDblClick)}];
    } forEach [
        IDC_RSCDISPLAYCURATOR_MOUSEAREA,
        IDC_RSCDISPLAYCURATOR_MAINMAP
    ];
}] call CBA_fnc_addEventHandler;
