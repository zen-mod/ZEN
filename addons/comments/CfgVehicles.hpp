class CfgVehicles {
    class EGVAR(modules,moduleBase);
    class GVAR(module): EGVAR(modules,moduleBase) {
        curatorCanAttach = 1;
        category = "Curator";
        displayName = STR_CREATE_COMMENT;
        function = QFUNC(module);
        icon = COMMENT_ICON;
    };
};
