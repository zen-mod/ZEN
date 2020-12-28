#include "script_component.hpp"
/*
 * Author: Ampersand
 * Returns ASL position of curator cursor.
 * If cursor is over an object or building, the surface intersection position is returned.
 * If the curator map is open, the ground level position is returned.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Position ASL <ARRAY>
 *
 * Example:
 * [] call zen_common_fnc_getCursorPosition
 *
 * Public: No
 */

 if (ctrlShown ((findDisplay 312) displayCtrl 50)) then {
     // Curator map
     private _pos2d = (((findDisplay 312) displayCtrl 50) ctrlMapScreenToWorld getMousePosition);
     _pos2d set [2, getTerrainHeightASL _pos2d];
     _pos2d
 } else {
     // Check elevated position
     private _pos3d = AGLToASL (screenToWorld getMousePosition);
     private _position0 = AGLToASL positionCameraToWorld [0, 0, 0];
     private _intersections = lineIntersectsSurfaces [_position0, _pos3d, cameraOn, objNull, true, 1, "GEOM"];

     if !(_intersections isEqualTo []) then {
         (_intersections # 0) params ["_intersectPosASL", "", "_intersectObject", ""];
         if !(isNull _intersectObject) then {
             _pos3d = _intersectPosASL;
         };
     };
     _pos3d
 };
