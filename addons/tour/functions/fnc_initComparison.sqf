#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes a comparison from the given config, with its before and after pictures.
 * Starts with the "before" picture covering the group, until it is scrolled into view.
 *
 * Arguments:
 * 0: Comparison <CONTROL>
 * 1: Config <CONFIG>
 *
 * Return Value:
 * Animated <BOOL>
 *
 * Example:
 * [CONTROL, _config] call zen_tour_fnc_initComparison
 *
 * Public: No
 */

params ["_ctrlComparison", "_config"];

ctrlPosition _ctrlComparison params ["", "", "_comparisonW", "_comparisonH"];

private _ctrlClip = _ctrlComparison controlsGroupCtrl IDC_COMPARISON_CLIP;
private _labelX = POS_W(COMPARISON_LABEL_MARGIN);
private _labelY = POS_H(COMPARISON_LABEL_MARGIN / 2);
private _labelPosition = [_labelX, _labelY, _comparisonW - 2 * _labelX, POS_H(1.2)];

// The "before" picture and label are in a group that clips them at the divider
getArray (_config >> "comparison") params ["_before", "_after"];

{
    _x params ["_ctrlParent", "_idcPicture", "_idcLabel", "_picture"];

    private _ctrlPicture = _ctrlParent controlsGroupCtrl _idcPicture;
    _ctrlPicture ctrlSetText _picture;
    _ctrlPicture ctrlSetPosition [0, 0, _comparisonW, _comparisonH];
    _ctrlPicture ctrlCommit 0;

    private _ctrlLabel = _ctrlParent controlsGroupCtrl _idcLabel;
    _ctrlLabel ctrlSetPosition _labelPosition;
    _ctrlLabel ctrlCommit 0;
} forEach [
    [_ctrlClip, IDC_COMPARISON_BEFORE, IDC_COMPARISON_LABEL_BEFORE, _before],
    [_ctrlComparison, IDC_COMPARISON_AFTER, IDC_COMPARISON_LABEL_AFTER, _after]
];

private _ctrlMouse = _ctrlComparison controlsGroupCtrl IDC_COMPARISON_MOUSE;
_ctrlMouse ctrlSetPosition [0, 0, _comparisonW, _comparisonH];
_ctrlMouse ctrlCommit 0;

_ctrlComparison setVariable [QGVAR(type), "comparison"];
_ctrlComparison setVariable [QGVAR(state), MEDIA_STATE_HIDDEN];
[_ctrlComparison, 1] call FUNC(setComparisonSplit);

true
