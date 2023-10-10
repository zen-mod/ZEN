#include "script_component.hpp"
/*
 * Author: mharis001
 * Attaches the given objects to a parent object selected by Zeus.
 *
 * Arguments:
 * N: Object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_object] call zen_attached_objects_fnc_attach
 *
 * Public: No
 */

[_this, {
    params ["_successful", "_objects"];

    if (!_successful) exitWith {};

    curatorMouseOver params ["_type", "_entity"];
    if (_type != "OBJECT") exitWith {};

    // Prevent attaching object to itself
    private _index = _objects find _entity;

    if (_index != -1 && {count _objects == 1}) exitWith {
        [LSTRING(CannotAttachToSelf)] call EFUNC(common,showMessage);
    };

    _objects deleteAt _index;

    if (isNil QGVAR(modelSelections)) then {
        GVAR(modelSelections) = createHashMap;
    };

    private _selections = GVAR(modelSelections) getOrDefaultCall [getText (configOf _entity >> "model"), {
            [""] + (_entity selectionNames LOD_MEMORY select {
                _entity selectionVectorDirAndUp [_x, LOD_MEMORY] isNotEqualTo [[0,0,0], [0,0,0]]
            })
    }, true];

    [LSTRING(AttachTo), [
        [
            "COMBO",
            "Selection",
            [_selections, _selections, _selections find _selection]
        ],
        [
            "TOOLBOX",
            ["Orientation", "Selection: match selection orientation (i.e. along gun barrel). Relative: maintain current orientation relative to selection."],
            [true, 1, 2, ["Selection", "Relative"]],
            true
        ]
    ], {
        params ["_values", "_args"];
        _values params ["_selection", "_isRelative"];
        _args params ["_objects", "_entity"];

        {
            if (_selection == "") then {
                private _dirAndUp = [_entity vectorWorldToModel vectorDir _x, _entity vectorWorldToModel vectorUp _x];
                _x attachTo [_entity];
                [QEGVAR(common,setVectorDirAndUp), [_x, _dirAndUp], _x] call CBA_fnc_targetEvent;
            } else {
                [_x, _entity, _selection, _isRelative] call FUNC(attachToSelection);
            };
        } forEach _objects;

        [LSTRING(ObjectsAttached), count _objects] call EFUNC(common,showMessage);
    }, {}, [_objects, _entity]] call EFUNC(dialog,create);

}, [], LSTRING(AttachTo)] call EFUNC(common,selectPosition);
