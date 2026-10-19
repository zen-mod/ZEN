#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles showing and updating the vision modes hint.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_vision_fnc_showHint
 *
 * Public: No
 */

params ["_display"];

// Get avaiable vision modes
private _curator = getAssignedCuratorLogic player;
private _modes = _curator call BIS_fnc_curatorVisionModes;
private _index = _curator getVariable ["BIS_fnc_curatorVisionModes_current", 0];

// Get thermal names and colors
private _namesFLIR = getArray (configFile >> "CfgInGameUI" >> "FLIRModeNames" >> "FLIRModeName");
private _colorsFLIR = getArray (configFile >> "CfgInGameUI" >> "FLIRModeColors" >> "FLIRModeColor");

// Determine x position to center all visible controls
private _modesCount = count _modes;
private _posX = 0.5 - WIDTH_SINGLE * _modesCount / 2;

// No grow effect if only one vision mode available
private _commitTime = [0, 0.2] select (_modesCount > 1);

{
    // Get name and color for vision mode
    private _name = "";
    private _colorText = [0, 0, 0, 0];
    private _colorBackground = [0, 0, 0, 0];

    switch (_x) do {
        case -2: {
            _name = "NVG";
            _colorText = [0, 0, 0, 1];
            _colorBackground = [0, 0.75, 0, 1];
        };
        case -1: {
            _name = "Normal";
            _colorText = [0, 0, 0, 1];
            _colorBackground = [0.75, 0.75, 0.75, 1];
        };
        default {
            _name = _namesFLIR select _x;
            _colorText = _colorsFLIR select _x select 1;
            _colorBackground = _colorsFLIR select _x select 0;
        };
    };

    // Decrease alpha for inactive modes
    if (_forEachIndex != _index) then {
        _colorText set [3, 0.5];
        _colorBackground set [3, 0.5];
    };

    // Update and reposition control
    private _ctrl = _display displayCtrl (IDCS_MODES select _forEachIndex);
    _ctrl ctrlSetText _name;
    _ctrl ctrlSetTextColor _colorText;
    _ctrl ctrlSetBackgroundColor _colorBackground;

    private _ctrlPos = ctrlPosition _ctrl;
    _ctrlPos set [0, _posX + WIDTH_SINGLE * _forEachIndex];
    _ctrl ctrlSetPosition _ctrlPos;
    _ctrl ctrlCommit 0;

    // Add grow effect for active vision mode
    if (_forEachIndex == _index) then {
        _ctrlPos set [3, POS_H(1.2)];
        _ctrl ctrlSetPosition _ctrlPos;
        _ctrl ctrlCommit _commitTime;
    };
} forEach _modes;
