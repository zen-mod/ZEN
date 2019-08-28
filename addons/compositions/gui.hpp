class RscText;
class RscButtonMenuOK;
class RscButtonMenuCancel;
class RscControlsGroupNoScrollbars;
class ctrlButtonPictureKeepAspect;

class EGVAR(attributes,RscLabel);
class EGVAR(attributes,RscBackground);
class EGVAR(attributes,RscEdit);
class EGVAR(attributes,RscCombo);

class GVAR(display) {
    idd = -1;
    enableMoving = 1;
    onLoad = QUOTE(with uiNamespace do {GVAR(display) = _this select 0});
    class controls {
        class Title: RscText {
            idc = IDC_DISPLAY_TITLE;
            x = POS_X(10);
            y = POS_Y(9.85);
            w = POS_W(20);
            h = POS_H(1);
            colorBackground[] = GUI_THEME_COLOR;
            moving = 1;
        };
        class Background: RscText {
            idc = -1;
            x = POS_X(10);
            y = POS_Y(10.95);
            w = POS_W(20);
            h = POS_H(3.1);
            colorBackground[] = {0, 0, 0, 0.7};
        };
        class CategoryLabel: EGVAR(attributes,RscLabel) {
            text = "$STR_3DEN_Display3DENEditComposition_CategoryLabel_text";
            x = POS_X(10.5);
            y = POS_Y(11.45);
            w = POS_W(5.7);
        };
        class CategoryEdit: EGVAR(attributes,RscEdit) {
            idc = IDC_DISPLAY_CATEGORY;
            x = POS_X(16.3);
            y = POS_Y(11.45);
            w = POS_W(12.1);
        };
        class CategoryList: EGVAR(attributes,RscCombo) {
            idc = IDC_DISPLAY_LIST;
            x = POS_X(28.5);
            y = POS_Y(11.45);
            w = POS_W(1);
        };
        class NameLabel: CategoryLabel {
            text = "$STR_3DEN_Object_Attribute_UnitName_displayName";
            y = POS_Y(12.55);
        };
        class NameEdit: CategoryEdit {
            idc = IDC_DISPLAY_NAME;
            y = POS_Y(12.55);
            w = POS_W(13.2);
        };
        class ButtonOK: RscButtonMenuOK {
            x = POS_X(25) + pixelW;
            y = POS_Y(14.15);
            w = POS_W(5);
            h = POS_H(1);
        };
        class ButtonCancel: RscButtonMenuCancel {
            x = POS_X(10);
            y = POS_Y(14.15);
            w = POS_W(5);
            h = POS_H(1);
        };
    };
};

#include "RscDisplayCurator.hpp"
