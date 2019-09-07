#include "script_component.hpp"

params [["_type", "", [""]], ["_title", "", [""]]];

if (isLocalized _title) then {
    _title = localize _title;
};

GVAR(titles) setVariable [_type, _title];
