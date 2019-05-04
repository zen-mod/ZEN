class CfgVehicles {
    class EGVAR(modules,moduleBase);

    class GVAR(module): EGVAR(modules,moduleBase) {
        curatorCanAttach = 1;
        category = QEGVAR(modules,Buildings);
        displayName = CSTRING(Configure);
        icon = "\a3\ui_f\data\igui\cfg\actions\open_door_ca.paa";
        function = QFUNC(module);
    };
};
