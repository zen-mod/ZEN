#include "script_component.hpp"
/*
 * Author: mharis001
 * Queues rendering of presets that may be affected by changes
 * to the given objects or groups.
 *
 * Arguments:
 * 0: Object(s) <OBJECT|ARRAY>
 * 1: Group(s) <GROUP|ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_objects, _groups] call zen_selection_presets_fnc_queueAffectedPresets
 *
 * Public: No
 */

private _display = findDisplay IDD_RSCDISPLAYCURATOR;
private _ctrlPresets = _display displayCtrl IDC_PRESETS;
if (isNull _ctrlPresets) exitWith {};

params ["_objects", "_groups"];

if (_objects isEqualType objNull) then {
    _objects = [_objects];
};

if (_groups isEqualType grpNull) then {
    _groups = [_groups];
};

// Multiple events affecting presets could trigger in the same frame
// Therefore, we don't need to check presets that are already queued
private _renderQueue = _ctrlPresets getVariable [QGVAR(renderQueue), []];
private _candidatePresetKeys = PRESET_KEYS - _renderQueue;
private _checkGroups = GVAR(useGroupIcons) != USE_GROUP_ICONS_NO;

{
    private _preset = [_x] call FUNC(get);
    private _presetAffected = (
        _objects arrayIntersect _preset isNotEqualTo []
        || {
            _checkGroups
            && {_preset apply {group _x} arrayIntersect _groups isNotEqualTo []}
        }
    );

    if (_presetAffected) then {
        _renderQueue pushBack _x;
    };
} forEach _candidatePresetKeys;
