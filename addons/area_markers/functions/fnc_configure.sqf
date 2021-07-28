#include "script_component.hpp"
/*
 * Author: mharis001
 * Opens a menu to configure the properties of the given area marker.
 *
 * Arguments:
 * 0: Marker <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["marker_0"] call zen_area_markers_fnc_configure
 *
 * Public: No
 */

params ["_marker"];

private _display = findDisplay IDD_RSCDISPLAYCURATOR;

private _ctrlConfigure = _display ctrlCreate [QGVAR(configure), IDC_CONFIGURE_GROUP];
ctrlSetFocus _ctrlConfigure;

markerSize _marker params ["_sizeA", "_sizeB"];

{
    _x params ["_idc", "_value"];

    private _ctrl = _ctrlConfigure controlsGroupCtrl _idc;
    _ctrl ctrlSetText str _value;
} forEach [
    [IDC_CONFIGURE_SIZE_A, _sizeA],
    [IDC_CONFIGURE_SIZE_B, _sizeB]
];

private _ctrlRotationSlider = _ctrlConfigure controlsGroupCtrl IDC_CONFIGURE_ROTATION_SLIDER;
private _ctrlRotationEdit   = _ctrlConfigure controlsGroupCtrl IDC_CONFIGURE_ROTATION_EDIT;
[_ctrlRotationSlider, _ctrlRotationEdit, 0, 360, markerDir _marker, 15, EFUNC(common,formatDegrees)] call EFUNC(common,initSliderEdit);

private _ctrlShape = _ctrlConfigure controlsGroupCtrl IDC_CONFIGURE_SHAPE;
_ctrlShape lbSetCurSel (["RECTANGLE", "ELLIPSE"] find markerShape _marker);

private _ctrlBrush = _ctrlConfigure controlsGroupCtrl IDC_CONFIGURE_BRUSH;
private _markerBrush = markerBrush _marker;

{
    private _class = configName _x;
    private _name  = getText (_x >> "name");
    private _icon  = getText (_x >> "texture");

    private _index = _ctrlBrush lbAdd _name;
    _ctrlBrush lbSetData [_index, _class];
    _ctrlBrush lbSetPicture [_index, _icon];

    if (_class == _markerBrush) then {
        _ctrlBrush lbSetCurSel _index;
    };
} forEach configProperties [configFile >> "CfgMarkerBrushes", "isClass _x"];

private _ctrlColor = _ctrlConfigure controlsGroupCtrl IDC_CONFIGURE_COLOR;
private _markerColor = markerColor _marker;

{
    if (getNumber (_x >> "scope") > 0) then {
        private _class = configName _x;
        private _name  = getText (_x >> "name");
        private _color = (_x >> "color") call BIS_fnc_colorConfigToRGBA;

        private _index = _ctrlColor lbAdd _name;
        _ctrlColor lbSetData [_index, _class];
        _ctrlColor lbSetPicture [_index, "#(argb,8,8,3)color(1,1,1,1)"];
        _ctrlColor lbSetPictureColor [_index, _color];
        _ctrlColor lbSetPictureColorSelected [_index, _color];

        if (_class == _markerColor) then {
            _ctrlColor lbSetCurSel _index;
        };
    };
} forEach configProperties [configFile >> "CfgMarkerColors", "isClass _x"];

private _ctrlAlphaSlider = _ctrlConfigure controlsGroupCtrl IDC_CONFIGURE_ALPHA_SLIDER;
private _ctrlAlphaEdit   = _ctrlConfigure controlsGroupCtrl IDC_CONFIGURE_ALPHA_EDIT;
[_ctrlAlphaSlider, _ctrlAlphaEdit, 0, 1, markerAlpha _marker, 0.1, 0, true] call EFUNC(common,initSliderEdit);

private _ctrlButtonCancel = _ctrlConfigure controlsGroupCtrl IDC_CONFIGURE_CANCEL;
_ctrlButtonCancel ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlButtonCancel"];

    private _display = ctrlParent _ctrlButtonCancel;
    private _ctrlConfigure = _display displayCtrl IDC_CONFIGURE_GROUP;

    private _keyDownEH = _ctrlConfigure getVariable [QGVAR(keyDownEH), -1];
    _display displayRemoveEventHandler ["KeyDown", _keyDownEH];

    ctrlDelete _ctrlConfigure;
}];

private _ctrlButtonOK = _ctrlConfigure controlsGroupCtrl IDC_CONFIGURE_OK;
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    private _ctrlConfigure = _display displayCtrl IDC_CONFIGURE_GROUP;

    private _keyDownEH = _ctrlConfigure getVariable [QGVAR(keyDownEH), -1];
    _display displayRemoveEventHandler ["KeyDown", _keyDownEH];

    [_ctrlConfigure] call FUNC(applyProperties);

    ctrlDelete _ctrlConfigure;
}];

// Special handling for keyboard input when edit boxes have focus
// Needed to prevent interaction with Zeus display but still allow keyboard use with edit boxes
private _keyDownEH = _display displayAddEventHandler ["KeyDown", {
    call {
        params ["_display", "_keyCode", "", "_ctrl"];

        if (_keyCode in [DIK_UP, DIK_DOWN, DIK_LEFT, DIK_RIGHT]) exitWith {false};

        if (_keyCode in [DIK_BACKSPACE, DIK_DELETE]) then {
            private _ctrlEdit = focusedCtrl _display;

            if (ctrlIDC _ctrlEdit in IDCS_CONFIGURE_EDIT_BOXES) then {
                ctrlTextSelection _ctrlEdit params ["_start", "_length"];

                // Update length based on key to delete individual characters without selecting them
                if (_length == 0) then {
                    _length = [1, -1] select (_keyCode == DIK_BACKSPACE);
                };

                // Get the selection start position from the left-hand side when the selection is made from right to left
                if (_length < 0) then {
                    _start = _start + _length;
                };

                // Delete the selected characters and update the edit box's text and selection
                private _characters = toArray ctrlText _ctrlEdit;
                _characters deleteRange [_start, abs _length];
                _ctrlEdit ctrlSetText toString _characters;
                _ctrlEdit ctrlSetTextSelection [_start, 0];
            };
        };

        if (_keyCode == DIK_A && {_ctrl}) then {
            private _ctrlEdit = focusedCtrl _display;

            if (ctrlIDC _ctrlEdit in IDCS_CONFIGURE_EDIT_BOXES) then {
                _ctrlEdit ctrlSetTextSelection [0, count toArray ctrlText _ctrlEdit];
            };
        };

        if (_keyCode in [DIK_ESCAPE, DIK_RETURN]) then {
            private _ctrlConfigure = _display displayCtrl IDC_CONFIGURE_GROUP;

            if (_keyCode == DIK_RETURN) then {
                [_ctrlConfigure] call FUNC(applyProperties);
            };

            private _keyDownEH = _ctrlConfigure getVariable [QGVAR(keyDownEH), -1];
            _display displayRemoveEventHandler ["KeyDown", _keyDownEH];

            ctrlDelete _ctrlConfigure;
        };

        true // handled
    };
}];

_ctrlConfigure setVariable [QGVAR(keyDownEH), _keyDownEH];
_ctrlConfigure setVariable [QGVAR(marker), _marker];
