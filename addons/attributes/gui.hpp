class RscText;
class ctrlToolbox;
class ctrlXSliderH;
class RscButtonMenuOK;
class RscButtonMenuCancel;
class RscControlsGroupNoScrollbars;

class EGVAR(common,RscLabel);
class EGVAR(common,RscBackground);
class EGVAR(common,RscEdit);
class EGVAR(common,RscCheckBox);
class EGVAR(common,RscCombo);
class EGVAR(common,RscControlsGroup);

class GVAR(display) {
    idd = IDD_DISPLAY;
    movingEnable = 1;
    onLoad = QUOTE(with uiNamespace do {GVAR(display) = _this select 0});
    class controls {
        class Title: RscText {
            idc = IDC_DISPLAY_TITLE;
            x = POS_X(6.5);
            y = POS_Y(8.4);
            w = POS_W(27);
            h = POS_H(1);
            colorBackground[] = GUI_THEME_COLOR;
            moving = 1;
        };
        class Background: RscText {
            idc = IDC_DISPLAY_BACKGROUND;
            x = POS_X(6.5);
            y = POS_Y(9.5);
            w = POS_W(27);
            h = POS_H(6.5);
            colorBackground[] = {0, 0, 0, 0.7};
        };
        class Content: EGVAR(common,RscControlsGroup) {
            idc = IDC_DISPLAY_CONTENT;
            x = POS_X(7);
            y = POS_Y(10);
            w = POS_W(26);
            h = POS_H(5.5);
            class controls {};
        };
        class ButtonOK: RscButtonMenuOK {
            onButtonClick = QUOTE(call FUNC(confirm));
            x = POS_X(28.5);
            y = POS_Y(16.1);
            w = POS_W(5);
            h = POS_H(1);
        };
        class ButtonCancel: RscButtonMenuCancel {
            x = POS_X(6.5);
            y = POS_Y(16.1);
            w = POS_W(5);
            h = POS_H(1);
        };
    };
};

class GVAR(base): RscControlsGroupNoScrollbars {
    idc = IDC_ATTRIBUTE_GROUP;
    GVAR(function) = "";
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

class GVAR(checkbox): GVAR(base) {
    GVAR(function) = QFUNC(gui_checkbox);
    class controls: controls {
        class Label: Label {};
        class CheckBox: EGVAR(common,RscCheckBox) {
            idc = IDC_ATTRIBUTE_CHECKBOX;
        };
    };
};

class GVAR(code): GVAR(base) {
    GVAR(function) = QFUNC(gui_code);
    h = POS_H(5);
    class controls: controls {
        class Label: Label {};
        class Combo: EGVAR(common,RscCombo) {
            idc = IDC_ATTRIBUTE_COMBO;
            font = "EtelkaMonospacePro";
            x = POS_W(10);
            w = POS_W(16);
            sizeEx = POS_H(0.65);
        };
        class Edit: EGVAR(common,RscEdit) {
            idc = IDC_ATTRIBUTE_EDIT;
            style = ST_MULTI;
            font = "EtelkaMonospacePro";
            x = pixelW;
            y = POS_H(1);
            w = POS_W(26) - pixelW;
            h = POS_H(4);
            sizeEx = POS_H(0.7);
            autocomplete = "scripting";
        };
    };
};

class GVAR(combo): GVAR(base) {
    GVAR(function) = QFUNC(gui_combo);
    class controls: controls {
        class Label: Label {};
        class Combo: EGVAR(common,RscCombo) {
            idc = IDC_ATTRIBUTE_COMBO;
        };
    };
};

class GVAR(edit): GVAR(base) {
    GVAR(function) = QFUNC(gui_edit);
    class controls: controls {
        class Label: Label {};
        class Edit: EGVAR(common,RscEdit) {
            idc = IDC_ATTRIBUTE_EDIT;
        };
    };
};

class GVAR(icons): GVAR(base) {
    GVAR(function) = QFUNC(gui_icons);
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
    GVAR(function) = QFUNC(gui_slider);
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
    GVAR(function) = QFUNC(gui_toolbox);
    class controls: controls {
        class Label: Label {};
        // Toolbox created through script based on value info
    };
};

class GVAR(RscToolbox): ctrlToolbox {
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

#define WAYPOINT_ROWS (ceil (count (uiNamespace getVariable QGVAR(waypointTypes)) / 3))

class GVAR(waypoint): GVAR(base) {
    GVAR(function) = QFUNC(gui_waypoint);
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
