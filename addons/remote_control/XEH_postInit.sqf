#include "script_component.hpp"

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
