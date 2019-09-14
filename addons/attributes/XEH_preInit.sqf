#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

GVAR(markerColors) = [] call CBA_fnc_createNamespace;

["ModuleCurator_F", "Init", {
    params ["_logic"];

    _logic addEventHandler ["CuratorMarkerPlaced", {call FUNC(handleMarkerPlaced)}];
    _logic addEventHandler ["CuratorObjectPlaced", {call FUNC(handleObjectPlaced)}];
}, true, [], true] call CBA_fnc_addClassEventHandler;

GVAR(attributes) = [] call CBA_fnc_createNamespace;
GVAR(buttons)    = [] call CBA_fnc_createNamespace;
GVAR(titles)     = [] call CBA_fnc_createNamespace;

["Skills", LSTRING(ChangeSkills)] call FUNC(addTitle);
["Traits", LSTRING(ChangeTraits)] call FUNC(addTitle);
["Sensors", "STR_3DEN_Object_AttributeCategory_VehicleSystems"] call FUNC(addTitle);
["Side", LSTRING(ChangeSide)] call FUNC(addTitle);

#include "initAttributes.sqf"
#include "initButtons.sqf"

ADDON = true;
