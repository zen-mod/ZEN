class RscText;
class RscEdit;
class RscCheckBox;
class ctrlToolbox;
class RscControlsGroup;
class RscControlsGroupNoScrollbars;
class RscButtonMenuOK;
class RscButtonMenuCancel;
class RscCombo {
    class ComboScrollBar;
};

class GVAR(RscEdit): RscEdit {
    colorText[] = {1, 1, 1, 1};
    colorBackground[] = {0, 0, 0, 0.2};
};

class GVAR(RscCheckbox): RscCheckBox {
    soundEnter[] = {"\a3\ui_f\data\Sound\RscButtonMenu\soundEnter", 0.09, 1};
    soundPush[] = {"\a3\ui_f\data\Sound\RscButtonMenu\soundPush", 0.09, 1};
    soundClick[] = {"\a3\ui_f\data\Sound\RscButtonMenu\soundClick", 0.09, 1};
    soundEscape[] = {"\a3\ui_f\data\Sound\RscButtonMenu\soundEscape", 0.09, 1};
};

class GVAR(RscCombo): RscCombo {
    arrowEmpty = "\a3\3DEN\Data\Controls\ctrlCombo\arrowEmpty_ca.paa";
    arrowFull = "\a3\3DEN\Data\Controls\ctrlCombo\arrowFull_ca.paa";
    class ComboScrollBar: ComboScrollBar {
        arrowEmpty = "\a3\3DEN\Data\Controls\ctrlDefault\arrowEmpty_ca.paa";
        arrowFull = "\a3\3DEN\Data\Controls\ctrlDefault\arrowFull_ca.paa";
        border = "\a3\3DEN\Data\Controls\ctrlDefault\border_ca.paa";
        thumb = "\a3\3DEN\Data\Controls\ctrlDefault\thumb_ca.paa";
    };
};

class GVAR(display) {
    idd = -1;
    movingEnable = 1;
    enableSimulation = 1;
    onLoad = QUOTE(with uiNamespace do {GVAR(display) = _this select 0});
    class controls {
        class Title: RscText {
            idc = IDC_TITLE;
            x = POS_X(6.5);
            y = POS_TITLE_Y(MIN_HEIGHT);
            w = POS_W(27);
            h = POS_H(1);
            colorBackground[] = GUI_BCG_COLOR;
            moving = 1;
        };
        class Background: RscText {
            idc = IDC_BACKGROUND;
            x = POS_X(6.5);
            y = POS_BACKGROUND_Y(MIN_HEIGHT);
            w = POS_W(27);
            h = POS_BACKGROUND_H(MIN_HEIGHT);
            colorBackground[] = {0, 0, 0, 0.7};
        };
        class Content: RscControlsGroup {
            idc = IDC_CONTENT;
            x = POS_X(7);
            y = POS_CONTENT_Y(MIN_HEIGHT);
            w = POS_W(26);
            h = MIN_HEIGHT;
        };
        class ButtonOK: RscButtonMenuOK {
            idc = IDC_BTN_OK;
            x = POS_X(28.5);
            y = POS_BUTTON_Y(MIN_HEIGHT);
            w = POS_W(5);
            h = POS_H(1);
        };
        class ButtonCancel: RscButtonMenuCancel {
            idc = IDC_BTN_CANCEL;
            x = POS_X(6.5);
            y = POS_BUTTON_Y(MIN_HEIGHT);
            w = POS_W(5);
            h = POS_H(1);
        };
    };
};

class GVAR(Row_Base): RscControlsGroupNoScrollbars {
    GVAR(script) = "";
    x = 0;
    y = 0;
    w = POS_W(26);
    h = POS_H(1);
    class controls {
        class Name: RscText {
            idc = IDC_ROW_NAME;
            x = 0;
            y = 0;
            w = POS_W(10);
            h = POS_H(1);
            colorBackground[] = {0, 0, 0, 0.5};
        };
    };
};

class GVAR(Row_Checkbox): GVAR(Row_Base) {
    GVAR(script) = QFUNC(gui_checkbox);
    class controls: controls {
        class Name: Name {};
        class Checkbox: GVAR(RscCheckbox) {
            idc = IDC_ROW_CHECKBOX;
            x = POS_W(10.1);
            y = 0;
            w = POS_W(1);
            h = POS_H(1);
        };
    };
};

class GVAR(Row_Edit): GVAR(Row_Base) {
    GVAR(script) = QFUNC(gui_edit);
    class controls: controls {
        class Name: Name {};
        class Edit: GVAR(RscEdit) {
            idc = IDC_ROW_EDIT;
            x = POS_W(10.1);
            y = pixelH;
            w = POS_W(15.9);
            h = POS_H(1) - pixelH;
        };
    };
};

class GVAR(Row_Combo): GVAR(Row_Base) {
    GVAR(script) = QFUNC(gui_combo);
    class controls: controls {
        class Name: Name {};
        class Combo: GVAR(RscCombo) {
            idc = IDC_ROW_COMBO;
            x = POS_W(10.1);
            y = 0;
            w = POS_W(15.9);
            h = POS_H(1);
        };
    };
};

class GVAR(Row_ToolboxYesNo): GVAR(Row_Base) {
    GVAR(script) = QFUNC(gui_toolbox);
    class controls: controls {
        class Name: Name {};
        class Toolbox: ctrlToolbox {
            idc = IDC_ROW_TOOLBOX;
            x = POS_W(10.1);
            y = 0;
            w = POS_W(15.9);
            h = POS_H(1);
            rows = 1;
            columns = 2;
            strings[] = {ECSTRING(common,No), ECSTRING(common,Yes)};
        };
    };
};

class GVAR(Row_ToolboxEnabled): GVAR(Row_ToolboxYesNo) {
    class controls: controls {
        class Name: Name {};
        class Toolbox: Toolbox {
            strings[] = {ECSTRING(common,Disabled), ECSTRING(common,Enabled)};
        };
    };
};
