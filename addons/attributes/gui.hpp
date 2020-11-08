class ctrlToolbox;
class ctrlToolboxPictureKeepAspect;
class ctrlXSliderH;
class ctrlButtonPictureKeepAspect;
class RscControlsGroupNoScrollbars;

class EGVAR(common,RscLabel);
class EGVAR(common,RscBackground);
class EGVAR(common,RscEdit);
class EGVAR(common,RscCombo);

class GVAR(RscToolbox): ctrlToolbox {
    idc = -1;
    x = POS_W(10.1);
    y = 0;
    w = POS_W(15.9);
    h = POS_H(1);
    tooltipColorBox[] = {0, 0, 0, 0};
    tooltipColorText[] = {0, 0, 0, 0};
    tooltipColorShade[] = {0, 0, 0, 0};
    rows = QGVAR(rows);
    columns = QGVAR(columns);
};

class GVAR(base): RscControlsGroupNoScrollbars {
    idc = IDC_ATTRIBUTE_GROUP;
    function = "";
    x = 0;
    y = 0;
    w = POS_W(26);
    h = POS_H(1);
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
            h = POS_H(1);
        };
        // Checkboxes created through script based on value info
    };
};

class GVAR(code): GVAR(base) {
    function = QFUNC(gui_code);
    h = POS_H(5);
    class controls: controls {
        class Label: Label {};
        class Combo: EGVAR(common,RscCombo) {
            idc = IDC_ATTRIBUTE_COMBO;
            font = "EtelkaMonospacePro";
            x = POS_W(10);
            w = POS_W(15);
            sizeEx = POS_H(0.65);
        };
        class Mode: ctrlButtonPictureKeepAspect {
            idc = IDC_ATTRIBUTE_MODE;
            x = POS_W(25);
            y = 0;
            w = POS_W(1);
            h = POS_H(1) - pixelH;
            offsetPressedX = 0;
            offsetPressedY = 0;
            colorBackground[] = {0, 0, 0, 0.5};
        };
        class Edit: EGVAR(common,RscEdit) {
            idc = IDC_ATTRIBUTE_EDIT;
            style = ST_MULTI;
            font = "EtelkaMonospacePro";
            x = pixelW;
            y = POS_H(1) + pixelH;
            w = POS_W(26) - pixelW;
            h = POS_H(4) - pixelH;
            sizeEx = POS_H(0.7);
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
    h = POS_H(2.5);
    class controls: controls {
        class Label: Label {
            h = POS_H(2.5);
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
            x = POS_W(10.1);
            y = 0;
            w = POS_W(13.5);
            h = POS_H(1);
        };
        class Edit: EGVAR(common,RscEdit) {
            idc = IDC_ATTRIBUTE_EDIT;
            x = POS_W(23.7);
            w = POS_W(2.3);
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

#define WAYPOINT_ROWS (ceil (count (uiNamespace getVariable QGVAR(waypointTypes)) / 3))

class GVAR(waypoint): GVAR(base) {
    function = QFUNC(gui_waypoint);
    h = POS_H(WAYPOINT_ROWS + 1);
    class controls: controls {
        class Label: Label {
            w = POS_W(26);
        };
        class Background: EGVAR(common,RscBackground) {
            idc = IDC_ATTRIBUTE_BACKGROUND;
            x = 0;
            y = POS_H(1);
            w = POS_W(26);
            h = POS_H(WAYPOINT_ROWS);
        };
        class Toolbox: ctrlToolbox {
            idc = IDC_ATTRIBUTE_TOOLBOX;
            x = 0;
            y = POS_H(1);
            w = POS_W(26);
            h = POS_H(WAYPOINT_ROWS);
            colorBackground[] = {0, 0, 0, 0};
            tooltipColorBox[] = {0, 0, 0, 0};
            tooltipColorText[] = {0, 0, 0, 0};
            tooltipColorShade[] = {0, 0, 0, 0};
            rows = WAYPOINT_ROWS;
            columns = 3;
        };
    };
};

class GVAR(loiter): GVAR(base) {
    function = QFUNC(gui_loiter);
    h = POS_H(2);
    class controls: controls {
        class Label: Label {
            h = POS_H(2);
        };
        class Toolbox: ctrlToolboxPictureKeepAspect {
            idc = IDC_ATTRIBUTE_TOOLBOX;
            x = POS_W(10.1);
            y = 0;
            w = POS_W(15.9);
            h = POS_H(2);
            rows = 1;
            columns = 2;
            strings[] = {
                "\a3\3den\data\attributes\loiterdirection\ccw_ca.paa",
                "\a3\3den\data\attributes\loiterdirection\cw_ca.paa"
            };
        };
    };
};
