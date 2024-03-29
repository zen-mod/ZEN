class RscText;
class RscFrame;
class RscListBox;
class RscButtonMenu;
class RscButtonArsenal;
class RscActivePicture;
class RscControlsGroupNoScrollbars;

class GVAR(display) {
    idd = IDD_DISPLAY;
    onKeyDown = QUOTE(_this call FUNC(onKeyDown));
    onMouseButtonDown = QUOTE(_this call FUNC(onMouseButtonDown));
    onMouseButtonUp = QUOTE(_this call FUNC(onMouseButtonUp));
    class controlsBackground {
        class BlackLeft: RscText {
            idc = -1;
            x = QUOTE(safeZoneXAbs);
            y = QUOTE(safeZoneY);
            w = QUOTE(safeZoneXAbs - safeZoneX);
            h = QUOTE(safeZoneH);
            colorBackground[] = {0, 0, 0, 1};
        };
        class BlackRight: BlackLeft {
            x = QUOTE(safeZoneX + safeZoneW);
        };
        class MouseArea: RscText {
            idc = IDC_MOUSEAREA;
            onMouseMoving = QUOTE(_this call FUNC(handleMouse));
            onMouseHolding = QUOTE(_this call FUNC(handleMouse));
            onMouseZChanged = QUOTE(_this call FUNC(onMouseZChanged));
            onMouseButtonClick = QUOTE(_this call FUNC(onMouseButtonClick));
            style = ST_MULTI;
            x = QUOTE(safeZoneX);
            y = QUOTE(safeZoneY);
            w = QUOTE(safeZoneW);
            h = QUOTE(safeZoneH);
        };
    };
    class controls {
        class MenuBar: RscControlsGroupNoScrollbars {
            idc = IDC_MENU_BAR;
            x = QUOTE(safeZoneX + POS_W(0.5));
            y = QUOTE(safeZoneY + safezoneH - POS_H(1.5));
            w = QUOTE(safeZoneW - POS_W(1));
            h = QUOTE(POS_H(1));
            class controls {
                class ButtonClose: RscButtonMenu {
                    onButtonClick = QUOTE(_this call FUNC(closeGarage));
                    text = "$STR_DISP_CLOSE";
                    tooltip = CSTRING(Close_Tooltip);
                    x = 0;
                    y = 0;
                    w = QUOTE((safeZoneW - POS_W(1)) / 5);
                    h = QUOTE(POS_H(1));
                };
                class ButtonHide: ButtonClose {
                    onButtonClick = QUOTE(_this call FUNC(toggleInterface));
                    text = "$STR_CA_HIDE";
                    tooltip = CSTRING(Hide_Tooltip);
                    x = QUOTE((safeZoneW - POS_W(1)) / 5 + POS_W(0.1));
                    w = QUOTE((safeZoneW - POS_W(1)) / 8);
                };
                class ButtonApply: ButtonHide {
                    idc = IDC_BUTTON_APPLY;
                    onButtonClick = QUOTE(_this call FUNC(applyToAll));
                    text = CSTRING(ApplyToAll);
                    tooltip = CSTRING(ApplyToAll_Tooltip);
                    x = QUOTE((safeZoneW - POS_W(1)) / 5 + (safeZoneW - POS_W(1)) / 8 + POS_W(0.2));
                };
            };
        };
        class InfoGroup: RscControlsGroupNoScrollbars {
            idc = IDC_INFO_GROUP;
            x = QUOTE(safeZoneX + safeZoneW - POS_W(20.1));
            y = QUOTE(safeZoneY + safeZoneH - POS_H(4.5));
            w = QUOTE(POS_W(17.6));
            h = QUOTE(POS_H(3));
            class controls {
                class Background: RscText {
                    idc = -1;
                    x = QUOTE(POS_W(2.6));
                    y = 0;
                    w = QUOTE(POS_W(15));
                    h = QUOTE(POS_H(2.5));
                    colorBackground[] = {0, 0, 0, 0.8};
                };
                class InfoName: RscText {
                    idc = IDC_INFO_NAME;
                    x = QUOTE(POS_W(2.6));
                    y = QUOTE(POS_H(0));
                    w = QUOTE(POS_W(15));
                    h = QUOTE(POS_H(1.5));
                    sizeEx = QUOTE(POS_H(1.5));
                };
                class InfoAuthor: RscText {
                    idc = IDC_INFO_AUTHOR;
                    x = QUOTE(POS_W(2.6));
                    y = QUOTE(POS_H(1));
                    w = QUOTE(POS_W(15));
                    h = QUOTE(POS_H(1.5));
                    sizeEx = QUOTE(POS_H(0.8));
                    colorText[] = {1, 1, 1, 0.5};
                };
                class DLCBackground: RscText {
                    idc = IDC_DLC_BACKGROUND;
                    x = 0;
                    y = 0;
                    w = QUOTE(POS_W(2.5));
                    h = QUOTE(POS_H(2.5));
                    colorBackground[] = {0, 0, 0, 0.5};
                };
                class DLCIcon: RscActivePicture {
                    idc = IDC_DLC_ICON;
                    x = 0;
                    y = 0;
                    w = QUOTE(POS_W(2.5));
                    h = QUOTE(POS_H(2.5));
                    color[] = {1, 1, 1, 1};
                    colorActive[] = {1, 1, 1, 1};
                };
            };
        };
        class BackgroundAnimations: RscText {
            idc = IDC_BACKGROUND_ANIMATIONS;
            x = QUOTE(safeZoneX);
            y = QUOTE(safeZoneY + POS_H(0.5));
            w = QUOTE(POS_W(3.5));
            h = QUOTE(POS_H(2));
            colorBackground[] = {0, 0, 0, 1};
        };
        class ButtonAnimations: RscButtonArsenal {
            idc = IDC_BUTTON_ANIMATIONS;
            onButtonClick = QUOTE(0 call FUNC(onTabSelect));
            text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGarage\AnimationSources_ca.paa";
            tooltip = "$STR_A3_RscDisplayGarage_tab_AnimationSources";
            x = QUOTE(safeZoneX + POS_W(0.5));
            y = QUOTE(safeZoneY + POS_H(0.5));
            w = QUOTE(POS_W(2));
            h = QUOTE(POS_H(2));
            colorBackground[] = {0, 0, 0, 0.5};
        };
        class BackgroundTextures: BackgroundAnimations {
            idc = IDC_BACKGROUND_TEXTURES;
            y = QUOTE(safeZoneY + POS_H(2.8));
        };
        class ButtonTextures: ButtonAnimations {
            idc = IDC_BUTTON_TEXTURES;
            onButtonClick = QUOTE(1 call FUNC(onTabSelect));
            text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGarage\TextureSources_ca.paa";
            tooltip = "$STR_A3_RscDisplayGarage_tab_TextureSources";
            y = QUOTE(safeZoneY + POS_H(2.8));
        };
        class ListBackground: RscText {
            idc = IDC_LIST_BACKGROUND;
            x = QUOTE(safeZoneX + POS_W(3.5));
            y = QUOTE(safeZoneY + POS_H(0.5));
            w = QUOTE(POS_W(13));
            h = QUOTE(safeZoneH - POS_H(2.5));
            colorBackground[] = {0, 0, 0, 0.5};
        };
        class ListFrame: RscFrame {
            idc = IDC_LIST_FRAME;
            x = QUOTE(safeZoneX + POS_W(3.5));
            y = QUOTE(safeZoneY + POS_H(0.5));
            w = QUOTE(POS_W(13));
            h = QUOTE(safeZoneH - POS_H(2.5));
            colorText[] = {0, 0, 0, 1};
        };
        class ListAnimations: RscListBox {
            idc = IDC_LIST_ANIMATIONS;
            onLBSelChanged = QUOTE(_this call FUNC(onAnimationSelect));
            x = QUOTE(safeZoneX + POS_W(3.5));
            y = QUOTE(safeZoneY + POS_H(0.5));
            w = QUOTE(POS_W(13));
            h = QUOTE(safeZoneH - POS_H(2.5));
            sizeEx = QUOTE(POS_H(1.2));
            colorSelect[] = {1, 1, 1, 1};
            colorSelect2[] = {1, 1, 1, 1};
            colorBackground[] = {0, 0, 0, 0};
            colorSelectBackground[] = {1, 1, 1, 0.5};
            colorSelectBackground2[] = {1, 1, 1, 0.5};
            colorPictureSelected[] = {1, 1, 1, 1};
            colorPictureRightSelected[] = {1, 1, 1, 1};
        };
        class ListTextures: ListAnimations {
            idc = IDC_LIST_TEXTURES;
            onLBSelChanged = QUOTE(_this call FUNC(onTextureSelect));
        };
        class ListEmpty: RscText {
            idc = IDC_LIST_EMPTY;
            style = ST_CENTER;
            text = "$STR_lib_info_na";
            x = QUOTE(safeZoneX + POS_W(3.5));
            y = QUOTE(safeZoneY + POS_H(0.5));
            w = QUOTE(POS_W(13));
            h = QUOTE(safeZoneH - POS_H(2.5));
            sizeEx = QUOTE(POS_H(2));
            colorText[] = {1, 1, 1, 0.15};
            shadow = 0;
        };
    };
};
