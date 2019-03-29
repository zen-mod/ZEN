class CfgVehicles {
    class EGVAR(modules,moduleBase);

    class GVAR(module): EGVAR(modules,moduleBase) {
        curatorCanAttach = 1;
        category = QEGVAR(modules,Buildings);
        displayName = CSTRING(Configure);
        icon = "\a3\modules_f\data\editterrainobject\texturedoor_opened_ca.paa";
        function = QFUNC(module);
    };
};
