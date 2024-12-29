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
                class ADDON {
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

    class EventHandlers {
        class ADDON {
            // Arguments are for debugging
            onMissionSave = QUOTE(['onMissionSave'] call FUNC(save3DENComments));
            onMissionAutosave = QUOTE(['onMissionAutosave'] call FUNC(save3DENComments));
            onBeforeMissionPreview = QUOTE(['onBeforeMissionPreview'] call FUNC(save3DENComments));
        };
    };
};
