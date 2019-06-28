#include "script_component.hpp"

GVAR(previewVehicle) = objNull;
GVAR(lastMouse) = getMousePosition;

["ZEN_displayCuratorLoad", {
    params ["_display"];
    GVAR(previewDraw) = addMissionEventHandler ["Draw3D", {
        call FUNC(updatePreview);
    }];
}] call CBA_fnc_addEventHandler;


[{!isNull (getAssignedCuratorLogic player)}, {
    (getAssignedCuratorLogic player) addEventHandler ["CuratorObjectPlaced", {
        params ["_curator", "_object"];
        _object setPosASL [0,0,100];
        _object setDir (getDir GVAR(previewVehicle));
        private _pos = AGLtoASL screenToWorld getMousePosition;
        _object setVectorUp surfaceNormal _pos;
        private _intersections = lineIntersectsSurfaces [getPosASL curatorCamera, _pos, GVAR(previewVehicle)];
        if (count _intersections != 0) then {
            private _placePos = ((_intersections select 0) select 0);
            _object setPosASL [_placePos select 0, _placePos select 1, (_placePos select 2) + 1];
        } else {
            _object setPosASL [_pos select 0, _pos select 1, (_pos select 2) + 1];
        };
    }];
}] call CBA_fnc_waitUntilAndExecute;
