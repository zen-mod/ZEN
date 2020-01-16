#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

// Disable CBA inventory attribute preload
uiNamespace setVariable ["cba_ui_curatorItemCache", []];

// Add inventory button to attribute display
[
    "Object",
    "STR_A3_Gear1",
    {
        GVAR(object) = _this;
        createDialog QGVAR(display);
    },
    {
        alive _entity && {getNumber (configFile >> "CfgVehicles" >> typeOf _entity >> "maximumLoad") > 0}
    }
] call EFUNC(attributes,addButton);

ADDON = true;
