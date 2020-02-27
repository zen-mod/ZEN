class ctrlButton;
class ctrlListNBox;
class ctrlProgress;
class ctrlButtonPicture;
class ctrlToolboxPictureKeepAspect;
class RscControlsGroupNoScrollbars;
class RscCombo {
    class ComboScrollBar;
};

class EGVAR(attributes,RscLabel);
class EGVAR(attributes,RscBackground);
class EGVAR(attributes,RscEdit);
class EGVAR(attributes,RscCombo);

class EGVAR(common,RscDisplay) {
    class controls {
        class Title;
        class Background;
        class Content;
        class ButtonOK;
        class ButtonCancel;
    };
};

class GVAR(display): EGVAR(common,RscDisplay) {
    // onLoad = QUOTE([ARR_2(_this select 0, QQEGVAR(attributes,RscAttributesLoadout))] call EFUNC(attributes,initAttributesDisplay));
    // filterAttributes = 1;
    class controls: controls {
        class Title: Title {};
        class Background: Background {};
        class Content: Content {
            class controls {
                class Magazines: RscControlsGroupNoScrollbars {
                    idc = IDC_MAGAZINES;
                    function = QFUNC(init);
                    x = 0;
                    y = 0;
                    w = POS_W(26);
                    h = POS_H(19);
                    class controls {
                        class Weapon: EGVAR(common,RscCombo) {
                            idc = IDC_WEAPON;
                            x = 0;
                            y = 0;
                            w = POS_W(26);
                            h = POS_H(1);
                        };
                        class ListBackground: EGVAR(common,RscBackground) {
                            x = 0;
                            y = POS_H(1);
                            w = POS_W(26);
                            h = POS_H(16.6);
                        };
                        class List: ctrlListNBox {
                            idc = IDC_LIST;
                            idcLeft = IDC_BTN_REMOVE;
                            idcRight = IDC_BTN_ADD;
                            x = 0;
                            y = POS_H(1);
                            w = POS_W(26);
                            h = POS_H(16.6);
                            drawSideArrows = 1;
                            disableOverflow = 1;
                            columns[] = {0.05, 0.85};
                        };
                        class ButtonRemove: ctrlButton {
                            idc = IDC_BTN_REMOVE;
                            text = "−";
                            font = "RobotoCondensedBold";
                            x = -1;
                            y = -1;
                            w = POS_W(1);
                            h = POS_H(1);
                            sizeEx = POS_H(1.2);
                        };
                        class ButtonAdd: ButtonRemove {
                            idc = IDC_BTN_ADD;
                            text = "+";
                        };
                        class ButtonSearch: ctrlButtonPicture {
                            idc = IDC_BTN_SEARCH;
                            text = "\a3\Ui_f\data\GUI\RscCommon\RscButtonSearch\search_start_ca.paa";
                            x = 0;
                            y = POS_H(18);
                            w = POS_W(1);
                            h = POS_H(1);
                            colorBackground[] = {0, 0, 0, 0.5};
                            offsetPressedX = 0;
                            offsetPressedY = 0;
                        };
                        class SearchBar: EGVAR(common,RscEdit) {
                            idc = IDC_SEARCH_BAR;
                            x = POS_W(1.2);
                            y = POS_H(18);
                            w = POS_W(8);
                            h = POS_H(1);
                            sizeEx = POS_H(0.9);
                        };
                        class ButtonClear: ButtonSearch {
                            idc = IDC_BTN_CLEAR;
                            text = QPATHTOF(ui\clear_ca.paa);
                            tooltip = "$STR_disp_arcmap_clear";
                            x = POS_W(25);
                            y = POS_H(18);
                        };
                    };
                };
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};
