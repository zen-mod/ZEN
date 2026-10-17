#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles the mouse wheel being scrolled over a comment's icon.
 *
 * Arguments:
 * 0: Mouse Control <CONTROL>
 * 1: Scroll <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 1.2] call zen_comments_fnc_handleMouseZChanged
 *
 * Public: No
 */

// Measured from the engine's own wheel zoom
// A wheel tick scrolls by 1.2 and scales the map by exp -0.12
#define ZOOM_SPEED 0.1

if (!visibleMap) exitWith {};

params ["_ctrlMouse", "_scroll"];

// Zoom the map like the engine does when scrolling over it
// The mouse control prevents the scroll from reaching the map
private _display = ctrlParent _ctrlMouse;
private _ctrlMap = _display displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;
private _oldScale = ctrlMapScale _ctrlMap;
private _newScale = _oldScale * exp (-ZOOM_SPEED * _scroll);

// The engine limits the scale, but the map would move away from the mouse at the limits
// if the position were calculated for a scale beyond them
private _configMap = configFile >> "RscDisplayCurator" >> "ControlsBackground" >> "Map";
private _scaleMin = getNumber (_configMap >> "scaleMin");
private _scaleMax = getNumber (_configMap >> "scaleMax");
_newScale = _scaleMin max _newScale min _scaleMax;

// The world position under the mouse stays the same
ctrlPosition _ctrlMap params ["_mapX", "_mapY", "_mapW", "_mapH"];
private _cursorPos = _ctrlMap ctrlMapScreenToWorld getMousePosition;
private _centerPos = _ctrlMap ctrlMapScreenToWorld [_mapX + _mapW / 2, _mapY + _mapH / 2];
private _offset = (_centerPos vectorDiff _cursorPos) vectorMultiply (_newScale / _oldScale);

_ctrlMap ctrlMapAnimAdd [0, _newScale, _cursorPos vectorAdd _offset];
ctrlMapAnimCommit _ctrlMap;
