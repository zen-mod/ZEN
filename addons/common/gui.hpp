class RscText;
class RscEdit;
class RscCheckBox;
class RscButtonMenuOK;
class RscButtonMenuCancel;
class RscControlsGroupNoScrollbars;

class RscCombo {
    class ComboScrollBar;
};

class RscControlsGroup {
    class HScrollbar;
    class VScrollbar;
};

class GVAR(RscLabel): RscText {
    idc = -1;
    x = 0;
    y = 0;
    w = POS_W(10);
    h = POS_H(1);
    colorBackground[] = {0, 0, 0, 0.5};
};

class GVAR(RscBackground): RscText {
    idc = -1;
    style = ST_CENTER;
    x = POS_W(10);
    y = 0;
    w = POS_W(16);
    h = POS_H(2.5);
    colorText[] = {1, 1, 1, 0.5};
    colorBackground[] = COLOR_BACKGROUND_SETTING;
};

class GVAR(RscEdit): RscEdit {
    idc = -1;
    x = POS_W(10.1);
    y = pixelH;
    w = POS_W(15.9);
    h = POS_H(1) - pixelH;
    colorText[] = {1, 1, 1, 1};
    colorBackground[] = {0, 0, 0, 0.2};
};

class GVAR(RscCheckbox): RscCheckBox {
    idc = -1;
    x = POS_W(10.1);
    y = 0;
    w = POS_W(1);
    h = POS_H(1);
    soundClick[] = {"\a3\ui_f\data\sound\rscbutton\soundclick", 0.09, 1};
    soundEnter[] = {"\a3\ui_f\data\sound\rscbutton\soundenter", 0.09, 1};
    soundEscape[] = {"\a3\ui_f\data\sound\rscbutton\soundescape", 0.09, 1};
    soundPush[] = {"\a3\ui_f\data\sound\rscbutton\soundpush", 0.09, 1};
};

class GVAR(RscCombo): RscCombo {
    idc = -1;
    x = POS_W(10.1);
    y = 0;
    w = POS_W(15.9);
    h = POS_H(1);
    arrowFull = "\a3\3DEN\Data\Controls\ctrlCombo\arrowFull_ca.paa";
    arrowEmpty = "\a3\3DEN\Data\Controls\ctrlCombo\arrowEmpty_ca.paa";
    class ComboScrollBar: ComboScrollBar {
        thumb = "\a3\3DEN\Data\Controls\ctrlDefault\thumb_ca.paa";
        border = "\a3\3DEN\Data\Controls\ctrlDefault\border_ca.paa";
        arrowFull = "\a3\3DEN\Data\Controls\ctrlDefault\arrowFull_ca.paa";
        arrowEmpty = "\a3\3DEN\Data\Controls\ctrlDefault\arrowEmpty_ca.paa";
    };
};

class GVAR(RscControlsGroup): RscControlsGroup {
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
        width = POS_W(0.5);
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
            onLoad = QUOTE( \
                params [ARR_2('_control','_config')]; \
                private _display = ctrlParent _control; \
                _config = configHierarchy _config select 1; \
                _display setVariable [ARR_2(QQGVAR(config),_config)]; \
            );
            x = POS_X(6.5);
            w = POS_W(27);
            h = POS_H(1);
            colorBackground[] = GUI_THEME_COLOR;
            moving = 1;
        };
        class Background: RscText {
            idc = IDC_BACKGROUND;
            x = POS_X(6.5);
            w = POS_W(27);
            colorBackground[] = {0, 0, 0, 0.7};
        };
        class Content: RscControlsGroupNoScrollbars {
            idc = IDC_CONTENT;
            x = POS_X(7);
            w = POS_W(26);
        };
        class ButtonOK: RscButtonMenuOK {
            x = POS_X(28.5);
            w = POS_W(5);
            h = POS_H(1);
        };
        class ButtonCancel: RscButtonMenuCancel {
            x = POS_X(6.5);
            w = POS_W(5);
            h = POS_H(1);
        };
    };
};

class GVAR(RscDisplayScrollbars): GVAR(RscDisplay) {
    class controls: controls {
        class Title: Title {};
        class Background: Background {};
        class Content: GVAR(RscControlsGroup) {
            idc = IDC_CONTENT;
            x = POS_X(7);
            w = POS_W(26);
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};

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
