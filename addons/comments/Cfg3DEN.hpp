class Cfg3DEN {
    class Attributes {
        class Default;
        class GVAR(hiddenAttribute): Default {
            onLoad = QUOTE((ctrlParentControlsGroup ctrlParentControlsGroup (_this select 0)) ctrlShow false);
        };
    };

    class Mission {
        class Scenario {
            class AttributeCategories {
                class ADDON {
                    displayName = CSTRING(DisplayName);
                    collapsed = 1;
                    class Attributes {
                        class GVAR(3DENComments) {
                            displayName = CSTRING(DisplayName);
                            property = QGVAR(3DENComments);
                            control = QGVAR(hiddenAttribute);
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
