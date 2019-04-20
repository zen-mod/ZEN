class EGVAR(context_menu,actions) {
    class RemoteControl {
        displayName = "$STR_A3_CfgVehicles_ModuleRemoteControl_F";
        icon = "\a3\modules_f_curator\data\portraitremotecontrol_ca.paa";
        condition = QUOTE(_hoveredEntity call FUNC(canControl));
        statement = QUOTE(_hoveredEntity call FUNC(start));
        priority = -90;
    };
};
