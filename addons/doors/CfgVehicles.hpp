class CfgVehicles {
    class EGVAR(modules,moduleBase);

    class GVAR(module): EGVAR(modules,moduleBase) {
        curatorCanAttach = 1;
        category = QEGVAR(modules,Buildings);
        displayName = CSTRING(Configure);
        icon = ICON_DOOR;
        function = QFUNC(module);
    };
};
