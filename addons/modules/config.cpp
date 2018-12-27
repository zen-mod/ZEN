#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {
            QGVAR(moduleAttachTo),
            QGVAR(moduleChatter),
            QGVAR(moduleCreateMinefield),
            QGVAR(moduleGlobalHint),
            QGVAR(moduleHideZeus),
            QGVAR(modulePatrolArea),
            QGVAR(moduleSideRelations),
            QGVAR(moduleSimulation),
            QGVAR(moduleSmokePillar),
            QGVAR(moduleTeleportPlayers),
            QGVAR(moduleVisibility)
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
