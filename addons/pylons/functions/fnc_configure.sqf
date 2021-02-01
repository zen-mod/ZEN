#include "script_component.hpp"
/*
 * Author: mharis001
 * Opens a dialog to configure the pylons of the given aircraft.
 *
 * Arguments:
 * 0: Aircraft <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_aircraft] call zen_pylons_fnc_configure
 *
 * Public: No
 */

params ["_aircraft"];

if (!createDialog QGVAR(display)) exitWith {};

private _display = uiNamespace getVariable QGVAR(display);

private _config = configOf _aircraft;
private _pylonsConfig = _config >> "Components" >> "TransportPylonsComponent";

// Set the display's title to the aircraft name
private _ctrlTitle = _display displayCtrl IDC_TITLE;
_ctrlTitle ctrlSetText toUpper format [localize LSTRING(Title), getText (_config >> "displayName")];

// Set the aircraft's pylons UI picture
private _ctrlPicture = _display displayCtrl IDC_PICTURE;
_ctrlPicture ctrlSetText getText (_pylonsConfig >> "uiPicture");

ctrlPosition _ctrlPicture params ["_pictureX", "_pictureY", "_pictureW", "_pictureH"];

private _cfgMagazines = configFile >> "CfgMagazines";
private _currentMagazines = getPylonMagazines _aircraft;
private _hasGunner = [0] in allTurrets [_aircraft, false];

// Create controls to configure the aircraft's pylons
private _controls = [];

{
    private _uiPos = getArray (_x >> "UIposition") apply {
        if (_x isEqualType "") then {call compile _x} else {_x}
    };

    _uiPos params ["_uiPosX", "_uiPosY"];

    private _posX = _pictureX + _uiPosX * _pictureW * SCALE_FACTOR_X;
    private _posY = _pictureY + _uiPosY * _pictureH * SCALE_FACTOR_Y;

    private _mirroredIndex = getNumber (_x >> "mirroredMissilePos") - 1;
    private _defaultTurretPath = getArray (_x >> "turret");

    private _ctrlCombo = _display ctrlCreate ["ctrlCombo", -1];
    _ctrlCombo ctrlSetPosition [_posX, _posY, GRID_W(82/3), GRID_H(5)];
    _ctrlCombo ctrlCommit 0;

    _ctrlCombo ctrlAddEventHandler ["LBSelChanged", {call FUNC(handleMagazineSelect)}];
    _ctrlCombo setVariable [QGVAR(index), _forEachIndex];

    _ctrlCombo lbAdd localize LSTRING(Empty);
    _ctrlCombo lbSetCurSel 0;

    // Get compatible magazines and sort them alphabetically by name
    private _magazines = _aircraft getCompatiblePylonMagazines configName _x apply {
        private _config = _cfgMagazines >> _x;
        [getText (_config >> "displayName"), getText (_config >> "descriptionShort"), _x]
    };

    _magazines sort true;

    // Add compatible magazines to the combo box and select the current one
    private _currentMagazine = _currentMagazines select _forEachIndex;

    {
        _x params ["_name", "_tooltip", "_magazine"];

        private _index = _ctrlCombo lbAdd _name;
        _ctrlCombo lbSetTooltip [_index, _tooltip];
        _ctrlCombo lbSetData [_index, _magazine];

        if (_magazine == _currentMagazine) then {
            _ctrlCombo lbSetCurSel _index;
        };
    } forEach _magazines;

    // Create turret button if aircraft has a gunner position
    private _ctrlTurret = controlNull;

    if (_hasGunner) then {
        _ctrlTurret = _display ctrlCreate ["ctrlButtonPictureKeepAspect", -1];
        _ctrlTurret ctrlSetPosition [_posX - GRID_W(5), _posY, GRID_W(5), GRID_H(5)];
        _ctrlTurret ctrlCommit 0;

        private _turretPath = [_aircraft, _forEachIndex] call EFUNC(common,getPylonTurret);
        _ctrlTurret setVariable [QGVAR(turretPath), _turretPath];
        _ctrlTurret setVariable [QGVAR(index), _forEachIndex];
        _ctrlTurret call FUNC(handleTurretButton);

        // Toggle the pylon's turret when the button is clicked
        _ctrlTurret ctrlAddEventHandler ["ButtonClick", {
            params ["_ctrlTurret"];

            [_ctrlTurret, true] call FUNC(handleTurretButton);
        }];
    };

    _controls pushBack [_ctrlCombo, _ctrlTurret, _mirroredIndex, _defaultTurretPath];
} forEach configProperties [_pylonsConfig >> "Pylons", "isClass _x"];

_display setVariable [QGVAR(aircraft), _aircraft];
_display setVariable [QGVAR(controls), _controls];

// Add the aircraft's pylons presets to the presets combo box
private _ctrlPresets = _display displayCtrl IDC_PRESETS;
_ctrlPresets lbAdd localize "STR_Radio_Custom";
_ctrlPresets lbSetPicture [0, ICON_JETS];
_ctrlPresets lbSetCurSel 0;

{
    private _index = _ctrlPresets lbAdd getText (_x >> "displayName");
    _ctrlPresets lbSetPicture [_index, ICON_JETS];
    _ctrlPresets setVariable [str _index, getArray (_x >> "attachment")];
} forEach configProperties [_pylonsConfig >> "Presets", "isClass _x"];

// Update pylons when a preset is selected
_ctrlPresets ctrlAddEventHandler ["LBSelChanged", {call FUNC(handlePreset)}];

// Toggle pylons mirroring when the checkbox is clicked
private _ctrlMirror = _display displayCtrl IDC_MIRROR;
_ctrlMirror ctrlAddEventHandler ["CheckedChanged", {
    params ["_ctrlMirror", "_checked"];

    private _display = ctrlParent _ctrlMirror;
    [_display, _checked == 1] call FUNC(handleMirror);
}];

// Confirm changes to the pylon loadout when the OK button is clicked
private _ctrlButtonOK = _display displayCtrl IDC_OK;
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", {call FUNC(handleConfirm)}];
