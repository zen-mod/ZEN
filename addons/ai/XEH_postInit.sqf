#include "script_component.hpp"

QGVAR(skills) addPublicVariableEventHandler LINKFUNC(handleSkillsChange);

["CAManBase", "InitPost", LINKFUNC(initMan), true, [], false] call CBA_fnc_addClassEventHandler;

[QGVAR(unGarrison), LINKFUNC(unGarrison)] call CBA_fnc_addEventHandler;

[QGVAR(unpackStaticWeapon), LINKFUNC(unpackStaticWeapon)] call CBA_fnc_addEventHandler;
