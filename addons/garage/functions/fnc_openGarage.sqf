/*
 * Author: mharis001
 * Opens the garage for given vehicle.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [car] call zen_garage_fnc_openGarage
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_vehicle"];

// Only open garage for curator
if (isNull ZEUS_DISPLAY) exitWith {};

// Store current vehicle
GVAR(center) = _vehicle;

// Create the garage display
ZEUS_DISPLAY createDisplay QGVAR(display);

// Init tracking variables
GVAR(mouseButtons) = [[], []];
GVAR(interfaceShown) = true;
GVAR(visionMode) = 0;

// Init display elements
[] call FUNC(showVehicleInfo);
[] call FUNC(populateLists);

// Create the camera
GVAR(camHelper) = "Logic" createVehicleLocal [0, 0, 0];
GVAR(camHelper) attachTo [_vehicle, GVAR(helperPos)];

GVAR(camera) = "camera" camCreate ASLtoAGL getPosASL _vehicle;
GVAR(camera) cameraEffect ["internal", "back"];
GVAR(camera) camPrepareFocus [-1, -1];
GVAR(camera) camPrepareFov 0.35;
GVAR(camera) camCommitPrepared 0;

showCinemaBorder false;

// Reset camera zoom
[nil, 0] call FUNC(onMouseZChanged);

// Add camera update handler
GVAR(camDraw3D) = addMissionEventHandler ["Draw3D", {call FUNC(updateCamera)}];
