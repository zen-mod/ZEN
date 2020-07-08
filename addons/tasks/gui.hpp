class ctrlCombo;
class ctrlToolbox;
class ctrlToolboxPictureKeepAspect;

class EGVAR(common,RscLabel);
class EGVAR(common,RscEdit);
class EGVAR(common,RscOwners);

class EGVAR(common,RscDisplay) {
    class controls;
};

class EGVAR(modules,RscDisplay): EGVAR(common,RscDisplay) {
    class controls: controls {
        class Title;
        class Background;
        class Content;
        class ButtonOK;
        class ButtonCancel;
    };
};

class GVAR(RscTasks): EGVAR(modules,RscDisplay) {
    function = QFUNC(init);
    checkLogic = 1;
    class controls: controls {
        class Title: Title {};
        class Background: Background {};
        class Content: Content {
            h = POS_H(24.8);
            class controls {
                class OwnersLabel: EGVAR(common,RscLabel) {
                    text = "$STR_A3_RscAttributeOwners_Title";
                    w = POS_W(26);
                };
                class Owners: EGVAR(common,RscOwners) {
                    idc = IDC_TASK_OWNERS;
                    y = POS_H(1);
                };
                class StateLabel: EGVAR(common,RscLabel) {
                    text = "$STR_A3_RscAttributeTaskState_Title";
                    y = POS_H(11.1);
                    h = POS_H(2);
                };
                class State: ctrlToolboxPictureKeepAspect {
                    idc = IDC_TASK_STATE;
                    x = POS_W(10.1);
                    y = POS_H(11.1);
                    w = POS_W(15.9);
                    h = POS_H(2);
                    rows = 1;
                    columns = 5;
                    strings[] = {
                        "\a3\3DEN\Data\Attributes\TaskStates\created_ca.paa",
                        "\a3\3DEN\Data\Attributes\TaskStates\assigned_ca.paa",
                        "\a3\3DEN\Data\Attributes\TaskStates\succeeded_ca.paa",
                        "\a3\3DEN\Data\Attributes\TaskStates\failed_ca.paa",
                        "\a3\3DEN\Data\Attributes\TaskStates\canceled_ca.paa"
                    };
                    tooltips[] = {
                        "$STR_A3_CfgVehicles_ModuleTaskSetState_F_Arguments_State_Values_Created_0",
                        "$STR_A3_CfgVehicles_ModuleTaskSetState_F_Arguments_State_Values_Assigned_0",
                        "$STR_A3_CfgVehicles_ModuleTaskSetState_F_Arguments_State_Values_Succeeded_0",
                        "$STR_A3_CfgVehicles_ModuleTaskSetState_F_Arguments_State_Values_Failed_0",
                        "$STR_A3_CfgVehicles_ModuleTaskSetState_F_Arguments_State_Values_Canceled_0"
                    };
                };
                class DestinationLabel: EGVAR(common,RscLabel) {
                    text = "$STR_A3_CfgVehicles_ModuleTaskSetDestination_F_Arguments_Destination_0";
                    y = POS_H(13.2);
                };
                class Destination: ctrlToolbox {
                    idc = IDC_TASK_DESTINATION;
                    x = POS_W(10.1);
                    y = POS_H(13.2);
                    w = POS_W(15.9);
                    h = POS_H(1);
                    rows = 1;
                    columns = 2;
                    strings[] = {ECSTRING(common,Disabled), CSTRING(ModulePosition)};
                    tooltips[] = {CSTRING(DestinationDisabled_Tooltip), CSTRING(ModulePosition_Tooltip)};
                };
                class TypeLabel: EGVAR(common,RscLabel) {
                    text = "$STR_A3_cfgvehicles_moduletaskcreate_f_arguments_type_0";
                    tooltip = CSTRING(Type_Tooltip);
                    y = POS_H(14.3);
                };
                class Type: ctrlCombo {
                    idc = IDC_TASK_TYPE;
                    x = POS_W(10.1);
                    y = POS_H(14.3);
                    w = POS_W(15.9);
                    h = POS_H(1);
                };
                class TitleDescriptionLabel: EGVAR(common,RscLabel) {
                    text = CSTRING(TitleDescription);
                    tooltip = CSTRING(TitleDescription_Tooltip);
                    y = POS_H(15.4);
                };
                class History: Type {
                    idc = IDC_TASK_HISTORY;
                    y = POS_H(15.4);
                };
                class Title: EGVAR(common,RscEdit) {
                    idc = IDC_TASK_TITLE;
                    x = pixelW;
                    y = POS_H(16.5);
                    w = POS_W(26) - pixelW;
                };
                class Description: EGVAR(common,RscEdit) {
                    idc = IDC_TASK_DESCRIPTION;
                    style = ST_MULTI;
                    x = pixelW;
                    y = POS_H(17.6);
                    w = POS_W(26) - pixelW;
                    h = POS_H(7.2);
                    sizeEx = POS_H(0.9);
                };
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};
