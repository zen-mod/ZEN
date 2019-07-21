class EGVAR(attributes,RscAttributesBase);

class EGVAR(attributes,RscAttributesVehicle): EGVAR(attributes,RscAttributesBase) {
    class Buttons {
        class Garage {
            text = "$STR_A3_Garage";
            function = QFUNC(buttonGarage);
        };
    };
};

class EGVAR(attributes,RscAttributesVehicleEmpty): EGVAR(attributes,RscAttributesBase) {
    class Buttons {
        class Garage {
            text = "$STR_A3_Garage";
            function = QFUNC(buttonGarage);
        };
    };
};
