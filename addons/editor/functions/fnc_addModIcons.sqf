#include "script_component.hpp"
/*
 * Author: mharis001
 * Adds mod icons to the create unit trees.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_editor_fnc_addModIcons
 *
 * Public: No
 */

if (!GVAR(addModIcons)) exitWith {};

BEGIN_COUNTER(addModIcons);

params ["_display"];

// Cache to store mod icons by object type
if (isNil QGVAR(modIcons)) then {
    GVAR(modIcons) = createHashMap;
};

private _cfgVehicles = configFile >> "CfgVehicles";

{
    private _ctrlTree = _display displayCtrl _x;

    for "_i" from 0 to (_ctrlTree tvCount []) - 1 do {
        for "_j" from 0 to ((_ctrlTree tvCount [_i]) - 1) do {
            for "_k" from 0 to ((_ctrlTree tvCount [_i, _j]) - 1) do {
                private _path = [_i, _j, _k];
                private _type = _ctrlTree tvData _path;
                private _icon = GVAR(modIcons) get _type;

                if (isNil "_icon") then {
                    private _mod = [_cfgVehicles >> _type] call EFUNC(common,getDLC);

                    // modParams command prints warning in RPT if used with empty mod
                    if (_mod != "") then {
                        _icon = modParams [_mod, ["logoSmall"]] param [0, ""];

                        // Attempt to optimize the mod icon's file path. modParams returns file paths without the
                        // leading backslash however, tvSetPictureRight and other commands that deal with pictures
                        // perform significantly better (from testing, ~20 times faster) when the file path starts
                        // with a backslash. We can't take advantage of this difference when the mod icon is in the
                        // root directory of the mod, instead of a PBO. In this situation, the file path is an
                        // absolute path (i.e. with a drive letter on Windows). From testing, base game and popular
                        // asset mods specify the mod's logo as an image inside of one of its PBOs. This optimization
                        // combined with the icons cache allows us to add mod icons without significantly increasing
                        // load times after the initial load (base game: ~28 ms, with RHS and CUP: ~67 ms) when
                        // the icons are contained inside PBOs. It should be noted that the benefits of this optimization
                        // quickly deteriorate when asset mods that contain the icon in the root directory are loaded.
                        if (_icon != "" && {_icon select [0, 1] != "\"} && {_icon select [1, 1] != ":"}) then {
                            private _sanitizedIcon = "\" + toLower _icon;

                            // Ensure that the icon file exists just in case
                            if (fileExists _sanitizedIcon) then {
                                _icon = _sanitizedIcon;
                            };
                        };
                    } else {
                        _icon = "";
                    };

                    GVAR(modIcons) set [_type, _icon];
                };

                if (_icon != "") then {
                    _ctrlTree tvSetPictureRight [_path, _icon];
                };
            };
        };
    };
} forEach IDCS_UNIT_TREES;

END_COUNTER(addModIcons);
