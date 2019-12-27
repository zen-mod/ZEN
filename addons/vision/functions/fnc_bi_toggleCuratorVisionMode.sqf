#include "script_component.hpp"
/*
 * Author: Bohemia Interactive, mharis001
 * Toggles between avaiable curator vision modes.
 *
 * Arguments:
 * 0: Curator <OBJECT>
 * 1: Change <NUMBER> (default: 1)
 *
 * Return Value:
 * Current mode <NUMBER>
 *
 * Example:
 * [LOGIC, 1] call BIS_fnc_toggleCuratorVisionMode
 *
 * Public: No
 */

params [["_curator", objNull, [objNull]], ["_change", 1, [0]]];

private _modes = _curator call BIS_fnc_curatorVisionModes;
private _modesCount = count _modes;

private _index = _curator getVariable ["BIS_fnc_curatorVisionModes_current", 0];
_index = (_index + _change) % _modesCount;

if (_index < 0) then {
    _index = _index + _modesCount;
};

_mode = _modes select _index;
_curator setVariable ["BIS_fnc_curatorVisionModes_current", _index];

if (!isNull curatorCamera) then {
    switch (_mode) do {
        case -2: { // NVG
            camUseNVG true;
            false setCamUseTI 0;
        };
        case -1: { // Normal
            camUseNVG false;
            false setCamUseTI 0;
        };
        default { // TI
            camUseNVG false;
            true setCamUseTI _mode;
        };
    };

    // Update NVG brightness effect for new vision mode
    [] call FUNC(updateEffect);

    (QGVAR(layer) call BIS_fnc_rscLayer) cutRsc [QGVAR(RscVisionModes), "PLAIN"];
    playSound ["RscDisplayCurator_visionMode", true];
};

_mode
