class CfgVehicles {
    class ModuleEmpty_F;
    class ModuleMine_F: ModuleEmpty_F {
        function = QEFUNC(modules,bi_moduleMine);
    };

    // Hide ACE Zeus modules for which replacements exist
    class ACEGVAR(zeus,moduleBase);

    class ACEGVAR(zeus,moduleEditableObjects): ACEGVAR(zeus,moduleBase) {
        scopeCurator = 1;
    };

    class ACEGVAR(zeus,moduleGroupSide): ACEGVAR(zeus,moduleBase) {
        scopeCurator = 1;
    };

    class ACEGVAR(zeus,modulePatrolArea): ACEGVAR(zeus,moduleBase) {
        scopeCurator = 1;
    };

    class ACEGVAR(zeus,moduleSimulation): ACEGVAR(zeus,moduleBase) {
        scopeCurator = 1;
    };

    class ACEGVAR(zeus,moduleSuicideBomber): ACEGVAR(zeus,moduleBase) {
        scopeCurator = 1;
    };

    class ACEGVAR(zeus,moduleTeleportPlayers): ACEGVAR(zeus,moduleBase) {
        scopeCurator = 1;
    };

    class ACEGVAR(zeus,moduleToggleFlashlight): ACEGVAR(zeus,moduleBase) {
        scopeCurator = 1;
    };

    class ACEGVAR(zeus,AddFullArsenal): ACEGVAR(zeus,moduleBase) {
        scopeCurator = 1;
    };

    class ACEGVAR(zeus,RemoveFullArsenal): ACEGVAR(zeus,moduleBase) {
        scopeCurator = 1;
    };

    class ACEGVAR(zeus,AddFullAceArsenal): ACEGVAR(zeus,moduleBase) {
        scopeCurator = 1;
    };

    class ACEGVAR(zeus,RemoveFullAceArsenal): ACEGVAR(zeus,moduleBase) {
        scopeCurator = 1;
    };
};
