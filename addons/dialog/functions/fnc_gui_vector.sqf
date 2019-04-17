/*
 * Author: mharis001
 * Initializes the VECTOR content control.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Row Index <NUMBER>
 * 2: Current Value <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 0, [100, 100]] call zen_dialog_fnc_gui_vector
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_controlsGroup", "_rowIndex", "_currentValue"];

for "_index" from 0 to (count _currentValue - 1) do {
    private _ctrlEdit = _controlsGroup controlsGroupCtrl (IDCS_ROW_VECTOR select _index);
    _ctrlEdit ctrlSetText str (_currentValue param [_index, 0]);

    _ctrlEdit setVariable [QGVAR(params), [_rowIndex, _currentValue, _index]];

    _ctrlEdit ctrlAddEventHandler ["KeyDown", {
        params ["_ctrlEdit"];

        private _value  = ctrlText _ctrlEdit;
        private _filter = toArray ".-0123456789";
        _value = toString (toArray _value select {_x in _filter});

        _ctrlEdit ctrlSetText _value;
    }];

    _ctrlEdit ctrlAddEventHandler ["KeyUp", {
        params ["_ctrlEdit"];
        (_ctrlEdit getVariable QGVAR(params)) params ["_rowIndex", "_currentValue", "_index"];

        private _value = parseNumber ctrlText _ctrlEdit;
        _currentValue set [_index, _value];

        private _display = ctrlParent _ctrlEdit;
        private _values = _display getVariable QGVAR(values);
        _values set [_rowIndex, _currentValue];
    }];
};
