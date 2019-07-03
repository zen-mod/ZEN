#include "script_component.hpp"

private _pos = AGLtoASL screenToWorld getMousePosition;
private _class = call FUNC(getSelectedClass);

#define OFFSET 10

if (_class isEqualTo "") exitWith {
    if !(GVAR(previewVehicle) isEqualTo objNull) then {
        deleteVehicle GVAR(previewVehicle);
        deleteVehicle GVAR(previewObject);
        GVAR(previewVehicle) = objNull;
    };
};

// Delete the old preview if the player selects a different item
if !(_class isEqualTo (typeOf GVAR(previewVehicle))) then {
    deleteVehicle GVAR(previewVehicle);
    deleteVehicle GVAR(previewObject);
    GVAR(previewVehicle) = objNull;
};

// Create the preview if it doesn't exist
if (isNull GVAR(previewVehicle)) then {
    GVAR(previewObject) = "Land_Wrench_F" createVehicleLocal (ASLtoAGL _pos);
    GVAR(previewObject) hideObject true;
    GVAR(previewVehicle) = _class createVehicleLocal [0, 0, 0];
    GVAR(previewVehicle) attachTo [GVAR(previewObject), [0, 0, OFFSET + 1 + ((boundingCenter GVAR(previewVehicle)) select 2)]];
    GVAR(previewVehicle) enableSimulationGlobal false;
    GVAR(previewVehicle) disableCollisionWith player;
    GVAR(previewVehicle) allowDamage false;
};

if (inputAction "CuratorRotateMod" > 0) exitWith {
    private _new = getMousePosition select 0;
    private _old = GVAR(originMouse) select 0;
    GVAR(previewVehicle) setDir ((getDir GVAR(previewVehicle)) - ((_new - _old) * 9));
    if (abs (_new - _old) > 0.25) then {
        setMousePosition GVAR(lastMouse);
    } else {
        GVAR(lastMouse) = getMousePosition;
    };
};

private _intersections = lineIntersectsSurfaces [getPosASL curatorCamera, _pos, GVAR(previewVehicle)];

// Display the preview in the location it will be placed
if (count _intersections != 0) then {
    private _placePos = ((_intersections select 0) select 0);
    GVAR(previewObject) setPosASL [_placePos select 0, _placePos select 1, (_placePos select 2) - OFFSET];
} else {
    GVAR(previewObject) setPosASL [_pos select 0, _pos select 1, (_pos select 2) - OFFSET];
};

// Orient to terrain
GVAR(previewObject) setVectorUp [0,0,0];
GVAR(previewVehicle) setVectorUp surfaceNormal position GVAR(previewVehicle);

GVAR(originMouse) = getMousePosition;
