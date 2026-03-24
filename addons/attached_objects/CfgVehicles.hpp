class CfgVehicles {
    class EGVAR(modules,moduleBase);
    class GVAR(module): EGVAR(modules,moduleBase) {
        curatorCanAttach = 1;
        category = QEGVAR(modules,Objects);
        displayName = CSTRING(AttachTo);
        function = QFUNC(module);
    };
};
