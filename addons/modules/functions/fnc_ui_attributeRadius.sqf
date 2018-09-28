/*
 * Author: SilentSpike (ace_zeus), mharis001
 * Initializes the "Radius" Zeus module attribute.
 *
 * Arguments:
 * 0: radius controls group <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_modules_fnc_ui_attributeRadius
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_control"];

private _display = ctrlParent _control;
_control ctrlRemoveAllEventHandlers "SetFocus";

// Add keyUp event to update radius
private _fnc_onKeyUp = {
    params ["_ctrlEdit"];

    private _radius = parseNumber ctrlText _ctrlEdit;

    // Handle invalid radius (non-numerical input)
    if (_radius == 0) then {
        _ctrlEdit ctrlSetTooltip localize LSTRING(AttributeRadius_Invalid);
        _ctrlEdit ctrlSetTextColor [1, 0, 0, 1];
    } else {
        _ctrlEdit ctrlSetTooltip "";
        _ctrlEdit ctrlSetTextColor [1, 1, 1, 1];
        ctrlParent _ctrlEdit setVariable [QGVAR(radius), _radius];
    };
};

private _ctrlEdit = _control controlsGroupCtrl IDC_ATTRIBUTERADIUS_VALUE;
_ctrlEdit ctrlAddEventHandler ["KeyUp", _fnc_onKeyUp];
_ctrlEdit call _fnc_onKeyUp;
