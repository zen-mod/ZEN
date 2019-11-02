#include "script_component.hpp"

if (isServer) then {
    [QGVAR(create), {
        params ["_position"];

        private _marker = createMarker [format [QGVAR(%1), GVAR(nextID)], _position];
        _marker setMarkerShape "RECTANGLE";
        _marker setMarkerSize [50, 50];

        GVAR(markers) pushBack _marker;
        publicVariable QGVAR(markers);

        GVAR(nextID) = GVAR(nextID) + 1;

        [QGVAR(createIcon), _marker] call CBA_fnc_globalEvent;
    }] call CBA_fnc_addEventHandler;

    [QGVAR(delete), {
        params ["_marker"];

        private _index = GVAR(markers) find _marker;

        if (_index != -1) then {
            GVAR(markers) deleteAt _index;
            publicVariable QGVAR(markers);

            deleteMarker _marker;

            [QGVAR(deleteIcon), _marker] call CBA_fnc_globalEvent;
        };
    }] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
    ["ZEN_displayCuratorLoad", {
        params ["_display"];

        // Namespace of marker names and their corresponding icon controls
        if (isNil QGVAR(icons)) then {
            GVAR(icons) = [] call CBA_fnc_createNamespace;
        };

        // Add EH to update area marker icon positions when the map is shown
        private _ctrlMap = _display displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;
        _ctrlMap ctrlAddEventHandler ["Draw", {call FUNC(onDraw)}];

        // Add EH to handle deleting area marker by pressing the DELETE key
        _display displayAddEventHandler ["KeyDown", {call FUNC(onKeyDown)}];

        // Create area marker icons for all area markers
        {
            {
                [_x] call FUNC(createIcon);
            } forEach GVAR(markers);
        } call CBA_fnc_execNextFrame;

        // Add PFH to update visibility of area marker icons
        GVAR(visiblePFH) = [{
            params ["_args"];
            _args params ["_visible"];

            if (_visible isEqualTo visibleMap) exitWith {};

            _visible = visibleMap;
            {
                private _ctrlIcon = GVAR(icons) getVariable [_x, controlNull];
                _ctrlIcon ctrlShow _visible;
            } forEach GVAR(markers);

            _args set [0, _visible];
        }, 0, [visibleMap]] call CBA_fnc_addPerFrameHandler;
    }] call CBA_fnc_addEventHandler;

    ["ZEN_displayCuratorUnload", {
        GVAR(visiblePFH) call CBA_fnc_removePerFrameHandler;
    }] call CBA_fnc_addEventHandler;

    [QGVAR(createIcon), LINKFUNC(createIcon)] call CBA_fnc_addEventHandler;
    [QGVAR(deleteIcon), LINKFUNC(deleteIcon)] call CBA_fnc_addEventHandler;
    [QGVAR(updateIcon), LINKFUNC(updateIcon)] call CBA_fnc_addEventHandler;
};
