#include "script_component.hpp"
/*
 * Author: Brett, mharis001, Ampersand
 * Updates the placement preview based on the current mouse position.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_placement_fnc_updatePreview
 *
 * Public: No
 */

BEGIN_COUNTER(updatePreview);

// Update the helper, which will update the attached preview object
// Rotate the object when the rotation modifier is held down
if (inputAction "curatorRotateMod" > 0) then {
    private _screenPos = worldToScreen ASLToAGL getPosASL GVAR(helper);

    // If the object is onscreen, then calculate the direction based on its screen position
    // Otherwise, fall back to using the mouse's world positon, which can behave weirdly at certain
    // camera angles but should not be the case with the object offscreen
    private _direction = if (_screenPos isNotEqualTo []) then {
        private _vector = _screenPos vectorDiff EGVAR(editor,mousePos);
        _vector params ["_vectorX", "_vectorY"];

        // Translate to north as 0 degrees and account for camera view direction
        _vectorY atan2 _vectorX - 90 + getDir curatorCamera
    } else {
        GVAR(helper) getDir screenToWorld EGVAR(editor,mousePos)
    };

    GVAR(helper) setDir _direction;
} else {
    // Get terrain position and normal
    private _position = AGLToASL screenToWorld EGVAR(editor,mousePos);
    private _vectorUp = surfaceNormal _position;

    // Check if a surface other than the terrain exists
    {
        _x params ["_intersectPos", "_surfaceNormal"];

        // Use the intersection position and normal if the surface is relatively flat
        if (_surfaceNormal vectorDotProduct [0, 0, 1] > 0.5) exitWith {
            _position = _intersectPos;
            _vectorUp = _surfaceNormal;
        };
    } forEach lineIntersectsSurfaces [getPosASL curatorCamera, _position, GVAR(helper), GVAR(object), true, 5];

    GVAR(helper) setPosASL _position;
    GVAR(helper) setVectorUp _vectorUp;
};

END_COUNTER(updatePreview);
