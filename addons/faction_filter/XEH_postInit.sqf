#include "script_component.hpp"

["CBA_SettingChanged", {
    params ["_name"];

    // Schedule the Zeus display to be reloaded when a faction filter setting is changed
    // Allows for changing faction filter settings mid-mission while the interface is forced
    if (QUOTE(ADDON) in _name && {!isNull findDisplay IDD_RSCDISPLAYCURATOR} && {isNil QGVAR(displayReload)}) then {
        GVAR(displayReload) = true;

        {
            (findDisplay IDD_RSCDISPLAYCURATOR) closeDisplay IDC_CANCEL;

            [{
                isNull findDisplay IDD_RSCDISPLAYCURATOR
            }, {
                openCuratorInterface;
                GVAR(displayReload) = nil;
            }] call CBA_fnc_waitUntilAndExecute;
        } call CBA_fnc_execNextFrame;
    };
}] call CBA_fnc_addEventHandler;

[QEGVAR(editor,treesLoaded), {
    BEGIN_COUNTER(processTrees);

    params ["_display"];

    private _fnc_processTrees = {
        params ["_treeIDCs", "_basePath"];

        {
            private _ctrlTree = _display displayCtrl _x;

            for "_i" from (_ctrlTree tvCount _basePath) - 1 to 0 step -1 do {
                private _path = _basePath + [_i];
                private _name = _ctrlTree tvText _path;

                // Get the setting variable name that corresponds to this faction's name and side
                private _varName = GVAR(map) getOrDefault [[_forEachIndex, _name], ""];

                if !(missionNamespace getVariable [_varName, true]) then {
                    _ctrlTree tvDelete _path;
                };
            };
        } forEach _treeIDCs;
    };

    [[
        IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EAST,
        IDC_RSCDISPLAYCURATOR_CREATE_UNITS_WEST,
        IDC_RSCDISPLAYCURATOR_CREATE_UNITS_GUER,
        IDC_RSCDISPLAYCURATOR_CREATE_UNITS_CIV
    ], []] call _fnc_processTrees;

    [[
        IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_EAST,
        IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_WEST,
        IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_GUER,
        IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_CIV
    ], [0]] call _fnc_processTrees;

    END_COUNTER(processTrees);
}] call CBA_fnc_addEventHandler;
