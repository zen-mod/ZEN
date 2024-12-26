class Cfg3DEN {
    class Attributes {
        class Default;
        class GVAR(HiddenAttribute): Default {
            onLoad = QUOTE((ctrlParentControlsGroup ctrlParentControlsGroup (_this select 0)) ctrlShow false);
        };
    };

    class Mission {
        class Scenario {
            class AttributeCategories {
                class PREFIX {
                    collapsed = 1;
                    displayName = ECSTRING(main,DisplayName);

                    class Attributes {
                        class GVAR(3DENComments) {
                            property = QGVAR(3DENComments);
                            value = 0;
                            control = QGVAR(HiddenAttribute);
                            displayName = CSTRING(DisplayName);
                            tooltip = "";
                            defaultValue = "[]";
                            expression = "";
                            wikiType = "[[Array]]";
                        };
                    };
                };
            };
        };
    };
};
