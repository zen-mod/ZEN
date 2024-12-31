#include "script_component.hpp"

params ["_id"];

GVAR(comments) deleteAt _id;

_id call FUNC(deleteIcon);
