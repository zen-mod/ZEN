class CfgVehicles {
    class EGVAR(modules,moduleBase);
    class GVAR(module): EGVAR(modules,moduleBase) {
        curatorCanAttach = 1;
        displayName = CSTRING(CreateAreaMarker);
        function = QFUNC(module);
        icon = ICON_MARKERS;
    };
};
