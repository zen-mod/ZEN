#include "script_component.hpp"
/*
 * Author: Ampersand
 * Attaches the given objects to a parent object selected by Zeus.
 *
 * Arguments:
 * 0: Objects <ARRAY>
 * 1: Is Bone <BOOLEAN>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_object] call zen_attached_objects_fnc_attachBone
 *
 * Public: No
 */

[_this, {
    params ["_successful", "_objects"];

    if (!_successful) exitWith {};

    curatorMouseOver params ["_type", "_entity"];
    if (_type isNotEqualTo "OBJECT") exitWith {};

    // Prevent attaching object to itself
    private _index = _objects find _entity;

    if (_index != -1 && {count _objects == 1}) exitWith {
        [LSTRING(CannotAttachToSelf)] call EFUNC(common,showMessage);
    };

    _objects deleteAt _index;

    if (isNil QGVAR(modelSelections)) then {
        GVAR(modelSelections) = createHashMap;
    };

    private _entries = GVAR(modelSelections) getOrDefaultCall [getText (configOf _entity >> "model"), {
        private _turretsCfg = allTurrets _entity apply {[_entity, _x] call CBA_fnc_getTurret};
        private _selections = _entity selectionNames LOD_MEMORY select {
            _entity selectionVectorDirAndUp [_x, LOD_MEMORY] isNotEqualTo [[0,0,0], [0,0,0]]
        };
        [
            [""] + (_turretsCfg apply {getText (_x >> "memoryPointGunnerOptics")}) + _selections,
            [""] + (_turretsCfg apply {configName _x}) + _selections apply {[_x] call FUNC(parseSelectionName)}
        ]
    }, true];

    [LSTRING(AttachTo), [
        [
            "COMBO",
            LSTRING(Bone),
            _entries
        ],
        [
            "TOOLBOX",
            [LSTRING(Orientation), LSTRING(Orientation_Description)],
            [true, 1, 2, [LSTRING(Bone), LSTRING(Relative)]],
            true
        ]
    ], {
        params ["_values", "_args"];
        _values params ["_selection", "_isRelative"];
        _args params ["_objects", "_entity"];

        if (_selection isEqualTo "") then {
            {
                private _dirAndUp = [_entity vectorWorldToModel vectorDir _x, _entity vectorWorldToModel vectorUp _x];
                _x attachTo [_entity];
                [QEGVAR(common,setVectorDirAndUp), [_x, _dirAndUp], _x] call CBA_fnc_targetEvent;
            } forEach _objects;
        } else {
            {
                [_x, _entity, _selection, _isRelative] call FUNC(attachToSelection);
            } forEach _objects;

            private _hintPos = _entity modelToWorldVisual (_entity selectionPosition [_selection, LOD_MEMORY]);
            _entity selectionVectorDirAndUp [_selection, LOD_MEMORY] params ["_selectionY", "_selectionZ"];
            [[
                ["ICON", [_hintPos, "\a3\ui_f\data\IGUI\Cfg\Targeting\LaserTarget_ca.paa"]],
                ["LINE", [_hintPos, _entity vectorModelToWorldVisual _selectionY vectorMultiply 2 vectorAdd _hintPos, [0, 1, 0, 1]]],
                ["LINE", [_hintPos, _entity vectorModelToWorldVisual _selectionZ vectorAdd _hintPos, [0, 0, 1, 1]]]
            ], 3, _entity] call EFUNC(common,drawHint);
        };

        [LSTRING(ObjectsAttached), count _objects] call EFUNC(common,showMessage);
    }, {}, [_objects, _entity]] call EFUNC(dialog,create);

}, [], LSTRING(AttachTo)] call EFUNC(common,selectPosition);
