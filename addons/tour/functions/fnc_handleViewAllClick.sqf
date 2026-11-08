#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles clicking the button to browse all features while showing what's new.
 *
 * Arguments:
 * 0: Button <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_tour_fnc_handleViewAllClick
 *
 * Public: No
 */

params ["_ctrlButton"];

private _display = ctrlParent _ctrlButton;
private _feature = _display getVariable QGVAR(feature);
[_display, []] call FUNC(renderSidebar);
[_display, _feature] call FUNC(selectFeature);
