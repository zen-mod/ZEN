class CfgVehicles {
    class EGVAR(modules,moduleBase);

    class GVAR(moduleSpectrumInit): EGVAR(modules,moduleBase) {
        category = QEGVAR(modules,Equipment);
        displayName = "Spectrum Device - Init";
        function = QFUNC(moduleSpectrumInit);
    };
};
