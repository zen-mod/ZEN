#include "script_component.hpp"
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
 * [_vehicle] call zen_garage_fnc_openGarage
 *
 * Public: No
 */

params ["_vehicle"];

// Only open garage for curator
if (isNull ZEUS_DISPLAY) exitWith {};

// Store current vehicle
GVAR(center) = _vehicle;

// Create the garage display
ZEUS_DISPLAY createDisplay QGVAR(display);

// Store curator camera data to restore it on exit
GVAR(curatorCameraData) = [getPosASL curatorCamera, [vectorDir curatorCamera, vectorUp curatorCamera]];

// Init tracking variables
GVAR(mouseButtons) = [[], []];
GVAR(interfaceShown) = true;
GVAR(visionMode) = 0;

// Init display elements
[] call FUNC(showVehicleInfo);
[] call FUNC(populateLists);

// Open garage with previously selected tab
[GVAR(currentTab), true] call FUNC(onTabSelect);

// Disable "Apply To All" button if there are no other vehicles
private _vehicleType = typeOf _vehicle;

if (SELECTED_OBJECTS findIf {_x != _vehicle && {typeOf _x == _vehicleType}} == -1) then {
    private _ctrlButtonApply = findDisplay IDD_DISPLAY displayCtrl IDC_BUTTON_APPLY;
    _ctrlButtonApply ctrlSetTooltip localize LSTRING(CannotApplyToAll);
    _ctrlButtonApply ctrlEnable false;
};

// Create the camera
GVAR(camHelper) = "Logic" createVehicleLocal [0, 0, 0];
GVAR(camHelper) attachTo [_vehicle, GVAR(helperPos)];

GVAR(camera) = "camera" camCreate ASLToAGL getPosASL _vehicle;
GVAR(camera) cameraEffect ["internal", "back"];
GVAR(camera) camPrepareFocus [-1, -1];
GVAR(camera) camPrepareFov 0.35;
GVAR(camera) camCommitPrepared 0;

showCinemaBorder false;

// Reset camera zoom
[nil, 0] call FUNC(onMouseZChanged);

// Add camera update handler
GVAR(camDraw3D) = addMissionEventHandler ["Draw3D", {call FUNC(updateCamera)}];
