#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

GVAR(randomize) = false;

private _compositions = GET_COMPOSITIONS;

if (typeName _compositions isEqualTo "ARRAY") then {
    private _newCompositions = createHashMap;

    {
        _x params ["_category", "_name", "_data"];

        private _categoryHash = _newCompositions get _category;

        if (isNil "_categoryHash") then {
            _categoryHash = createHashMapFromArray [[_name, _data]];
            _newCompositions set [_category, _categoryHash];
        } else {
            _categoryHash set [_name, _data];
        };
    } forEach _compositions;

    profileNamespace setVariable [VAR_COMPOSITIONS, _newCompositions];
};

ADDON = true;
