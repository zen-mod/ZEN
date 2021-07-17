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

    if (_image isEqualTo "") exitWith {
        _ctrlGroup ctrlShow false;
    };

    getTextureInfo _image params ["_width", "_height"];
    private _ratio = _width / _height;

    private _ctrlImage = _display displayCtrl IDC_PREVIEW_IMAGE;
    _ctrlImage ctrlSetPositionW POS_W(IMAGE_HEIGHT * _ratio);
    _ctrlImage ctrlSetText _image;
    _ctrlImage ctrlCommit 0;

    _ctrlGroup ctrlShow true;
    _ctrlGroup ctrlSetPositionX (safeZoneX + safeZoneW - POS_W(POS_EDGE(12.5,11) + IMAGE_HEIGHT * _ratio + 3 * BORDER_SIZE));
    _ctrlGroup ctrlSetPositionY (getMousePosition select 1) min (safeZoneY + safeZoneH - POS_H(IMAGE_HEIGHT + 3 * BORDER_SIZE));
    _ctrlGroup ctrlSetPositionW POS_W(IMAGE_HEIGHT * _ratio + 2 * BORDER_SIZE);
    _ctrlGroup ctrlCommit 0;
};

END_COUNTER(update);
