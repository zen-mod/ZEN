class RscText;
class RscEdit;
class RscCheckBox;
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

class GVAR(RscCheckBox): RscCheckBox {
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
