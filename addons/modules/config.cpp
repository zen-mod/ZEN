#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {
            QGVAR(moduleAmbientAnim),
            QGVAR(moduleAmbientFlyby),
            QGVAR(moduleArsenal),
            QGVAR(moduleAttachTo),
            QGVAR(moduleAttachEffect),
            QGVAR(moduleAttachFlag),
            QGVAR(moduleBindVariable),
            QGVAR(moduleChangeHeight),
            QGVAR(moduleChatter),
            QGVAR(moduleConvoyParameters),
            QGVAR(moduleCreateIED),
            QGVAR(moduleCreateMinefield),
            QGVAR(moduleDamageBuildings),
            QGVAR(moduleEarthquake),
            QGVAR(moduleEquipWithECM),
            QGVAR(moduleFlyHeight),
            QGVAR(moduleFunctionsViewer),
            QGVAR(moduleGlobalHint),
            QGVAR(moduleHeal),
            QGVAR(moduleHideZeus),
            QGVAR(moduleLightSource),
            QGVAR(moduleMakeInvincible),
            QGVAR(modulePatrolArea),
            QGVAR(moduleSetDate),
            QGVAR(moduleShowInConfig),
            QGVAR(moduleSideRelations),
            QGVAR(moduleSimulation),
            QGVAR(moduleSmokePillar),
            QGVAR(moduleSpawnCarrier),
            QGVAR(moduleSpawnDestroyer),
            QGVAR(moduleTeleportPlayers),
            QGVAR(moduleVisibility)
        };
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"zen_attributes"};
        author = ECSTRING(main,Author);
        authors[] = {"mharis001"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgFactionClasses.hpp"
#include "CfgVehicles.hpp"
#include "RscAttributes.hpp"
