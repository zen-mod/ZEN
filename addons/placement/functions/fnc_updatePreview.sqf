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

// Using mouse position from mouse area control to not update when mouse is over other UI elements
private _mousePos = uiNamespace getVariable ["RscDisplayCurator_mousePos", [0, 0]];

// Get terrain position and normal
private _position = AGLtoASL screenToWorld _mousePos;
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

// Update the helper, which will update the attached preview object
GVAR(helper) setPosASL _position;
GVAR(helper) setVectorUp _vectorUp;

END_COUNTER(updatePreview);
