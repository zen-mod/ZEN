#include "script_component.hpp"

["zen_curatorDisplayLoaded", {
    if (!GVAR(enabled)) exitWith {};

    params ["_display"];

    {
        private _ctrl = _display displayCtrl _x;
        _ctrl ctrlAddEventHandler ["TreeSelChanged", {call FUNC(handleTreeSelect)}];
    } forEach [
        IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EAST,
        IDC_RSCDISPLAYCURATOR_CREATE_UNITS_WEST,
        IDC_RSCDISPLAYCURATOR_CREATE_UNITS_GUER,
        IDC_RSCDISPLAYCURATOR_CREATE_UNITS_CIV,
        IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EMPTY
    ];

    // Need special handling for recent tree since items in the tree are not always objects
    private _ctrlTreeRecent = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_RECENT;
    _ctrlTreeRecent ctrlAddEventHandler ["TreeSelChanged", {
        params ["_ctrlTreeRecent", "_selectedPath"];

        private _objectType = _ctrlTreeRecent tvData _selectedPath;

        if (!isClass (configFile >> "CfgVehicles" >> _objectType) || {_objectType isKindOf "Logic"}) then {
            _objectType = "";
        };

        [_objectType] call FUNC(setupPreview);
    }];
}] call CBA_fnc_addEventHandler;

["zen_curatorDisplayUnloaded", {
    GVAR(updatePFH) call CBA_fnc_removePerFrameHandler;

    deleteVehicle GVAR(object);
    deleteVehicle GVAR(helper);
}] call CBA_fnc_addEventHandler;

[QEGVAR(editor,modeChanged), LINKFUNC(handleTreeChange)] call CBA_fnc_addEventHandler;
[QEGVAR(editor,sideChanged), LINKFUNC(handleTreeChange)] call CBA_fnc_addEventHandler;
