/*
 * Author: mharis001
 * Allows Zeus to specify the position and direction before spawning a large object.
 * Will overwrite currently active spawnLargeObject.
 *
 * Arguments:
 * 0: Helper object <OBJECT>
 * 1: Code to run on confirmation <CODE>
 * 2: Length <NUMBER>
 * 3: Width <NUMBER>
 * 4: Color <ARRAY> (default: [1, 0, 1, 1])
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC, {systemChat "big object!"}, 100, 50] call zen_common_fnc_spawnLargeObject
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_helper", "_code", "_length", "_width", ["_color", [1, 0, 1, 1]]];

if (!isNil QGVAR(spawnLargeObjectParams)) exitWith {
    TRACE_1("spawnLargeObject overwriting",GVAR(spawnLargeObjectHandle));

    // Delete helper to trigger PFH cleanup
    GVAR(spawnLargeObjectParams) params ["_helper"];
    deleteVehicle _helper;

    // Call next frame to allow for removal
    [FUNC(spawnLargeObject), _this] call CBA_fnc_execNextFrame;
};

TRACE_1("spawnLargeObject starting",GVAR(spawnLargeObjectHandle));

GVAR(spawnLargeObjectParams) = [_helper, _code];
GVAR(spawnLargeObjectHandle) = (findDisplay IDD_RSCDISPLAYCURATOR) displayAddEventHandler ["KeyDown", {
    params ["", "_key"];

    GVAR(spawnLargeObjectParams) params ["_helper", "_code"];

    switch (_key) do {
        case DIK_RETURN: {
            _helper call _code;
            true
        };
        case DIK_ESCAPE: {
            deleteVehicle _helper;
            true
        };
        default {false};
    };
}];

[{
    params ["_args", "_pfhID"];
    _args params ["_helper", "_code", "_length", "_width", "_color"];

    if (isNull _helper || {isNull findDisplay IDD_RSCDISPLAYCURATOR} || {!isNull findDisplay IDD_INTERRUPT}) exitWith {
        TRACE_3("spawnLargeObject cleanup",isNull _helper,isNull findDisplay IDD_RSCDISPLAYCURATOR,!isNull findDisplay IDD_INTERRUPT);

        (findDisplay IDD_RSCDISPLAYCURATOR) displayRemoveEventHandler ["KeyDown", GVAR(spawnLargeObjectHandle)];
        [_pfhID] call CBA_fnc_removePerFrameHandler;

        if (!isNull _helper) then {
            deleteVehicle _helper;
        };

        GVAR(spawnLargeObjectParams) = nil;
        GVAR(spawnLargeObjectHandle) = nil;
    };

    // Get helper position and direction
    private _position  = _helper modelToWorldVisual [0, 0, 5];
    private _direction = vectorDir _helper;
    _direction set [2, 0];
    _direction = vectorNormalized _direction;

    private _perpendicular = [0, 0, 1] vectorCrossProduct _direction;

    // Draw rectangle around helper object
    private _corner1 = _position vectorAdd (_direction vectorMultiply  _length / 2) vectorAdd (_perpendicular vectorMultiply  _width / 2);
    private _corner2 = _position vectorAdd (_direction vectorMultiply -_length / 2) vectorAdd (_perpendicular vectorMultiply  _width / 2);
    private _corner3 = _position vectorAdd (_direction vectorMultiply -_length / 2) vectorAdd (_perpendicular vectorMultiply -_width / 2);
    private _corner4 = _position vectorAdd (_direction vectorMultiply  _length / 2) vectorAdd (_perpendicular vectorMultiply -_width / 2);

    drawLine3D [_corner1, _corner2, _color];
    drawLine3D [_corner2, _corner3, _color];
    drawLine3D [_corner3, _corner4, _color];
    drawLine3D [_corner4, _corner1, _color];

    // Draw arrow to indicate direction
    private _arrowLength = 0.2 * _length;
    private _arrowWidth  = 0.2 * _width;

    private _arrowEnd1 = _position vectorAdd (_direction vectorMultiply  _arrowLength);
    private _arrowEnd2 = _position vectorAdd (_direction vectorMultiply -_arrowLength);
    private _arrowMiddle = _position vectorAdd (_direction vectorMultiply 0.5 * _arrowLength);

    drawLine3D [_arrowEnd1, _arrowEnd2, _color];
    drawLine3D [_arrowEnd1, _arrowMiddle vectorAdd (_perpendicular vectorMultiply  _arrowWidth), _color];
    drawLine3D [_arrowEnd1, _arrowMiddle vectorAdd (_perpendicular vectorMultiply -_arrowWidth), _color];
}, 0, [_helper, _code, _length, _width, _color]] call CBA_fnc_addPerFrameHandler;
