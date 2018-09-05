class RscText;
class RscPicture;
class RscControlsGroupNoScrollbars;

class GVAR(group): RscControlsGroupNoScrollbars {
    idc = IDC_CONTEXT_GROUP;
    x = 0;
    y = 0;
    w = 8 * GUI_GRID_W;
    h = GUI_GRID_H;
    class controls {
        class Background: RscText {
            idc = IDC_CONTEXT_BACKGROUND;
            x = 0;
            y = 0;
            w = 8 * GUI_GRID_W;
            h = GUI_GRID_H;
            colorBackground[] = {0.1, 0.1, 0.1, 0.5};
        };
    };
};

class GVAR(row): RscControlsGroupNoScrollbars {
    idc = IDC_CONTEXT_ROW;
    x = 0;
    y = 0;
    w = 8 * GUI_GRID_W;
    h = GUI_GRID_H;
    class controls {
        class Highlight: RscText {
            idc = IDC_CONTEXT_HIGHLIGHT;
            x = 0;
            y = 0;
            w = 8 * GUI_GRID_W;
            h = GUI_GRID_H;
        };
        class Name: RscText {
            idc = IDC_CONTEXT_NAME;
            x = 1.1 * GUI_GRID_W;
            y = 0;
            w = 6.8 * GUI_GRID_W;
            h = GUI_GRID_H;
            sizeEx = 0.8 * GUI_GRID_H;
            shadow = 0;
        };
        class Picture: RscPicture {
            idc = IDC_CONTEXT_PICTURE;
            x = 0.2 * GUI_GRID_W;
            y = 0.05 * GUI_GRID_H;
            w = 0.9 * GUI_GRID_W;
            h = 0.9 * GUI_GRID_H;
        };
        class Expandable: RscPicture {
            idc = IDC_CONTEXT_EXPANDABLE;
            text = QPATHTOF(UI\arrow_ca.paa);
            x = 7 * GUI_GRID_W;
            y = 0;
            w = GUI_GRID_W;
            h = GUI_GRID_H;
        };
        class MouseArea: RscText {
            idc = IDC_CONTEXT_MOUSE;
            style = 16;
            x = 0;
            y = 0;
            w = 8 * GUI_GRID_W;
            h = GUI_GRID_H;
        };
    };
};
