class CBA_Extended_EventHandlers_base;

class CfgVehicles {
    class Module_F;
    class GVAR(moduleBase): Module_F {
        author = "";
        category = "NO_CATEGORY";
        function = "";
        scope = 1;
        scopeCurator = 2;
        class EventHandlers {
            init = QUOTE(_this call FUNC(initModule));
            class CBA_Extended_EventHandlers: CBA_Extended_EventHandlers_base {};
        };
    };

    class ModuleArsenal_F: Module_F {
        scopeCurator = 1;
    };

    class ModuleCAS_F;
    class ModuleCASGun_F: ModuleCAS_F {
        scopeCurator = 1;
    };
    class ModuleCASBomb_F: ModuleCASGun_F {
        scopeCurator = 1;
    };

    class ModuleEmpty_F;
    class ModuleMine_F: ModuleEmpty_F {
        function = QFUNC(bi_moduleMine);
    };

    class GVAR(moduleAmbientAnim): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(AI);
        displayName = CSTRING(ModuleAmbientAnim);
        function = QFUNC(moduleAmbientAnim);
    };
    class GVAR(moduleAmbientFlyby): GVAR(moduleBase) {
        category = QGVAR(AI);
        displayName = CSTRING(ModuleAmbientFlyby);
        curatorInfoType = QGVAR(RscAmbientFlyby);
        icon = QPATHTOF(ui\heli_ca.paa);
    };
    class GVAR(moduleArsenal): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = "Curator";
        displayName = "$STR_A3_Arsenal";
        function = QFUNC(moduleArsenal);
        icon = "\a3\ui_f\data\logos\a_64_ca.paa";
    };
    class GVAR(moduleAssignZeus): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = "Curator";
        displayName = CSTRING(ModuleAssignZeus);
        function = QFUNC(moduleAssignZeus);
        icon = "\a3\Ui_F_Curator\Data\Logos\arma3_curator_eye_256_ca.paa";
    };
    class GVAR(moduleAttachEffect): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(Equipment);
        displayName = CSTRING(ModuleAttachEffect);
        curatorInfoType = QGVAR(RscAttachEffect);
    };
    class GVAR(moduleAttachFlag): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(Objects);
        displayName = CSTRING(ModuleAttachFlag);
        function = QFUNC(moduleAttachFlag);
        icon = QPATHTOF(ui\flag_ca.paa);
    };
    class GVAR(moduleAttachTo): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(Objects);
        displayName = CSTRING(ModuleAttachTo);
        function = QFUNC(moduleAttachTo);
    };
    class GVAR(moduleBindVariable): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(DevTools);
        displayName = CSTRING(BindVariable);
        function = QFUNC(moduleBindVariable);
    };
    class GVAR(moduleCASGun): GVAR(moduleBase) {
        category = "Ordnance";
        displayName = "$STR_A3_CfgVehicles_ModuleCAS_F_Arguments_Type_values_Gun";
        curatorInfoType = QGVAR(RscCAS);
        icon = "\a3\Modules_F_Curator\Data\portraitCASGun_ca.paa";
        model = "\a3\Modules_F_Curator\CAS\surfaceGun.p3d";
        simulation = "house";
        GVAR(casType) = 0;
    };
    class GVAR(moduleCASMissile): GVAR(moduleCASGun) {
        displayName = "$STR_A3_CfgVehicles_ModuleCAS_F_Arguments_Type_values_Missiles";
        icon = "\a3\Modules_F_Curator\Data\portraitCASMissile_ca.paa";
        model = "\a3\Modules_F_Curator\CAS\surfaceMissile.p3d";
        GVAR(casType) = 1;
    };
    class GVAR(moduleCASGunMissile): GVAR(moduleCASGun) {
        displayName = "$STR_A3_CfgVehicles_ModuleCAS_F_Arguments_Type_values_GunMissiles";
        icon = "\a3\Modules_F_Curator\Data\portraitCASGunMissile_ca.paa";
        model = "\a3\Modules_F_Curator\CAS\surfaceGunMissile.p3d";
        GVAR(casType) = 2;
    };
    class GVAR(moduleCASBomb): GVAR(moduleCASGun) {
        displayName = CSTRING(ModuleCAS_Bomb);
        icon = "\a3\Modules_F_Curator\Data\portraitCASBomb_ca.paa";
        model = "\a3\Modules_F_Curator\CAS\surfaceMissile.p3d";
        GVAR(casType) = 3;
    };
    class GVAR(moduleChangeHeight): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(Objects);
        displayName = CSTRING(ModuleChangeHeight);
        function = QFUNC(moduleChangeHeight);
    };
    class GVAR(moduleChatter): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(AI);
        displayName = CSTRING(ModuleChatter);
        function = QFUNC(moduleChatter);
        icon = QPATHTOF(ui\chat_ca.paa);
    };
    class GVAR(moduleConvoyParameters): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(AI);
        displayName = CSTRING(ModuleConvoyParameters);
        function = QFUNC(moduleConvoyParameters);
        icon = QPATHTOF(ui\truck_ca.paa);
    };
    class GVAR(moduleCreateIED): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(Objects);
        displayName = CSTRING(CreateIED);
        function = QFUNC(moduleCreateIED);
        icon = QPATHTOF(ui\explosion_ca.paa);
    };
    class GVAR(moduleCreateMinefield): GVAR(moduleBase) {
        category = QGVAR(Objects);
        displayName = CSTRING(ModuleCreateMinefield);
        function = QFUNC(moduleCreateMinefield);
    };
    class GVAR(moduleDamageBuildings): GVAR(moduleBase) {
        category = QGVAR(Buildings);
        displayName = CSTRING(ModuleDamageBuildings);
        curatorInfoType = QGVAR(RscDamageBuildings);
        icon = "\a3\modules_f\data\editterrainobject\icon_ca.paa";
    };
    class GVAR(moduleEarthquake): GVAR(moduleBase) {
        category = "Environment";
        displayName = CSTRING(ModuleEarthquake);
        function = QFUNC(moduleEarthquake);
    };
    class GVAR(moduleEditableObjects): GVAR(moduleBase) {
        category = "Curator";
        displayName = CSTRING(ModuleEditableObjects);
        curatorInfoType = QGVAR(RscEditableObjects);
        icon = QPATHTOF(ui\edit_obj_ca.paa);
    };
    class GVAR(moduleEquipWithECM): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(Objects);
        displayName = CSTRING(ModuleEquipWithECM);
        function = QFUNC(moduleEquipWithECM);
    };
    class GVAR(moduleFlyHeight): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(AI);
        displayName = CSTRING(ModuleFlyHeight);
        function = QFUNC(moduleFlyHeight);
    };
    class GVAR(moduleFunctionsViewer): GVAR(moduleBase) {
        category = QGVAR(DevTools);
        displayName = "$STR_A3_RscFunctionsViewer_Caption";
        function = QFUNC(moduleFunctionsViewer);
        icon = "\a3\3DEN\Data\Displays\Display3DEN\EntityMenu\functions_ca.paa";
    };
    class GVAR(moduleGarrison): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(AI);
        displayName = CSTRING(ModuleGarrison);
        function = QFUNC(moduleGarrison);
    };
    class GVAR(ModuleGroupSide): GVAR(moduleBase) {
        curatorCanAttach = 1;
        displayName = CSTRING(ModuleGroupSide);
        function = QFUNC(moduleGroupSide);
    };
    class GVAR(moduleGlobalHint): GVAR(moduleBase) {
        category = "Curator";
        displayName = CSTRING(ModuleGlobalHint);
        curatorInfoType = QGVAR(RscGlobalHint);
    };
    class GVAR(moduleHeal): GVAR(moduleBase) {
        curatorCanAttach = 1;
        displayName = CSTRING(ModuleHeal);
        function = QFUNC(moduleHeal);
        icon = QPATHTOF(ui\heal_ca.paa);
    };
    class GVAR(moduleHideZeus): GVAR(moduleBase) {
        category = "Curator";
        displayName = CSTRING(ModuleHideZeus);
        function = QFUNC(moduleHideZeus);
    };
    class GVAR(moduleLightSource): GVAR(moduleBase) {
        category = "Effects";
        displayName = CSTRING(ModuleLightSource);
        curatorInfoType = QGVAR(RscLightSourceHelper);
    };
    class GVAR(moduleMakeInvincible): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(Objects);
        displayName = CSTRING(ModuleMakeInvincible);
        function = QFUNC(moduleMakeInvincible);
    };
    class GVAR(modulePatrolArea): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(AI);
        displayName = CSTRING(ModulePatrolArea);
        function = QFUNC(modulePatrolArea);
    };
    class GVAR(moduleSetDate): GVAR(moduleBase) {
        category = "Environment";
        displayName = CSTRING(ModuleSetDate);
        curatorInfoType = QGVAR(RscSetDate);
    };
    class GVAR(moduleShowInConfig): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(DevTools);
        displayName = CSTRING(ShowInConfig);
        function = QFUNC(moduleShowInConfig);
        icon = "\a3\3DEN\Data\Displays\Display3DEN\EntityMenu\findConfig_ca.paa";
    };
    class GVAR(moduleSideRelations): GVAR(moduleBase) {
        category = "MissionFlow";
        displayName = CSTRING(ModuleSideRelations);
        curatorInfoType = QGVAR(RscSideRelations);
        icon = "\a3\ui_f\data\igui\cfg\simpletasks\types\help_ca.paa";
    };
    class GVAR(moduleSimulation): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(Objects);
        displayName = CSTRING(ModuleSimulation);
        function = QFUNC(moduleSimulation);
    };
    class GVAR(moduleSitOnChair): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(AI);
        displayName = CSTRING(ModuleSitOnChair);
        function = QFUNC(moduleSitOnChair);
        icon = QPATHTOF(ui\chair_ca.paa);
    };
    class GVAR(moduleSmokePillar): GVAR(moduleBase) {
        category = "Effects";
        displayName = CSTRING(ModuleSmokePillar);
        function = QFUNC(moduleSmokePillar);
        icon = QPATHTOF(ui\smoke_pillar_ca.paa);
    };
    class GVAR(moduleSpawnCarrier): GVAR(moduleBase) {
        category = QGVAR(Spawn);
        displayName = CSTRING(ModuleSpawnCarrier);
        function = QFUNC(moduleSpawnCarrier);
    };
    class GVAR(moduleSpawnDestroyer): GVAR(moduleBase) {
        category = QGVAR(Spawn);
        displayName = CSTRING(ModuleSpawnDestroyer);
        function = QFUNC(moduleSpawnDestroyer);
    };
    class GVAR(moduleTeleportPlayers): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(Players);
        displayName = CSTRING(ModuleTeleportPlayers);
        curatorInfoType = QGVAR(RscTeleportPlayers);
    };
    class GVAR(moduleTurretOptics): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(Equipment);
        displayName = CSTRING(ModuleTurretOptics);
        function = QFUNC(moduleTurretOptics);
    };
    class GVAR(moduleUnGarrison): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(AI);
        displayName = CSTRING(ModuleUnGarrison);
        function = QFUNC(moduleUnGarrison);
    };
    class GVAR(moduleVisibility): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(Objects);
        displayName = CSTRING(ModuleVisibility);
        function = QFUNC(moduleVisibility);
    };
};
