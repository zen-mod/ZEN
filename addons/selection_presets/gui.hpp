class RscText;
class RscPictureKeepAspect;
class RscControlsGroupNoScrollbars;

class GVAR(slot): RscControlsGroupNoScrollbars {
    class controls {
        class Background: RscText {
            idc = IDC_SLOT_BACKGROUND;
            colorBackground[] = {0.1, 0.1, 0.1, 0.5};
        };
        class Divider: RscText {
            idc = IDC_SLOT_DIVIDER;
            colorBackground[] = {0, 0, 0, 1};
        };
        class Key: RscText {
            idc = IDC_SLOT_KEY;
            style = ST_CENTER;
            sizeEx = QUOTE(POS_H(0.8));
            colorBackground[] = {0, 0, 0, 0.5};
        };
        class Icon1: RscPictureKeepAspect {
            idc = IDC_SLOT_ICON_1;
        };
        class Icon2: Icon1 {
            idc = IDC_SLOT_ICON_2;
        };
        class Icon3: Icon1 {
            idc = IDC_SLOT_ICON_3;
        };
        class ExtraCount: RscText {
            idc = IDC_SLOT_EXTRA_COUNT;
            style = ST_CENTER;
            sizeEx = QUOTE(POS_H(0.8));
        };
        class Mouse: RscText {
            idc = IDC_SLOT_MOUSE;
            style = ST_MULTI;
            onMouseButtonDown = QUOTE(call FUNC(handleMouseButtonDown));
            onMouseEnter = QUOTE(call FUNC(handleMouseEnter));
            onMouseExit = QUOTE(call FUNC(handleMouseExit));
        };
    };
};

class GVAR(add): RscControlsGroupNoScrollbars {
    class controls {
        class Background: RscText {
            idc = IDC_ADD_PRESET_BACKGROUND;
            colorBackground[] = {0.1, 0.1, 0.1, 0.5};
        };
        class Divider: RscText {
            idc = IDC_ADD_PRESET_DIVIDER;
            colorBackground[] = {0, 0, 0, 1};
        };
        class Plus: RscPictureKeepAspect {
            idc = IDC_ADD_PRESET_PLUS;
            text = QPATHTOF(ui\plus_ca.paa);
        };
        class Mouse: RscText {
            idc = IDC_ADD_PRESET_MOUSE;
            style = ST_MULTI;
            tooltip = CSTRING(AddPresetTooltip);
            onMouseButtonDown = QUOTE(call FUNC(handleMouseButtonDown));
            onMouseEnter = QUOTE(call FUNC(handleMouseEnter));
            onMouseExit = QUOTE(call FUNC(handleMouseExit));
        };
    };
};
