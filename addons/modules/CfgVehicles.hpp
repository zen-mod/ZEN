class CBA_Extended_EventHandlers_base;

class CfgVehicles {
    class Module_F;
    class GVAR(moduleBase): Module_F {
        author = ECSTRING(main,Author);
        category = "NO_CATEGORY";
        function = "";
        scope = 1;
        scopeCurator = 2;
        class EventHandlers {
            init = QUOTE(_this call FUNC(initModule));
            class CBA_Extended_EventHandlers: CBA_Extended_EventHandlers_base {};
        };
    };

    class ModuleCurator_F: Module_F {
        function = QFUNC(bi_moduleCurator);
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

    class GVAR(moduleAddFullArsenal): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = GVAR(Inventory);
        displayName = CSTRING(ModuleAddFullArsenal);
        function = QFUNC(moduleAddFullArsenal);
        icon = "\a3\ui_f\data\logos\a_64_ca.paa";
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
        displayName = CSTRING(AttachEffect);
        function = QFUNC(moduleAttachEffect);
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
        portrait = "\a3\Modules_F_Curator\Data\portraitCASGun_ca.paa";
        model = "\a3\Modules_F_Curator\CAS\surfaceGun.p3d";
        simulation = "house";
        GVAR(casType) = 0;
    };
    class GVAR(moduleCASMissile): GVAR(moduleCASGun) {
        displayName = "$STR_A3_CfgVehicles_ModuleCAS_F_Arguments_Type_values_Missiles";
        icon = "\a3\Modules_F_Curator\Data\portraitCASMissile_ca.paa";
        portrait = "\a3\Modules_F_Curator\Data\portraitCASMissile_ca.paa";
        model = "\a3\Modules_F_Curator\CAS\surfaceMissile.p3d";
        GVAR(casType) = 1;
    };
    class GVAR(moduleCASGunMissile): GVAR(moduleCASGun) {
        displayName = "$STR_A3_CfgVehicles_ModuleCAS_F_Arguments_Type_values_GunMissiles";
        icon = "\a3\Modules_F_Curator\Data\portraitCASGunMissile_ca.paa";
        portrait = "\a3\Modules_F_Curator\Data\portraitCASGunMissile_ca.paa";
        model = "\a3\Modules_F_Curator\CAS\surfaceGunMissile.p3d";
        GVAR(casType) = 2;
    };
    class GVAR(moduleCASBomb): GVAR(moduleCASGun) {
        displayName = CSTRING(ModuleCAS_Bomb);
        icon = "\a3\Modules_F_Curator\Data\portraitCASBomb_ca.paa";
        portrait = "\a3\Modules_F_Curator\Data\portraitCASBomb_ca.paa";
        model = "\a3\Modules_F_Curator\CAS\surfaceMissile.p3d";
        GVAR(casType) = 3;
    };
    class GVAR(moduleChangeHeight): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(Objects);
        displayName = CSTRING(ChangeHeight);
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
    class GVAR(moduleCreateIntel): GVAR(moduleBase) {
        curatorCanAttach = 1;
        displayName = CSTRING(ModuleCreateIntel);
        function = QFUNC(moduleCreateIntel);
        icon = "\a3\ui_f\data\igui\cfg\simpletasks\types\documents_ca.paa";
    };
    class GVAR(moduleCreateLZ): GVAR(moduleBase) {
        category = QGVAR(Reinforcements);
        displayName = CSTRING(ModuleCreateLZ);
        function = QFUNC(moduleCreateLZ);
        icon = "\a3\modules_f\data\portraitsector_ca.paa";
        portrait = "\a3\modules_f\data\portraitsector_ca.paa";
    };
    class GVAR(moduleCreateMinefield): GVAR(moduleBase) {
        category = QGVAR(Objects);
        displayName = CSTRING(ModuleCreateMinefield);
        function = QFUNC(moduleCreateMinefield);
    };
    class GVAR(moduleCreateRP): GVAR(moduleBase) {
        category = QGVAR(Reinforcements);
        displayName = CSTRING(ModuleCreateRP);
        function = QFUNC(moduleCreateRP);
        icon = QPATHTOF(ui\rp_ca.paa);
        portrait = QPATHTOF(ui\rp_ca.paa);
    };
    class GVAR(moduleCreateTarget): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = "Ordnance";
        displayName = CSTRING(ModuleCreateTarget);
        function = QFUNC(moduleCreateTarget);
        icon = QPATHTOF(ui\target_ca.paa);
        portrait = QPATHTOF(ui\target_ca.paa);
    };
    class GVAR(moduleCreateTeleporter): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(Players);
        displayName = CSTRING(ModuleCreateTeleporter);
        function = QFUNC(moduleCreateTeleporter);
        icon = "\a3\3den\data\displays\display3den\panelleft\entitylist_location_ca.paa";
    };
    class GVAR(moduleCrewToGunner): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(AI);
        displayName = CSTRING(ModuleCrewToGunner);
        function = QFUNC(moduleCrewToGunner);
        icon = "\a3\ui_f\data\IGUI\Cfg\Actions\getingunner_ca.paa";
    };
    class GVAR(moduleDamageBuildings): GVAR(moduleBase) {
        curatorCanAttach = 1;
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
    class GVAR(moduleEffectFire): GVAR(moduleBase) {
        category = "Effects";
        displayName = CSTRING(CustomFire);
        curatorInfoType = QGVAR(RscEffectFireHelper);
        icon = QPATHTOF(ui\fire_ca.paa);
        portrait = QPATHTOF(ui\fire_ca.paa);
    };
    class GVAR(moduleEquipWithECM): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(Objects);
        displayName = CSTRING(ModuleEquipWithECM);
        function = QFUNC(moduleEquipWithECM);
    };
    class GVAR(moduleExportMissionSQF): GVAR(moduleBase) {
        category = QGVAR(DevTools);
        displayName = CSTRING(ExportMissionSQF);
        function = QFUNC(moduleExportMissionSQF);
    };
    class GVAR(moduleExecuteCode): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(DevTools);
        displayName = CSTRING(ModuleExecuteCode);
        curatorInfoType = QGVAR(RscExecuteCode);
        icon = QPATHTOF(ui\code_ca.paa);
        portrait = QPATHTOF(ui\code_ca.paa);
    };
    class GVAR(moduleFireMission): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = "Ordnance";
        displayName = CSTRING(ModuleFireMission);
        curatorInfoType = QGVAR(RscFireMission);
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
    class GVAR(moduleGlobalAISkill): GVAR(moduleBase) {
        category = QGVAR(AI);
        displayName = CSTRING(GlobalAISkill);
        function = QFUNC(moduleGlobalAISkill);
    };
    class GVAR(moduleGlobalHint): GVAR(moduleBase) {
        category = "Curator";
        displayName = CSTRING(ModuleGlobalHint);
        curatorInfoType = QGVAR(RscGlobalHint);
    };
    class GVAR(moduleGroupSide): GVAR(moduleBase) {
        curatorCanAttach = 1;
        displayName = CSTRING(GroupSide);
        function = QFUNC(moduleGroupSide);
    };
    class GVAR(moduleHeal): GVAR(moduleBase) {
        curatorCanAttach = 1;
        displayName = CSTRING(ModuleHeal);
        function = QFUNC(moduleHeal);
        icon = QPATHTOF(ui\heal_ca.paa);
    };
    class GVAR(moduleHideTerrainObjects): GVAR(moduleBase) {
        category = "Environment";
        displayName = "$STR_a3_to_hideTerrainObjects1";
        function = QFUNC(moduleHideTerrainObjects);
        icon = "\a3\modules_f\data\hideterrainobjects\icon32_ca.paa";
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
        icon = QPATHTOF(ui\light_ca.paa);
        portrait = QPATHTOF(ui\light_ca.paa);
    };
    class GVAR(moduleMakeInvincible): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(Objects);
        displayName = CSTRING(ModuleMakeInvincible);
        function = QFUNC(moduleMakeInvincible);
    };
    class GVAR(moduleNuke): GVAR(moduleBase) {
        category = "Ordnance";
        displayName = CSTRING(AtomicBomb);
        function = QFUNC(moduleNuke);
        icon = QPATHTOF(ui\nuke_ca.paa);
    };
    class GVAR(modulePatrolArea): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(AI);
        displayName = CSTRING(ModulePatrolArea);
        function = QFUNC(modulePatrolArea);
    };
    class GVAR(moduleRemoveArsenal): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = GVAR(Inventory);
        displayName = CSTRING(ModuleRemoveArsenal);
        function = QFUNC(moduleRemoveArsenal);
        icon = "\a3\ui_f\data\logos\a_64_ca.paa";
    };
    class GVAR(moduleRotateObject): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = GVAR(Objects);
        displayName = CSTRING(RotateObject);
        function = QFUNC(moduleRotateObject);
        icon = QPATHTOF(ui\rotate_ca.paa);
    };
    class GVAR(moduleSearchBuilding): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(AI);
        displayName = ECSTRING(ai,SearchBuilding);
        function = QFUNC(moduleSearchBuilding);
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
        portrait = QPATHTOF(ui\smoke_pillar_ca.paa);
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
    class GVAR(moduleSpawnReinforcements): GVAR(moduleBase) {
        category = QGVAR(Reinforcements);
        displayName = CSTRING(SpawnReinforcements);
        curatorInfoType = QGVAR(RscSpawnReinforcements);
    };
    class GVAR(moduleSuicideBomber): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(AI);
        displayName = CSTRING(ModuleSuicideBomber);
        function = QFUNC(moduleSuicideBomber);
    };
    class GVAR(moduleTeleportPlayers): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(Players);
        displayName = CSTRING(ModuleTeleportPlayers);
        function = QFUNC(moduleTeleportPlayers);
    };
    class GVAR(moduleToggleFlashlights): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(Equipment);
        displayName = CSTRING(ModuleToggleFlashlights);
        function = QFUNC(moduleToggleFlashlights);
        icon = QPATHTOF(ui\flashlight_ca.paa);
    };
    class GVAR(moduleToggleIRLasers): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(Equipment);
        displayName = CSTRING(ModuleToggleIRLasers);
        function = QFUNC(moduleToggleIRLasers);
        icon = "\a3\ui_f_curator\data\cfgcurator\laser_ca.paa";
    };
    class GVAR(moduleToggleLamps): GVAR(moduleBase) {
        category = QGVAR(Buildings);
        displayName = CSTRING(ToggleLamps);
        function = QFUNC(moduleToggleLamps);
        icon = QPATHTOF(ui\street_lamp_ca.paa);
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
    class GVAR(moduleWeather): GVAR(moduleBase) {
        category = "Environment";
        displayName = CSTRING(ModuleWeather);
        function = QFUNC(moduleWeather);
        icon = "\a3\3DEN\Data\Displays\Display3DEN\ToolBar\intel_ca.paa";
    };
};
