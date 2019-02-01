#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {
            QGVAR(moduleAttachTo),
            QGVAR(moduleBindVariable),
            QGVAR(moduleChangeHeight),
            QGVAR(moduleChatter),
            QGVAR(moduleCreateIED),
            QGVAR(moduleCreateMinefield),
            QGVAR(moduleDamageBuildings),
            QGVAR(moduleEarthquake),
            QGVAR(moduleFunctionsViewer),
            QGVAR(moduleGlobalHint),
            QGVAR(moduleHideZeus),
            QGVAR(moduleMakeInvincible),
            QGVAR(modulePatrolArea),
            QGVAR(moduleShowInConfig),
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
