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
    class GVAR(moduleAttachTo): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(Objects);
        displayName = CSTRING(ModuleAttachTo);
        function = QFUNC(moduleAttachTo);
    };
    class GVAR(moduleChangeHeight): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(Objects);
        displayName = CSTRING(ModuleChangeHeight);
        function = QFUNC(moduleChangeHeight);
    };
    class GVAR(moduleCreateIED): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(Objects);
        displayName = CSTRING(CreateIED);
        function = QFUNC(moduleCreateIED);
    };
    class GVAR(moduleMakeInvincible): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(Objects);
        displayName = CSTRING(ModuleMakeInvincible);
        function = QFUNC(moduleMakeInvincible);
    };
    class GVAR(moduleSimulation): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(Objects);
        displayName = CSTRING(ModuleSimulation);
        function = QFUNC(moduleSimulation);
    };
    class GVAR(moduleVisibility): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(Objects);
        displayName = CSTRING(ModuleVisibility);
        function = QFUNC(moduleVisibility);
    };
    class GVAR(moduleChatter): GVAR(moduleBase) {
        curatorCanAttach = 1;
        displayName = CSTRING(ModuleChatter);
        curatorInfoType = QGVAR(RscChatter);
    };
    class GVAR(moduleCreateMinefield): GVAR(moduleBase) {
        displayName = CSTRING(ModuleCreateMinefield);
        curatorInfoType = QGVAR(RscCreateMinefield);
    };
    class GVAR(moduleGlobalHint): GVAR(moduleBase) {
        category = "Curator";
        displayName = CSTRING(ModuleGlobalHint);
        curatorInfoType = QGVAR(RscGlobalHint);
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
    class GVAR(modulePatrolArea): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(AI);
        displayName = CSTRING(ModulePatrolArea);
        curatorInfoType = QGVAR(RscPatrolArea);
    };
    class GVAR(moduleSideRelations): GVAR(moduleBase) {
        category = "MissionFlow";
        displayName = CSTRING(ModuleSideRelations);
        curatorInfoType = QGVAR(RscSideRelations);
    };
    class GVAR(moduleSmokePillar): GVAR(moduleBase) {
        category = "Effects";
        displayName = CSTRING(ModuleSmokePillar);
        function = QFUNC(moduleSmokePillar);
    };
    class GVAR(moduleTeleportPlayers): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(Players);
        displayName = CSTRING(ModuleTeleportPlayers);
        curatorInfoType = QGVAR(RscTeleportPlayers);
    };
    class GVAR(moduleBindVariable): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(DevTools);
        displayName = CSTRING(BindVariable);
        function = QFUNC(moduleBindVariable);
    };
    class GVAR(moduleFunctionsViewer): GVAR(moduleBase) {
        category = QGVAR(DevTools);
        displayName = "$STR_A3_RscFunctionsViewer_Caption";
        function = QFUNC(moduleFunctionsViewer);
        icon = "\a3\3DEN\Data\Displays\Display3DEN\EntityMenu\functions_ca.paa";
    };
    class GVAR(moduleShowInConfig): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(DevTools);
        displayName = CSTRING(ShowInConfig);
        function = QFUNC(moduleShowInConfig);
        icon = "\a3\3DEN\Data\Displays\Display3DEN\EntityMenu\findConfig_ca.paa";
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
        curatorInfoType = QGVAR(RscEarthquake);
    };
    class GVAR(moduleHeal): GVAR(moduleBase) {
        curatorCanAttach = 1;
        displayName = CSTRING(ModuleHeal);
        function = QFUNC(moduleHeal);
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
    class GVAR(moduleAttachEffect): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(Equipment);
        displayName = CSTRING(ModuleAttachEffect);
        curatorInfoType = QGVAR(RscAttachEffect);
    };
    class GVAR(moduleSetDate): GVAR(moduleBase) {
        category = "Environment";
        displayName = CSTRING(ModuleSetDate);
        curatorInfoType = QGVAR(RscSetDate);
    };
};
