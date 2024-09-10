#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

GVAR(randomize) = false;

private _compositions = GET_COMPOSITIONS;

if (_compositions isEqualType []) then {
    private _newCompositions = createHashMap;

    {
        _x params ["_category", "_name", "_data"];

        private _categoryHash = _newCompositions getOrDefault [_category, createHashMap, true];
        _categoryHash set [_name, _data];
    } forEach _compositions;

    SET_COMPOSITIONS(_newCompositions);
};

ADDON = true;
