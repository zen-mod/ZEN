#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {
            QGVAR(moduleChatter),
            QGVAR(moduleCreateMinefield),
            QGVAR(moduleGlobalHint),
            QGVAR(moduleHideZeus),
            QGVAR(modulePatrolArea),
            QGVAR(moduleSideRelations),
            QGVAR(ModuleSmokePillar),
            QGVAR(moduleTeleportPlayers)
        };
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"zen_attributes"};
        author = "";
        url = "";
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgFactionClasses.hpp"
#include "CfgVehicles.hpp"
#include "RscAttributes.hpp"
