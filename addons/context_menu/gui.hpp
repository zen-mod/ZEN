class RscText;
class RscPicture;
class RscControlsGroupNoScrollbars;

class GVAR(group): RscControlsGroupNoScrollbars {
    idc = IDC_CONTEXT_GROUP;
    x = 0;
    y = 0;
    w = POS_W(8);
    h = POS_H(1);
    class controls {
        class Background: RscText {
            idc = IDC_CONTEXT_BACKGROUND;
            x = 0;
            y = 0;
            w = POS_W(8);
            h = POS_H(1);
            colorBackground[] = {0.1, 0.1, 0.1, 0.5};
        };
    };
};

class GVAR(row): RscControlsGroupNoScrollbars {
    idc = IDC_CONTEXT_ROW;
    x = 0;
    y = 0;
    w = POS_W(8);
    h = POS_H(1);
    class controls {
        class Highlight: RscText {
            idc = IDC_CONTEXT_HIGHLIGHT;
            x = 0;
            y = 0;
            w = POS_W(8);
            h = POS_H(1);
        };
        class Name: RscText {
            idc = IDC_CONTEXT_NAME;
            x = POS_W(1.1);
            y = 0;
            w = POS_W(5.9);
            h = POS_H(1);
            sizeEx = POS_H(0.8);
            shadow = 0;
        };
        class Icon: RscPicture {
            idc = IDC_CONTEXT_ICON;
            x = POS_W(0.2);
            y = POS_H(0.05);
            w = POS_W(0.9);
            h = POS_H(0.9);
        };
        class Expandable: RscPicture {
            idc = IDC_CONTEXT_EXPANDABLE;
            text = QPATHTOF(ui\arrow_ca.paa);
            x = POS_W(7);
            y = 0;
            w = POS_W(1);
            h = POS_H(1);
        };
        class MouseArea: RscText {
            idc = IDC_CONTEXT_MOUSE;
            style = ST_MULTI;
            x = 0;
            y = 0;
            w = POS_W(8);
            h = POS_H(1);
        };
    };
};
