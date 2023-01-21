#include "script_component.hpp"
/*
 * Author: Brett, mharis001
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

// Get terrain position and normal
private _position = AGLtoASL screenToWorld EGVAR(editor,mousePos);
private _vectorUp = surfaceNormal _position;

// Rotation mode
if (inputAction "curatorRotateMod" > 0) exitWith {
    GVAR(helper) setDir (GVAR(helper) getDir _position);

    END_COUNTER(updatePreview);
};

// Check if a surface other than the terrain exists
{
    _x params ["_intersectPos", "_surfaceNormal"];

    // Use the intersection position and normal if the surface is relatively flat
    if (_surfaceNormal vectorDotProduct [0, 0, 1] > 0.5) exitWith {
        _position = _intersectPos;
        _vectorUp = _surfaceNormal;
    };
} forEach lineIntersectsSurfaces [getPosASL curatorCamera, _position, GVAR(helper), GVAR(object), true, 5];

// Update the helper, which will update the attached preview object
GVAR(helper) setPosASL _position;
GVAR(helper) setVectorUp _vectorUp;

END_COUNTER(updatePreview);
