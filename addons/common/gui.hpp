class RscText;
class RscStructuredText;
class RscButtonMenuOK;
class RscButtonMenuCancel;
class ctrlStaticPictureKeepAspect;

class GVAR(messageBox) {
    idd = -1;
    movingEnable = 1;
    onLoad = QUOTE(with uiNamespace do {GVAR(messageBox) = _this select 0});
    class controls {
        class Title: RscText {
            idc = IDC_MESSAGE_TITLE;
            x = POS_X(12.5);
            y = POS_Y(7.5);
            w = POS_W(15);
            h = POS_H(1);
            colorBackground[] = GUI_THEME_COLOR;
            moving = 1;
        };
        class Background: RscText {
            idc = IDC_MESSAGE_BACKGROUND;
            x = POS_X(12.5);
            y = POS_Y(8.6);
            w = POS_W(15);
            h = POS_H(3.2);
            colorBackground[] = {0, 0, 0, 0.7};
        };
        class Picture: ctrlStaticPictureKeepAspect {
            idc = IDC_MESSAGE_PICTURE;
            x = POS_X(13);
            y = POS_Y(9);
            w = POS_W(2);
            h = POS_H(2);
        };
        class Text: RscStructuredText {
            idc = IDC_MESSAGE_TEXT;
            x = POS_X(15.5);
            y = POS_Y(9);
            w = POS_W(11.5);
            h = POS_H(5);
        };
        class ButtonCancel: RscButtonMenuCancel {
            x = POS_X(12.5);
            y = POS_Y(10);
            w = POS_W(5);
            h = POS_H(1);
        };
        class ButtonOK: RscButtonMenuOK {
            x = POS_X(22.5);
            y = POS_Y(10);
            w = POS_W(5);
            h = POS_H(1);
        };
    };
};
