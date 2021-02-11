#include "script_component.hpp"
/*
 * Author: Ampersand
 * Initializes the "Global Hint" Zeus module display.
 *
 * Arguments:
 * 0: Center <OBJECT, ARRAY>
 * 1: Radius <NUMBER>
 * 2: Step <NUMBER>
 * 3: Icon <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [MODULE, RADIUS, STEP, ICON] call zen_modules_fnc_gui_radiusHint
 *
 * Public: No
 */

 if (call EFUNC(common,isInScreenshotMode)) exitWith {};
 params [
     ["_center", objNull, [objNull, []], [2, 3]],
     "_radius",
     "_step",
     ["_icon", ""]
 ];

 if (_center isEqualType objNull) then {
     _center = getPosASL _center;
 } else {
     if (count _center == 2) then {
         _center pushBack 0;
     };
 };

if (GVAR(gui_radiusHint_draw) > -1) then {
    GVAR(gui_radiusHint_info) = [];
    removeMissionEventHandler ["Draw3D", GVAR(gui_radiusHint_draw)];
    GVAR(gui_radiusHint_draw) = -1;
};

 GVAR(gui_radiusHint_info) = [_center, _radius, _step, _icon];

 GVAR(gui_radiusHint_draw) = addMissionEventHandler ["Draw3D", {
     GVAR(gui_radiusHint_info) params ["_center", "_radius", "_step", "_icon"];

     for "_i" from 1 to (round (_radius / _step) + 1) do {
         private _distance = _i * _step;
         {
             private _pos = _center vectorAdd (_x vectorMultiply _distance);
             drawIcon3D [
                 _icon,
                 [1, 1, 1, 0.5],
                 ASLToAGL _pos,
                 1, 1, 0,
                 str round _distance,
                 2,
                 0.04
             ];
         } forEach [
             [1,0,0],
             [-1,0,0],
             [0,1,0],
             [0,-1,0]
         ];
     };
 }];
