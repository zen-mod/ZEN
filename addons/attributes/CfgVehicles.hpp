class CfgVehicles {
    class All;
    class AllVehicles: All {
        curatorInfoType = QGVAR(RscAttributesVehicle);
        curatorInfoTypeEmpty = QGVAR(RscAttributesVehicleEmpty);
    };

    class Man;
    class CAManBase: Man {
        curatorInfoType = QGVAR(RscAttributesMan);
        curatorInfoTypeEmpty = QGVAR(RscAttributesMan);
    };
};
