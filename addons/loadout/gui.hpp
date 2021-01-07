class ctrlButton;
class ctrlListNBox;
class ctrlButtonPicture;

class EGVAR(common,RscBackground);
class EGVAR(common,RscEdit);
class EGVAR(common,RscCombo);

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
    class controls: controls {
        class Title: Title {};
        class Background: Background {};
        class Content: Content {
            h = POS_H(18.9);
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
                    columns[] = {0.05, 0.55, 0.85};
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
                    y = POS_H(17.9);
                    w = POS_W(1);
                    h = POS_H(1);
                    colorBackground[] = {0, 0, 0, 0.5};
                    offsetPressedX = 0;
                    offsetPressedY = 0;
                };
                class SearchBar: EGVAR(common,RscEdit) {
                    idc = IDC_SEARCH_BAR;
                    x = POS_W(1.2);
                    y = POS_H(17.9);
                    w = POS_W(8);
                    h = POS_H(1);
                    sizeEx = POS_H(0.9);
                };
                class ButtonClear: ButtonSearch {
                    idc = IDC_BTN_CLEAR;
                    text = "\a3\3den\data\cfg3den\history\deleteitems_ca.paa";
                    tooltip = "$STR_disp_arcmap_clear";
                    x = POS_W(25);
                };
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};
