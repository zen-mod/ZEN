class RscText;
class RscEdit;
class RscButtonMenu;
class ctrlControlsGroup;

class GVAR(export) {
    idd = -1;
    movingEnable = 1;
    onLoad = QUOTE(with uiNamespace do {GVAR(export) = _this select 0});
    class controls {
        class Title: RscText {
            idc = IDC_EXPORT_TITLE;
            x = POS_X(5);
            y = POS_Y(0);
            w = POS_W(30);
            h = POS_H(1);
            colorBackground[] = GUI_THEME_COLOR;
            moving = 1;
        };
        class Background: RscText {
            idc = -1;
            x = POS_X(5);
            y = POS_Y(1.1);
            w = POS_W(30);
            h = POS_H(22.8);
            colorBackground[] = {0, 0, 0, 0.7};
        };
        class Group: ctrlControlsGroup {
            idc = IDC_EXPORT_GROUP;
            x = POS_X(5.5);
            y = POS_Y(1.6);
            w = POS_W(29);
            h = POS_H(21.8);
            class controls {
                class Edit: RscEdit {
                    idc = IDC_EXPORT_EDIT;
                    style = ST_MULTI + ST_NO_RECT;
                    x = 0;
                    y = 0;
                    w = POS_W(29);
                    h = POS_H(21.8);
                    sizeEx = POS_H(0.8);
                    colorBackground[] = COLOR_BACKGROUND_SETTING;
                };
            };
        };
        class ButtonClose: RscButtonMenu {
            idc = IDC_EXPORT_CLOSE;
            text = "$STR_Disp_Close";
            x = POS_X(5);
            y = POS_Y(24);
            w = POS_W(10);
            h = POS_H(1);
        };
        class ButtonCopy: ButtonClose {
            idc = IDC_EXPORT_COPY;
            text = CSTRING(CopyToClipboard);
            x = POS_X(15.1);
        };
    };
};
