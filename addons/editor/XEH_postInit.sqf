#include "script_component.hpp"

[QEGVAR(common,moduleSetup), {
    params ["_module"];
    _module addEventHandler ["CuratorObjectPlaced", {call FUNC(handleObjectPlaced)}];
}] call CBA_fnc_addEventHandler;

[QEGVAR(common,displayCuratorLoad), {
    params ["_display"];

    if (GVAR(removeWatermark)) then {
        private _ctrlWatermark = _display displayCtrl IDC_RSCDISPLAYCURATOR_WATERMARK;
        _ctrlWatermark ctrlSetText "";
    };

    if (GVAR(disableLiveSearch)) then {
        private _ctrlGroupAdd = _display displayCtrl IDC_RSCDISPLAYCURATOR_ADD;

        private _ctrlSearchEngine = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_SEARCH;
        private _searchBarPos = ctrlPosition _ctrlSearchEngine;
        _ctrlSearchEngine ctrlEnable false;
        _ctrlSearchEngine ctrlShow false;

        private _ctrlSearchCustom = _display ctrlCreate ["RscEdit", IDC_SEARCH_CUSTOM, _ctrlGroupAdd];
        _ctrlSearchCustom ctrlSetPosition _searchBarPos;
        _ctrlSearchCustom ctrlCommit 0;

        _ctrlSearchCustom ctrlAddEventHandler ["MouseButtonClick", {call FUNC(handleSearchClick)}];
        _ctrlSearchCustom ctrlAddEventHandler ["KeyDown", {call FUNC(handleSearchKeyDown)}];
        _ctrlSearchCustom ctrlAddEventHandler ["SetFocus", {RscDisplayCurator_search = true}];
        _ctrlSearchCustom ctrlAddEventHandler ["KillFocus", {RscDisplayCurator_search = false}];

        private _ctrlSearchButton = _display displayCtrl IDC_SEARCH_BUTTON;
        _ctrlSearchButton ctrlAddEventHandler ["ButtonClick", {call FUNC(handleSearchButton)}];
    };
}] call CBA_fnc_addEventHandler;
