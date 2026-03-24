class RscText;
class RscButtonMenuOK;
class RscButtonMenuCancel;
class RscControlsGroupNoScrollbars;
class ctrlButtonPictureKeepAspect;

class EGVAR(common,RscLabel);
class EGVAR(common,RscBackground);
class EGVAR(common,RscEdit);
class EGVAR(common,RscCombo);

class GVAR(display) {
    idd = -1;
    movingEnable = 1;
    onLoad = QUOTE(uiNamespace setVariable [ARR_2(QQGVAR(display),_this select 0)]);
    class controls {
        class Title: RscText {
            idc = IDC_DISPLAY_TITLE;
            x = QUOTE(POS_X(6.5));
            y = QUOTE(POS_Y(9.85));
            w = QUOTE(POS_W(27));
            h = QUOTE(POS_H(1));
            colorBackground[] = GUI_THEME_COLOR;
            moving = 1;
        };
        class Background: RscText {
            idc = -1;
            x = QUOTE(POS_X(6.5));
            y = QUOTE(POS_Y(10.95));
            w = QUOTE(POS_W(27));
            h = QUOTE(POS_H(3.1));
            colorBackground[] = {0, 0, 0, 0.7};
        };
        class CategoryLabel: EGVAR(common,RscLabel) {
            text = "$STR_3DEN_Display3DENEditComposition_CategoryLabel_text";
            x = QUOTE(POS_X(7));
            y = QUOTE(POS_Y(11.45));
            w = QUOTE(POS_W(10));
        };
        class CategoryEdit: EGVAR(common,RscEdit) {
            idc = IDC_DISPLAY_CATEGORY;
            x = QUOTE(POS_X(17.1));
            y = QUOTE(POS_Y(11.45));
            w = QUOTE(POS_W(14.8));
        };
        class CategoryList: EGVAR(common,RscCombo) {
            idc = IDC_DISPLAY_LIST;
            x = QUOTE(POS_X(31.9));
            y = QUOTE(POS_Y(11.45));
            w = QUOTE(POS_W(1));
            sizeEx = QUOTE(POS_H(0.9));
        };
        class NameLabel: CategoryLabel {
            text = "$STR_3DEN_Object_Attribute_UnitName_displayName";
            y = QUOTE(POS_Y(12.55));
        };
        class NameEdit: CategoryEdit {
            idc = IDC_DISPLAY_NAME;
            y = QUOTE(POS_Y(12.55));
            w = QUOTE(POS_W(15.9));
        };
        class ButtonOK: RscButtonMenuOK {
            x = QUOTE(POS_X(28.5));
            y = QUOTE(POS_Y(14.15));
            w = QUOTE(POS_W(5));
            h = QUOTE(POS_H(1));
        };
        class ButtonCancel: RscButtonMenuCancel {
            x = QUOTE(POS_X(6.5));
            y = QUOTE(POS_Y(14.15));
            w = QUOTE(POS_W(5));
            h = QUOTE(POS_H(1));
        };
    };
};

#include "RscDisplayCurator.hpp"
