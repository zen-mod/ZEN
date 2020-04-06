class RscDisplayCurator {
    class Controls {
        class Add: RscControlsGroupNoScrollbars {
            class controls {
                class CreateUnitsWest;
                class CreateGroupsEmpty: CreateUnitsWest {
                    h = safeZoneH - POS_EDGE(9.3,8.3) * GUI_GRID_H;
                };
                class GVAR(panel): RscControlsGroupNoScrollbars {
                    idc = IDC_PANEL_GROUP;
                    x = 0;
                    y = safeZoneH - POS_EDGE(4.2,3.2) * GUI_GRID_H;
                    w = POS_W(11);
                    h = POS_H(1.2);
                    class controls {
                        class Create: ctrlButtonPictureKeepAspect {
                            idc = IDC_PANEL_CREATE;
                            onButtonClick = QUOTE(call FUNC(buttonCreate));
                            x = POS_W(0.2);
                            y = POS_H(0.05);
                            w = POS_W(1);
                            h = POS_H(1);
                            text = "\a3\3DEN\Data\Displays\Display3DEN\PanelRight\customcomposition_add_ca.paa";
                            tooltip = "$STR_3DEN_Display3DEN_CustomCompositionPanel_Add_tooltip";
                            colorFocused[] = {0, 0, 0, 0};
                            colorBackground[] = {0, 0, 0, 0};
                            colorBackgroundActive[] = {0, 0, 0, 0};
                            colorBackgroundDisabled[] = {0, 0, 0, 0};
                        };
                        class Edit: Create {
                            idc = IDC_PANEL_EDIT;
                            onLoad = QUOTE((_this select 0) ctrlEnable false);
                            onButtonClick = QUOTE(call FUNC(buttonEdit));
                            x = POS_W(1.3);
                            text = "\a3\3DEN\Data\Displays\Display3DEN\PanelRight\customcomposition_edit_ca.paa";
                            tooltip = "$STR_3DEN_Display3DEN_CustomCompositionPanel_Edit_tooltip";
                        };
                        class Delete: Edit {
                            idc = IDC_PANEL_DELETE;
                            onButtonClick = QUOTE(call FUNC(buttonDelete));
                            x = POS_W(9.8);
                            text = "\a3\3DEN\Data\Displays\Display3DEN\PanelLeft\entityList_delete_ca.paa";
                            tooltip = "$STR_3DEN_Display3DEN_CustomCompositionPanel_Delete_tooltip";
                        };
                    };
                };
            };
        };
    };
};
