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
    class GVAR(moduleHideZeus): GVAR(moduleBase) {
        category = "Curator";
        displayName = CSTRING(ModuleHideZeus);
        curatorInfoType = QGVAR(RscHideZeus);
    };
    class GVAR(moduleSideRelations): GVAR(moduleBase) {
        category = "MissionFlow";
        displayName = CSTRING(ModuleSideRelations);
        curatorInfoType = QGVAR(RscSideRelations);
    };
    class GVAR(moduleTeleportPlayers): GVAR(moduleBase) {
        curatorCanAttach = 1;
        category = QGVAR(Players);
        displayName = CSTRING(ModuleTeleportPlayers);
        curatorInfoType = QGVAR(RscTeleportPlayers);
    };
};
