class RscText;
class RscButtonMenuOK;
class RscButtonMenuCancel;

class ctrlCombo;
class ctrlStatic;
class ctrlCheckbox;
class ctrlStaticBackground;
class ctrlStaticPictureKeepAspect;

class GVAR(display) {
    idd = -1;
    movingEnable = 1;
    onLoad = QUOTE(uiNamespace setVariable [ARR_2(QQGVAR(display),_this select 0)]);
    class controls {
        class Title: RscText {
            idc = IDC_TITLE;
            x = QUOTE(CENTER_X - (PICTURE_W + GRID_W(5)) / 2);
            y = QUOTE(CENTER_Y - (PICTURE_H + GRID_H(22)) / 2);
            w = QUOTE(PICTURE_W + GRID_W(5));
            h = QUOTE(GRID_H(5));
            colorBackground[] = GUI_THEME_COLOR;
            moving = 1;
        };
        class Background: RscText {
            idc = -1;
            x = QUOTE(CENTER_X - (PICTURE_W + GRID_W(5)) / 2);
            y = QUOTE(CENTER_Y - (PICTURE_H + GRID_H(11)) / 2);
            w = QUOTE(PICTURE_W + GRID_W(5));
            h = QUOTE(PICTURE_H + GRID_H(11));
            colorBackground[] = {0, 0, 0, 0.7};
        };
        class PictureBackground: ctrlStaticBackground {
            idc = -1;
            x = QUOTE(CENTER_X - PICTURE_W / 2);
            y = QUOTE(CENTER_Y - (PICTURE_H + GRID_H(6)) / 2);
            w = QUOTE(PICTURE_W);
            h = QUOTE(PICTURE_H);
        };
        class Picture: ctrlStaticPictureKeepAspect {
            idc = IDC_PICTURE;
            x = QUOTE(CENTER_X - PICTURE_W / 2);
            y = QUOTE(CENTER_Y - (PICTURE_H + GRID_H(6)) / 2);
            w = QUOTE(PICTURE_W);
            h = QUOTE(PICTURE_H);
        };
        class Presets: ctrlCombo {
            idc = IDC_PRESETS;
            x = QUOTE(CENTER_X - PICTURE_W / 2);
            y = QUOTE(CENTER_Y + (PICTURE_H + GRID_H(6)) / 2 - GRID_H(5));
            w = QUOTE(PICTURE_W / 3);
            h = QUOTE(GRID_H(5));
        };
        class MirrorLabel: ctrlStatic {
            style = ST_RIGHT;
            text = "$STR_3DEN_Object_Attribute_PylonsMirror_displayName";
            tooltip = "$STR_3DEN_Object_Attribute_PylonsMirror_tooltip";
            x = QUOTE(CENTER_X + PICTURE_W / 2 - GRID_W(35));
            y = QUOTE(CENTER_Y + (PICTURE_H + GRID_H(6)) / 2 - GRID_H(5));
            w = QUOTE(GRID_W(30));
            h = QUOTE(GRID_H(5));
        };
        class Mirror: ctrlCheckbox {
            idc = IDC_MIRROR;
            x = QUOTE(CENTER_X + PICTURE_W / 2 - GRID_W(5));
            y = QUOTE(CENTER_Y + (PICTURE_H + GRID_H(6)) / 2 - GRID_H(5));
            w = QUOTE(GRID_W(5));
            h = QUOTE(GRID_H(5));
        };
        class ButtonOK: RscButtonMenuOK {
            x = QUOTE(CENTER_X + (PICTURE_W + GRID_W(5)) / 2 - GRID_W(25));
            y = QUOTE(CENTER_Y + (PICTURE_H + GRID_H(22)) / 2 - GRID_H(5));
            w = QUOTE(GRID_W(25));
            h = QUOTE(GRID_H(5));
        };
        class ButtonCancel: RscButtonMenuCancel {
            x = QUOTE(CENTER_X - (PICTURE_W + GRID_W(5)) / 2);
            y = QUOTE(CENTER_Y + (PICTURE_H + GRID_H(22)) / 2 - GRID_H(5));
            w = QUOTE(GRID_W(25));
            h = QUOTE(GRID_H(5));
        };
    };
};
