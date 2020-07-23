#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#include "initKeybinds.sqf"

// Namespace thats stores data of all attribute displays
GVAR(displays) = [] call CBA_fnc_createNamespace;

// Namespace that tracks selected marker colors by marker type
// Colors are applied to newly placed markers of the same type
GVAR(previousMarkerColors) = [] call CBA_fnc_createNamespace;

GVAR(selectedGroup) = grpNull;
GVAR(selectedEntity) = objNull;

["ModuleCurator_F", "Init", {
    params ["_logic"];

    _logic addEventHandler ["CuratorMarkerPlaced", {call FUNC(handleMarkerPlaced)}];

    // Handle group being select when all of its sub entities are selected
    private _fnc_checkGroupSelection = {
        private _entity = _this # 1;
        if (_entity isEqualType grpNull) then {
            GVAR(selectedGroup) = _entity;
        } else {
            private _groups = curatorSelected # 1;
            if (count _groups != 1 || {(_groups # 0) != GVAR(selectedGroup)}) then {
                GVAR(selectedGroup) = grpNull;
            };
            // selecing group with only 1 entity, deselecting, then re-selecting that entity
            // should switch the focus from the group to the entity, and vice versa
            if (_entity isEqualType GVAR(selectedEntity) && {_entity == GVAR(selectedEntity)}) then {
                GVAR(selectedGroup) = grpNull;
            };
        };
        GVAR(selectedEntity) = _entity;
    };
    _logic addEventHandler ["CuratorGroupSelectionChanged", _fnc_checkGroupSelection];
    _logic addEventHandler ["CuratorMarkerSelectionChanged", _fnc_checkGroupSelection];
    _logic addEventHandler ["CuratorObjectSelectionChanged", _fnc_checkGroupSelection];
    _logic addEventHandler ["CuratorWaypointSelectionChanged", _fnc_checkGroupSelection];
}, true, [], true] call CBA_fnc_addClassEventHandler;

// Initialize the core/default attributes
#include "initAttributes.sqf"

ADDON = true;
