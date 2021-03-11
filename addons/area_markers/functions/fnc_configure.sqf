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

    _ctrl ctrlAddEventHandler ["KeyDown", {
        params ["_ctrl"];

        private _value  = ctrlText _ctrl;
        private _filter = toArray ".-0123456789";
        _value = toString (toArray _value select {_x in _filter});

        _ctrl ctrlSetText _value;
    }];
} forEach [
    [IDC_CONFIGURE_SIZE_A, _sizeA],
    [IDC_CONFIGURE_SIZE_B, _sizeB]
];

private _ctrlRotationSlider = _ctrlConfigure controlsGroupCtrl IDC_CONFIGURE_ROTATION_SLIDER;
private _ctrlRotationEdit   = _ctrlConfigure controlsGroupCtrl IDC_CONFIGURE_ROTATION_EDIT;
[_ctrlRotationSlider, _ctrlRotationEdit, 0, 360, markerDir _marker, 15, {format ["%1%2", round _this, toString [ASCII_DEGREE]]}] call EFUNC(common,initSliderEdit);

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


GVAR(configure_updateSideControl) = {
    params [
        ["_control", controlNull],
        ["_isSet", true, [false, true]]
    ];

    private _side = _control getVariable [QGVAR(side), sideUnknown];
    private _color = [_side] call BIS_fnc_sideColor;
    private _scale = 1;
    private _alpha = 0.5;
    if (_isSet) then {
        _scale = 1.2;
        _alpha = 1;
    };
    _control setVariable [QGVAR(value), _isSet];
    _color set [3, _alpha];
    _control ctrlSetTextColor _color;
    [_control, _scale, 0] call BIS_fnc_ctrlSetScale;
};

private _selectedSides = [GVAR(markerVisibilities), _marker] call CBA_fnc_hashGet;
private _sidesControlGroup = _ctrlConfigure controlsGroupCtrl IDC_CONFIGURE_SIDEVISIBILITY;
{
    private _control = _sidesControlGroup controlsGroupCtrl _x;
    _control ctrlAddEventHandler ["ButtonClick", {
            params ["_control"];
            [_control, !(_control getVariable [QGVAR(value), true])] call GVAR(configure_updateSideControl);
    }];
    private _controlSide = _foreachindex call bis_fnc_sideType;
    _control setVariable [QGVAR(side), _controlSide];
    [_control, _controlSide in _selectedSides] call GVAR(configure_updateSideControl);
} forEach IDCS_CONFIGURE_SIDEVISIBILITY_ALL;


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
{
    private _ctrl = _ctrlConfigure controlsGroupCtrl _x;

    _ctrl ctrlAddEventHandler ["SetFocus", {
        params ["_ctrl"];

        private _ctrlConfigure = ctrlParent _ctrl displayCtrl IDC_CONFIGURE_GROUP;
        _ctrlConfigure setVariable [QGVAR(focus), _ctrl];
    }];

    _ctrl ctrlAddEventHandler ["SetFocus", {
        params ["_ctrl"];

        private _ctrlConfigure = ctrlParent _ctrl displayCtrl IDC_CONFIGURE_GROUP;
        _ctrlConfigure setVariable [QGVAR(focus), nil];
    }];
} forEach [
    IDC_CONFIGURE_SIZE_A,
    IDC_CONFIGURE_SIZE_B,
    IDC_CONFIGURE_ROTATION_EDIT,
    IDC_CONFIGURE_ALPHA_EDIT
];

private _keyDownEH = _display displayAddEventHandler ["KeyDown", {
    call {
        params ["_display", "_keyCode"];

        if (_keyCode in [DIK_UP, DIK_DOWN, DIK_LEFT, DIK_RIGHT]) exitWith {false};

        if (_keyCode in [DIK_BACKSPACE, DIK_DELETE]) then {
            private _ctrlConfigure = _display displayCtrl IDC_CONFIGURE_GROUP;
            private _ctrlEdit = _ctrlConfigure getVariable QGVAR(focus);
            if (isNil "_ctrlEdit") exitWith {};

            private _text = ctrlText _ctrlEdit;

            if (_keyCode == DIK_BACKSPACE) then {
                _text = _text select [0, count _text - 1];
            };

            if (_keyCode == DIK_DELETE) then {
                _text = _text select [1, count _text - 1];
            };

            _ctrlEdit ctrlSetText _text;
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
