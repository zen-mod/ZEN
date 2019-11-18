#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles tree mouse update events by updating the editor preview image.
 *
 * Arguments:
 * 0: Tree <CONTROL>
 * 1: Path <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, []] call zen_editor_previews_fnc_handleMouseUpdate
 *
 * Public: No
 */

BEGIN_COUNTER(update);

params ["_ctrlTree", "_path"];

private _display = ctrlParent _ctrlTree;
private _ctrlGroup = _display displayCtrl IDC_PREVIEW_GROUP;

private _type = _ctrlTree tvData _path;

if (_type isEqualTo "") then {
    _ctrlGroup ctrlShow false;
} else {
    private _image = getText (configFile >> "CfgVehicles" >> _type >> "editorPreview");
    if (_image isEqualTo "") exitWith {};

    private _ctrlImage = _display displayCtrl IDC_PREVIEW_IMAGE;
    _ctrlImage ctrlSetText _image;

    _ctrlGroup ctrlShow true;
    _ctrlGroup ctrlSetPositionY (getMousePosition select 1) min (safeZoneY + safeZoneH - POS_H(5.6));
    _ctrlGroup ctrlCommit 0;
};

END_COUNTER(update);
