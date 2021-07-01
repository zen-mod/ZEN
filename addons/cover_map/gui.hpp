class ctrlXSliderH;

class EGVAR(common,RscLabel);
class EGVAR(common,RscEdit);

class RscMapControl {
    class CustomMark;
};

class GVAR(RscMap): RscMapControl {
    idc = IDC_CM_MAP;

    // Prevent map textures from being faded
    alphaFadeStartScale = 100;
    alphaFadeEndScale = 100;

    // Allow map to be zoomed in and out more
    scaleMin = 0.0001;
    scaleMax = 3;
    scaleDefault = 1;

    // Hide contour interval info
    showCountourInterval = 0;

    // Hide custom marker
    class CustomMark: CustomMark {
        icon = "#(argb,8,8,3)color(0,0,0,0)";
        color[] = {0, 0, 0, 0};
        size = 0;
        importance = 0;
        coefMin = 0;
        coefMax = 0;
    };
};

class EGVAR(common,RscDisplay) {
    class controls {
        class Title;
        class Background;
        class Content;
        class ButtonOK;
        class ButtonCancel;
    };
};

class EGVAR(modules,RscDisplay): EGVAR(common,RscDisplay) {
    class controls: controls {
        class Title: Title {};
        class Background: Background {};
        class Content: Content {};
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};

class GVAR(display): EGVAR(modules,RscDisplay) {
    function = QFUNC(handleLoad);
    class controls: controls {
        class Title: Title {};
        class Background: Background {};
        class Content: Content {
            // Map is created through script since map controls cannot be inside controls groups
            // Extra height is used here so other display elements are positioned correctly
            h = POS_H(22.1);
            class controls {
                class RotationLabel: EGVAR(common,RscLabel) {
                    text = "$STR_3DEN_Object_Attribute_Rotation_displayName";
                };
                class RotationSlider: ctrlXSliderH {
                    idc = IDC_CM_ROTATION_SLIDER;
                    x = POS_W(10.1);
                    y = 0;
                    w = POS_W(13.5);
                    h = POS_H(1);
                };
                class RotationEdit: EGVAR(common,RscEdit) {
                    idc = IDC_CM_ROTATION_EDIT;
                    x = POS_W(23.7);
                    w = POS_W(2.3);
                };
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};
