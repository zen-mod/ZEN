class RscText;
class RscEdit;
class RscButton;
class RscCheckBox;
class RscActivePicture;
class RscStructuredText;
class RscButtonMenu;
class RscButtonMenuOK;
class RscButtonMenuCancel;
class RscControlsGroupNoScrollbars;

class ctrlToolbox;
class ctrlButtonPicture;
class ctrlControlsGroup;
class ctrlStaticPictureKeepAspect;

class RscCombo {
    class ComboScrollBar;
};

class RscListBox {
    class ListScrollBar;
};

class RscControlsGroup {
    class HScrollbar;
    class VScrollbar;
};

class GVAR(RscLabel): RscText {
    idc = -1;
    x = 0;
    y = 0;
    w = QUOTE(POS_W(10));
    h = QUOTE(POS_H(1));
    colorBackground[] = {0, 0, 0, 0.5};
};

class GVAR(RscBackground): RscText {
    idc = -1;
    style = ST_CENTER;
    x = QUOTE(POS_W(10));
    y = 0;
    w = QUOTE(POS_W(16));
    h = QUOTE(POS_H(2.5));
    colorText[] = {1, 1, 1, 0.5};
    colorBackground[] = COLOR_BACKGROUND_SETTING;
};

class GVAR(RscCheckbox): RscCheckBox {
    idc = -1;
    x = QUOTE(POS_W(10.1));
    y = 0;
    w = QUOTE(POS_W(1));
    h = QUOTE(POS_H(1));
    soundClick[] = {"\a3\ui_f\data\sound\rscbutton\soundclick.wss", 0.09, 1};
    soundEnter[] = {"\a3\ui_f\data\sound\rscbutton\soundenter.wss", 0.09, 1};
    soundEscape[] = {"\a3\ui_f\data\sound\rscbutton\soundescape.wss", 0.09, 1};
    soundPush[] = {"\a3\ui_f\data\sound\rscbutton\soundpush.wss", 0.09, 1};
};

class GVAR(RscCombo): RscCombo {
    idc = -1;
    x = QUOTE(POS_W(10.1));
    y = 0;
    w = QUOTE(POS_W(15.9));
    h = QUOTE(POS_H(1));
    arrowFull = "\a3\3DEN\Data\Controls\ctrlCombo\arrowFull_ca.paa";
    arrowEmpty = "\a3\3DEN\Data\Controls\ctrlCombo\arrowEmpty_ca.paa";
    class ComboScrollBar: ComboScrollBar {
        thumb = "\a3\3DEN\Data\Controls\ctrlDefault\thumb_ca.paa";
        border = "\a3\3DEN\Data\Controls\ctrlDefault\border_ca.paa";
        arrowFull = "\a3\3DEN\Data\Controls\ctrlDefault\arrowFull_ca.paa";
        arrowEmpty = "\a3\3DEN\Data\Controls\ctrlDefault\arrowEmpty_ca.paa";
    };
};

class GVAR(RscEdit): RscEdit {
    idc = -1;
    x = QUOTE(POS_W(10.1));
    y = QUOTE(pixelH);
    w = QUOTE(POS_W(15.9));
    h = QUOTE(POS_H(1) - pixelH);
    colorText[] = {1, 1, 1, 1};
    colorBackground[] = {0, 0, 0, 0.2};
};

class GVAR(RscListBox): RscListBox {
    idc = -1;
    x = 0;
    y = QUOTE(POS_H(1));
    w = QUOTE(POS_W(26));
    h = QUOTE(POS_H(6));
    class ListScrollBar: ListScrollBar {
        arrowEmpty = "\a3\3DEN\Data\Controls\ctrlDefault\arrowEmpty_ca.paa";
        arrowFull = "\a3\3DEN\Data\Controls\ctrlDefault\arrowFull_ca.paa";
        border = "\a3\3DEN\Data\Controls\ctrlDefault\border_ca.paa";
        thumb = "\a3\3DEN\Data\Controls\ctrlDefault\thumb_ca.paa";
    };
};

class GVAR(RscToolbox): ctrlToolbox {
    idc = -1;
    x = QUOTE(POS_W(10.1));
    y = 0;
    w = QUOTE(POS_W(15.9));
    h = QUOTE(POS_H(1));
    // Allows number of rows and columns to be set dynamically using parsingNamespace
    rows = QGVAR(rows);
    columns = QGVAR(columns);
};

class GVAR(RscControlsGroup): RscControlsGroup {
    idc = -1;
    class HScrollbar: HScrollbar {
        thumb = "\a3\3DEN\Data\Controls\ctrlDefault\thumb_ca.paa";
        border = "\a3\3DEN\Data\Controls\ctrlDefault\border_ca.paa";
        arrowFull = "\a3\3DEN\Data\Controls\ctrlDefault\arrowFull_ca.paa";
        arrowEmpty = "\a3\3DEN\Data\Controls\ctrlDefault\arrowEmpty_ca.paa";
    };
    class VScrollbar: VScrollbar {
        thumb = "\a3\3DEN\Data\Controls\ctrlDefault\thumb_ca.paa";
        border = "\a3\3DEN\Data\Controls\ctrlDefault\border_ca.paa";
        arrowFull = "\a3\3DEN\Data\Controls\ctrlDefault\arrowFull_ca.paa";
        arrowEmpty = "\a3\3DEN\Data\Controls\ctrlDefault\arrowEmpty_ca.paa";
        width = QUOTE(POS_W(0.5));
    };
};

class GVAR(RscSides): RscControlsGroupNoScrollbars {
    idc = -1;
    x = QUOTE(POS_W(10));
    y = 0;
    w = QUOTE(POS_W(16));
    h = QUOTE(POS_H(2.5));
    class controls {
        class BLUFOR: RscActivePicture {
            idc = IDC_SIDES_BLUFOR;
            text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_west_ca.paa";
            tooltip = "$STR_West";
            x = QUOTE(POS_W(2.5));
            y = QUOTE(POS_H(0.25));
            w = QUOTE(POS_W(2));
            h = QUOTE(POS_H(2));
        };
        class OPFOR: BLUFOR {
            idc = IDC_SIDES_OPFOR;
            text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_east_ca.paa";
            tooltip = "$STR_East";
            x = QUOTE(POS_W(5.5));
        };
        class Independent: BLUFOR {
            idc = IDC_SIDES_INDEPENDENT;
            text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_guer_ca.paa";
            tooltip = "$STR_Guerrila";
            x = QUOTE(POS_W(8.5));
        };
        class Civilian: BLUFOR {
            idc = IDC_SIDES_CIVILIAN;
            text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_civ_ca.paa";
            tooltip = "$STR_Civilian";
            x = QUOTE(POS_W(11.5));
        };
    };
};

class GVAR(RscOwners): RscControlsGroupNoScrollbars {
    idc = -1;
    x = 0;
    y = 0;
    w = QUOTE(POS_W(26));
    h = QUOTE(POS_H(10));
    class controls {
        class Background: GVAR(RscBackground) {
            x = 0;
            y = QUOTE(POS_H(1));
            w = QUOTE(POS_W(26));
            h = QUOTE(POS_H(9));
        };
        class ButtonSides: RscButton {
            idc = IDC_OWNERS_BTN_SIDES;
            style = ST_CENTER + ST_UPPERCASE;
            text = CSTRING(Sides);
            font = "RobotoCondensedLight";
            x = 0;
            y = 0;
            w = QUOTE(POS_W(26/3));
            h = QUOTE(POS_H(1));
            sizeEx = QUOTE(4.32 * (1 / (getResolution select 3)) * pixelGrid * 0.5);
            colorBackground[] = {0, 0, 0, 0.5};
            colorBackgroundActive[] = COLOR_SETTING(EGVAR(common,darkMode),1,1,1,0.15,0.1,0.1,0.1,0.2); // lighter
            colorBackgroundDisabled[] = COLOR_BACKGROUND_SETTING;
            colorDisabled[] = {1, 1, 1, 1};
            colorFocused[] = {1, 1, 1, 0.1};
            period = 0;
            periodOver = 0;
            periodFocus = 0;
            shadow = 1;
        };
        class ButtonGroups: ButtonSides {
            idc = IDC_OWNERS_BTN_GROUPS;
            text = "$STR_a3_rscdisplaycurator_modegroups_tooltip";
            x = QUOTE(POS_W(26/3));
        };
        class ButtonPlayers: ButtonSides {
            idc = IDC_OWNERS_BTN_PLAYERS;
            text = "$STR_mp_players";
            x = QUOTE(POS_W(52/3));
        };
        class TabSides: GVAR(RscSides) {
            idc = IDC_OWNERS_TAB_SIDES;
            x = 0;
            y = QUOTE(POS_H(1));
            w = QUOTE(POS_W(26));
            h = QUOTE(POS_H(9));
            class controls: controls {
                class BLUFOR: BLUFOR {
                    x = QUOTE(POS_W(4.25));
                    y = QUOTE(POS_H(3.25));
                    w = QUOTE(POS_W(2.5));
                    h = QUOTE(POS_H(2.5));
                };
                class OPFOR: OPFOR {
                    x = QUOTE(POS_W(9.25));
                    y = QUOTE(POS_H(3.25));
                    w = QUOTE(POS_W(2.5));
                    h = QUOTE(POS_H(2.5));
                };
                class Independent: Independent {
                    x = QUOTE(POS_W(14.25));
                    y = QUOTE(POS_H(3.25));
                    w = QUOTE(POS_W(2.5));
                    h = QUOTE(POS_H(2.5));
                };
                class Civilian: Civilian {
                    x = QUOTE(POS_W(19.25));
                    y = QUOTE(POS_H(3.25));
                    w = QUOTE(POS_W(2.5));
                    h = QUOTE(POS_H(2.5));
                };
            };
        };
        class TabGroups: RscControlsGroupNoScrollbars {
            idc = IDC_OWNERS_TAB_GROUPS;
            x = 0;
            y = QUOTE(POS_H(1));
            w = QUOTE(POS_W(26));
            h = QUOTE(POS_H(9));
            class controls {
                class List: GVAR(RscListBox) {
                    idc = IDC_OWNERS_GROUPS_LIST;
                    x = QUOTE(POS_W(0.5));
                    y = QUOTE(POS_H(0.5));
                    w = QUOTE(POS_W(25));
                    h = QUOTE(POS_H(6.8));
                    colorSelect[] = {1, 1, 1, 1};
                    colorSelect2[] = {1, 1, 1, 1};
                    colorBackground[] = {0, 0, 0, 0.3};
                    colorSelectBackground[] = {0, 0, 0, 0};
                    colorSelectBackground2[] = {0, 0, 0, 0};
                };
                class ButtonSearch: ctrlButtonPicture {
                    idc = IDC_OWNERS_GROUPS_SEARCH_BTN;
                    text = "\a3\Ui_f\data\GUI\RscCommon\RscButtonSearch\search_start_ca.paa";
                    x = QUOTE(POS_W(0.5));
                    y = QUOTE(POS_H(7.5));
                    w = QUOTE(POS_W(1));
                    h = QUOTE(POS_H(1));
                    colorBackground[] = {0, 0, 0, 0.5};
                    offsetPressedX = 0;
                    offsetPressedY = 0;
                };
                class SearchBar: GVAR(RscEdit) {
                    idc = IDC_OWNERS_GROUPS_SEARCH_BAR;
                    x = QUOTE(POS_W(1.6));
                    y = QUOTE(POS_H(7.5));
                    w = QUOTE(POS_W(10));
                    h = QUOTE(POS_H(1));
                    sizeEx = QUOTE(POS_H(0.9));
                    colorBackground[] = {0, 0, 0, 0.3};
                };
                class ButtonUncheck: ButtonSearch {
                    idc = IDC_OWNERS_GROUPS_UNCHECK;
                    text = QPATHTOF(ui\uncheck_all_ca.paa);
                    tooltip = CSTRING(UncheckAll);
                    x = QUOTE(POS_W(23.4));
                };
                class ButtonCheck: ButtonSearch {
                    idc = IDC_OWNERS_GROUPS_CHECK;
                    text = QPATHTOF(ui\check_all_ca.paa);
                    tooltip = CSTRING(CheckAll);
                    x = QUOTE(POS_W(24.5));
                };
            };
        };
        class TabPlayers: TabGroups {
            idc = IDC_OWNERS_TAB_PLAYERS;
            class controls: controls {
                class List: List {
                    idc = IDC_OWNERS_PLAYERS_LIST;
                };
                class SearchBar: SearchBar {
                    idc = IDC_OWNERS_PLAYERS_SEARCH_BAR;
                };
                class ButtonSearch: ButtonSearch {
                    idc = IDC_OWNERS_PLAYERS_SEARCH_BTN;
                };
                class ButtonUncheck: ButtonUncheck {
                    idc = IDC_OWNERS_PLAYERS_UNCHECK;
                };
                class ButtonCheck: ButtonCheck {
                    idc = IDC_OWNERS_PLAYERS_CHECK;
                };
            };
        };
    };
};

class GVAR(RscDisplay) {
    idd = -1;
    movingEnable = 1;
    onLoad = QUOTE(uiNamespace setVariable [ARR_2(QQGVAR(display),_this select 0)]);
    class controls {
        class Title: RscText {
            idc = IDC_TITLE;
            // Store the display's config, onLoad event for displays is not passed the config
            #pragma hemtt suppress pw3_padded_arg
            onLoad = QUOTE(\
                params [ARR_2('_control','_config')];\
                private _display = ctrlParent _control;\
                _config = configHierarchy _config select 1;\
                _display setVariable [ARR_2(QQGVAR(config),_config)];\
            );
            x = QUOTE(POS_X(6.5));
            w = QUOTE(POS_W(27));
            h = QUOTE(POS_H(1));
            colorBackground[] = GUI_THEME_COLOR;
            moving = 1;
        };
        class Background: RscText {
            idc = IDC_BACKGROUND;
            x = QUOTE(POS_X(6.5));
            w = QUOTE(POS_W(27));
            colorBackground[] = {0, 0, 0, 0.7};
        };
        class Content: RscControlsGroupNoScrollbars {
            idc = IDC_CONTENT;
            x = QUOTE(POS_X(7));
            w = QUOTE(POS_W(26));
        };
        class ButtonOK: RscButtonMenuOK {
            x = QUOTE(POS_X(28.5));
            w = QUOTE(POS_W(5));
            h = QUOTE(POS_H(1));
        };
        class ButtonCancel: RscButtonMenuCancel {
            x = QUOTE(POS_X(6.5));
            w = QUOTE(POS_W(5));
            h = QUOTE(POS_H(1));
        };
    };
};

class GVAR(RscDisplayScrollbars): GVAR(RscDisplay) {
    class controls: controls {
        class Title: Title {};
        class Background: Background {};
        class Content: GVAR(RscControlsGroup) {
            idc = IDC_CONTENT;
            x = QUOTE(POS_X(7));
            w = QUOTE(POS_W(26));
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};

class GVAR(messageBox) {
    idd = -1;
    movingEnable = 1;
    onLoad = QUOTE(uiNamespace setVariable [ARR_2(QQGVAR(messageBox),_this select 0)]);
    class controls {
        class Title: RscText {
            idc = IDC_MESSAGE_TITLE;
            x = QUOTE(POS_X(12.5));
            y = QUOTE(POS_Y(7.5));
            w = QUOTE(POS_W(15));
            h = QUOTE(POS_H(1));
            colorBackground[] = GUI_THEME_COLOR;
            moving = 1;
        };
        class Background: RscText {
            idc = IDC_MESSAGE_BACKGROUND;
            x = QUOTE(POS_X(12.5));
            y = QUOTE(POS_Y(8.6));
            w = QUOTE(POS_W(15));
            h = QUOTE(POS_H(3.2));
            colorBackground[] = {0, 0, 0, 0.7};
        };
        class Picture: ctrlStaticPictureKeepAspect {
            idc = IDC_MESSAGE_PICTURE;
            x = QUOTE(POS_X(13));
            y = QUOTE(POS_Y(9));
            w = QUOTE(POS_W(2));
            h = QUOTE(POS_H(2));
        };
        class Text: RscStructuredText {
            idc = IDC_MESSAGE_TEXT;
            x = QUOTE(POS_X(15.5));
            y = QUOTE(POS_Y(9));
            w = QUOTE(POS_W(11.5));
            h = QUOTE(POS_H(5));
        };
        class ButtonOK: RscButtonMenuOK {
            x = QUOTE(POS_X(22.5));
            y = QUOTE(POS_Y(10));
            w = QUOTE(POS_W(5));
            h = QUOTE(POS_H(1));
        };
        class ButtonCancel: RscButtonMenuCancel {
            x = QUOTE(POS_X(12.5));
            y = QUOTE(POS_Y(10));
            w = QUOTE(POS_W(5));
            h = QUOTE(POS_H(1));
        };
    };
};

class GVAR(export) {
    idd = -1;
    movingEnable = 1;
    onLoad = QUOTE(uiNamespace setVariable [ARR_2(QQGVAR(export),_this select 0)]);
    class controls {
        class Title: RscText {
            idc = IDC_EXPORT_TITLE;
            x = QUOTE(POS_X(5));
            y = QUOTE(POS_Y(0));
            w = QUOTE(POS_W(30));
            h = QUOTE(POS_H(1));
            colorBackground[] = GUI_THEME_COLOR;
            moving = 1;
        };
        class Background: RscText {
            idc = -1;
            x = QUOTE(POS_X(5));
            y = QUOTE(POS_Y(1.1));
            w = QUOTE(POS_W(30));
            h = QUOTE(POS_H(22.8));
            colorBackground[] = {0, 0, 0, 0.7};
        };
        class Group: ctrlControlsGroup {
            idc = IDC_EXPORT_GROUP;
            x = QUOTE(POS_X(5.5));
            y = QUOTE(POS_Y(1.6));
            w = QUOTE(POS_W(29));
            h = QUOTE(POS_H(21.8));
            class controls {
                class Edit: RscEdit {
                    idc = IDC_EXPORT_EDIT;
                    style = ST_MULTI + ST_NO_RECT;
                    x = 0;
                    y = 0;
                    w = QUOTE(POS_W(29));
                    h = QUOTE(POS_H(21.8));
                    sizeEx = QUOTE(POS_H(0.8));
                    colorBackground[] = COLOR_BACKGROUND_SETTING;
                };
            };
        };
        class ButtonClose: RscButtonMenu {
            idc = IDC_EXPORT_CLOSE;
            text = "$STR_Disp_Close";
            x = QUOTE(POS_X(5));
            y = QUOTE(POS_Y(24));
            w = QUOTE(POS_W(10));
            h = QUOTE(POS_H(1));
        };
        class ButtonCopy: ButtonClose {
            idc = IDC_EXPORT_COPY;
            text = CSTRING(CopyToClipboard);
            x = QUOTE(POS_X(15.1));
        };
    };
};
