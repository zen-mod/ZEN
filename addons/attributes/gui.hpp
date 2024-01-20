class ctrlToolbox;
class ctrlToolboxPictureKeepAspect;
class ctrlXSliderH;
class ctrlButtonPictureKeepAspect;
class RscControlsGroupNoScrollbars;

class EGVAR(common,RscLabel);
class EGVAR(common,RscBackground);
class EGVAR(common,RscEdit);
class EGVAR(common,RscCombo);

class GVAR(base): RscControlsGroupNoScrollbars {
    idc = IDC_ATTRIBUTE_GROUP;
    function = "";
    x = 0;
    y = 0;
    w = QUOTE(POS_W(26));
    h = QUOTE(POS_H(1));
    class controls {
        class Label: EGVAR(common,RscLabel) {
            idc = IDC_ATTRIBUTE_LABEL;
        };
    };
};

class GVAR(checkboxes): GVAR(base) {
    function = QFUNC(gui_checkboxes);
    class controls: controls {
        class Label: Label {};
        class Background: EGVAR(common,RscBackground) {
            idc = IDC_ATTRIBUTE_BACKGROUND;
            h = QUOTE(POS_H(1));
        };
        // Checkboxes created through script based on value info
    };
};

class GVAR(code): GVAR(base) {
    function = QFUNC(gui_code);
    h = QUOTE(POS_H(5));
    class controls: controls {
        class Label: Label {};
        class Combo: EGVAR(common,RscCombo) {
            idc = IDC_ATTRIBUTE_COMBO;
            font = "EtelkaMonospacePro";
            x = QUOTE(POS_W(10));
            w = QUOTE(POS_W(15));
            sizeEx = QUOTE(POS_H(0.65));
        };
        class Mode: ctrlButtonPictureKeepAspect {
            idc = IDC_ATTRIBUTE_MODE;
            x = QUOTE(POS_W(25));
            y = 0;
            w = QUOTE(POS_W(1));
            h = QUOTE(POS_H(1) - pixelH);
            offsetPressedX = 0;
            offsetPressedY = 0;
            colorBackground[] = {0, 0, 0, 0.5};
        };
        class Edit: EGVAR(common,RscEdit) {
            idc = IDC_ATTRIBUTE_EDIT;
            style = ST_MULTI;
            font = "EtelkaMonospacePro";
            x = pixelW;
            y = QUOTE(POS_H(1) + pixelH);
            w = QUOTE(POS_W(26) - pixelW);
            h = QUOTE(POS_H(4) - pixelH);
            sizeEx = QUOTE(POS_H(0.7));
            autocomplete = "scripting";
        };
    };
};

class GVAR(combo): GVAR(base) {
    function = QFUNC(gui_combo);
    class controls: controls {
        class Label: Label {};
        class Combo: EGVAR(common,RscCombo) {
            idc = IDC_ATTRIBUTE_COMBO;
        };
    };
};

class GVAR(edit): GVAR(base) {
    function = QFUNC(gui_edit);
    class controls: controls {
        class Label: Label {};
        class Edit: EGVAR(common,RscEdit) {
            idc = IDC_ATTRIBUTE_EDIT;
        };
    };
};

class GVAR(icons): GVAR(base) {
    function = QFUNC(gui_icons);
    h = QUOTE(POS_H(2.5));
    class controls: controls {
        class Label: Label {
            h = QUOTE(POS_H(2.5));
        };
        class Background: EGVAR(common,RscBackground) {
            idc = IDC_ATTRIBUTE_BACKGROUND;
        };
        // Icons created through script based on value info
    };
};

class GVAR(slider): GVAR(base) {
    function = QFUNC(gui_slider);
    class controls: controls {
        class Label: Label {};
        class Slider: ctrlXSliderH {
            idc = IDC_ATTRIBUTE_SLIDER;
            x = QUOTE(POS_W(10.1));
            y = 0;
            w = QUOTE(POS_W(13.5));
            h = QUOTE(POS_H(1));
        };
        class Edit: EGVAR(common,RscEdit) {
            idc = IDC_ATTRIBUTE_EDIT;
            x = QUOTE(POS_W(23.7));
            w = QUOTE(POS_W(2.3));
        };
    };
};

class GVAR(toolbox): GVAR(base) {
    function = QFUNC(gui_toolbox);
    class controls: controls {
        class Label: Label {};
        // Toolbox created through script based on value info
    };
};

class GVAR(waypoint): GVAR(base) {
    function = QFUNC(gui_waypoint);
    class controls: controls {
        class Label: Label {
            w = QUOTE(POS_W(26));
        };
        class Background: EGVAR(common,RscBackground) {
            idc = IDC_ATTRIBUTE_BACKGROUND;
            x = 0;
            y = QUOTE(POS_H(1));
            w = QUOTE(POS_W(26));
        };
        // Toolbox created through script based on available waypoints
    };
};

class GVAR(loiter): GVAR(base) {
    function = QFUNC(gui_loiter);
    h = QUOTE(POS_H(2));
    class controls: controls {
        class Label: Label {
            h = QUOTE(POS_H(2));
        };
        class Toolbox: ctrlToolboxPictureKeepAspect {
            idc = IDC_ATTRIBUTE_TOOLBOX;
            x = QUOTE(POS_W(10.1));
            y = 0;
            w = QUOTE(POS_W(15.9));
            h = QUOTE(POS_H(2));
            rows = 1;
            columns = 2;
            strings[] = {
                "\a3\3den\data\attributes\loiterdirection\ccw_ca.paa",
                "\a3\3den\data\attributes\loiterdirection\cw_ca.paa"
            };
        };
    };
};
