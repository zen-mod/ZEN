#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles updating the visuals and positions of the door buttons.
 *
 * Arguments:
 * 0: Arguments <ARRAY>
 *   0: Building <OBJECT>
 *   1: Door Positions <ARRAY>
 *   2: Controls <ARRAY>
 * 1: PFH Handle <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[building, doorPositions, controls], 1] call zen_doors_fnc_updatePFH
 *
 * Public: No
 */

params ["_args", "_pfhID"];
_args params ["_building", "_doors", "_controls"];

// Remove PFH if Zeus display no longer open
if (isNull findDisplay IDD_RSCDISPLAYCURATOR) exitWith {
    [_pfhID] call CBA_fnc_removePerFrameHandler;
};

// Remove PFH and delete controls if too far from building
if (curatorCamera distance _building > DISTANCE_CANCEL) exitWith {
    [_pfhID] call CBA_fnc_removePerFrameHandler;
    {ctrlDelete _x} forEach _controls;
};

// Update the door button controls
{
    private _control = _controls select _forEachIndex;

    private _position  = _building modelToWorldVisual _x;
    private _distance  = curatorCamera distance _position;
    private _screenPos = worldToScreen _position;

    // Hide control if the door position is offscreen or outside of draw distance
    if (_screenPos isEqualTo [] || {_distance > DISTANCE_DRAW}) then {
        _control ctrlShow false;
    } else {
        _control ctrlShow true;

        private _state = [_building, _forEachIndex + 1] call FUNC(getState);
        private _icon  = [ICON3D_CLOSED, ICON3D_LOCKED, ICON3D_OPENED] select _state;
        private _color = [COLOR_CLOSED, COLOR_LOCKED, COLOR_OPENED] select _state;

        _control ctrlSetText _icon;
        _control ctrlSetActiveColor _color;

        _color set [3, 0.8];
        _control ctrlSetTextColor _color;

        _screenPos params ["_posX", "_posY"];

        private _size = linearConversion [0, DISTANCE_DRAW, _distance, ICON_SIZE_MAX, ICON_SIZE_MIN, true];
        private _posW = POS_W(_size);
        private _posH = POS_H(_size);

        _control ctrlSetPosition [_posX - _posW / 2, _posY - _posH / 2, _posW, _posH];
        _control ctrlCommit 0;
    };
} forEach _doors;
