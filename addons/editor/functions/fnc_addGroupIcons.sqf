#include "script_component.hpp"
/*
 * Author: mharis001
 * Adds group icons to the create group trees.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_editor_fnc_addGroupIcons
 *
 * Public: No
 */

if (!GVAR(addGroupIcons)) exitWith {};

params ["_display"];

private _config = configFile >> "CfgGroups";

// Iterate through every tree path and use the tree item data
// to find the corresponding config for each group
{
    private _ctrlTree = _display displayCtrl _x;
    private _color = [_forEachIndex] call BIS_fnc_sideColor;

    for "_i" from 0 to ((_ctrlTree tvCount []) - 1) do {
        private _config = _config >> (_ctrlTree tvData [_i]);

        for "_j" from 0 to ((_ctrlTree tvCount [_i]) - 1) do {
            private _config = _config >> (_ctrlTree tvData [_i, _j]);

            for "_k" from 0 to ((_ctrlTree tvCount [_i, _j]) - 1) do {
                private _config = _config >> (_ctrlTree tvData [_i, _j, _k]);

                for "_l" from 0 to ((_ctrlTree tvCount [_i, _j, _k]) - 1) do {
                    private _path = [_i, _j, _k, _l];
                    private _icon = getText (_config >> (_ctrlTree tvData _path) >> "icon");

                    _ctrlTree tvSetPicture [_path, _icon];
                    _ctrlTree tvSetPictureColor [_path, _color];
                    _ctrlTree tvSetPictureColorSelected [_path, _color];
                };
            };
        };
    };
} forEach [
    IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_EAST,
    IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_WEST,
    IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_GUER,
    IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_CIV
];
