class CfgVehicles {
    class Module_F;
    class EGVAR(modules,moduleBase);

    class ModuleRemoteControl_F: Module_F {
        scopeCurator = 1;
    };

    class GVAR(module): EGVAR(modules,moduleBase) {
        curatorCanAttach = 1;
        category = "Curator";
        displayName = "$STR_A3_CfgVehicles_ModuleRemoteControl_F";
        icon = "\a3\modules_f_curator\data\portraitremotecontrol_ca.paa";
        function = QFUNC(module);
    };
};
