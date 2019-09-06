class GVAR(RscAttributesBase) {
    idd = -1;
    class controls {
        class Title: RscText {
            idc = IDC_TITLE;
            x = POS_X(6.5);
            y = POS_Y(8.4);
            w = POS_W(27);
            h = POS_H(1);
            colorBackground[] = GUI_THEME_COLOR;
        };
        class Background: RscText {
            idc = IDC_BACKGROUND;
            x = POS_X(6.5);
            y = POS_Y(9.5);
            w = POS_W(27);
            h = POS_H(6.5);
            colorBackground[] = {0, 0, 0, 0.7};
        };
        class Content: EGVAR(common,RscControlsGroup) {
            idc = IDC_CONTENT;
            x = POS_X(7);
            y = POS_Y(10);
            w = POS_W(26);
            h = POS_H(5.5);
        };
        class ButtonOK: RscButtonMenuOK {
            x = POS_X(28.5);
            y = POS_Y(16.1);
            w = POS_W(5);
            h = POS_H(1);
        };
        class ButtonCancel: RscButtonMenuCancel {
            x = POS_X(6.5);
            y = POS_Y(16.1);
            w = POS_W(5);
            h = POS_H(1);
        };
    };
};
