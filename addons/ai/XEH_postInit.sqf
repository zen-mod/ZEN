#include "script_component.hpp"

QGVAR(skills) addPublicVariableEventHandler LINKFUNC(handleSkillsChange);
[QGVAR(throwGrenade), LINKFUNC(throwGrenade)] call CBA_fnc_addEventHandler;

["CAManBase", "InitPost", LINKFUNC(initMan), true, [], false] call CBA_fnc_addClassEventHandler;

[QGVAR(unGarrison), LINKFUNC(unGarrison)] call CBA_fnc_addEventHandler;
