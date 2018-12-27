class CfgVehicles {
    class Module_F;
    class GVAR(moduleBase): Module_F {
        author = "";
        category = "NO_CATEGORY";
        // function = "";
        functionPriority = 1;
        isGlobal = 1;
        isTriggerActivated = 0;
        scope = 1;
        scopeCurator = 2;
    };
    class GVAR(moduleAttachTo): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(Objects);
        displayName = CSTRING(ModuleAttachTo);
        function = QFUNC(moduleAttachTo);
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
        curatorInfoType = QGVAR(RscHideZeus);
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
        curatorInfoType = QGVAR(RscSmokePillar);
    };
    class GVAR(moduleTeleportPlayers): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(Players);
        displayName = CSTRING(ModuleTeleportPlayers);
        curatorInfoType = QGVAR(RscTeleportPlayers);
    };
};
