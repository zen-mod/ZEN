class CfgVehicles {
    class Module_F;
    class ModuleObjective_F: Module_F {
        scopeCurator = 1;
    };

    class ModuleObjectiveMove_F: ModuleObjective_F {
        scopeCurator = 2;
    };

    class ModuleObjectiveSector_F: ModuleObjective_F {
        scopeCurator = 2;
    };

    class ModuleObjectiveAttackDefend_F: ModuleObjective_F {
        scopeCurator = 2;
    };

    class ModuleObjectiveNeutralize_F: ModuleObjective_F {
        scopeCurator = 2;
    };

    class ModuleObjectiveProtect_F: ModuleObjective_F {
        scopeCurator = 2;
    };

    class ModuleObjectiveGetIn_F: ModuleObjective_F {
        scopeCurator = 2;
    };

    class ModuleObjectiveRaceStart_F: ModuleObjective_F {
        scopeCurator = 2;
    };

    class ModuleObjectiveRaceCP_F: ModuleObjective_F {
        scopeCurator = 2;
    };

    class ModuleObjectiveRaceFinish_F: ModuleObjective_F {
        scopeCurator = 2;
    };

    class EGVAR(modules,moduleBase);
    class GVAR(module): EGVAR(modules,moduleBase) {
        curatorCanAttach = 1;
        category = "Objectives";
        displayName = "$STR_A3_CfgVehicles_ModuleObjective_F";
        curatorInfoType = QGVAR(RscTasks);
        icon = "\a3\modules_f_curator\data\portraitobjective_ca.paa";
        portrait = "\a3\modules_f_curator\data\portraitobjective_ca.paa";
    };
};
