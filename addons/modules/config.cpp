#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {
            QGVAR(moduleAmbientAnim),
            QGVAR(moduleAmbientFlyby),
            QGVAR(moduleArsenal),
            QGVAR(moduleAssignZeus),
            QGVAR(moduleAttachEffect),
            QGVAR(moduleAttachFlag),
            QGVAR(moduleAttachTo),
            QGVAR(moduleBindVariable),
            QGVAR(moduleCASGun),
            QGVAR(moduleCASMissile),
            QGVAR(moduleCASGunMissile),
            QGVAR(moduleCASBomb),
            QGVAR(moduleChangeHeight),
            QGVAR(moduleChatter),
            QGVAR(moduleConvoyParameters),
            QGVAR(moduleCreateIED),
            QGVAR(moduleCreateMinefield),
            QGVAR(moduleCreateTarget),
            QGVAR(moduleDamageBuildings),
            QGVAR(moduleEarthquake),
            QGVAR(moduleEditableObjects),
            QGVAR(moduleEquipWithECM),
            QGVAR(moduleExecuteCode),
            QGVAR(moduleFireMission),
            QGVAR(moduleFlyHeight),
            QGVAR(moduleFunctionsViewer),
            QGVAR(moduleGarrison),
            QGVAR(ModuleGroupSide),
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
            QGVAR(moduleSitOnChair),
            QGVAR(moduleSmokePillar),
            QGVAR(moduleSpawnCarrier),
            QGVAR(moduleSpawnDestroyer),
            QGVAR(moduleSuicideBomber),
            QGVAR(moduleTeleportPlayers),
            QGVAR(moduleTurretOptics),
            QGVAR(moduleUnGarrison),
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
