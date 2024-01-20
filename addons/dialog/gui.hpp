class RscText;
class RscEdit;
class ctrlXSliderH;
class RscControlsGroupNoScrollbars;

class EGVAR(common,RscLabel);
class EGVAR(common,RscBackground);
class EGVAR(common,RscEdit);
class EGVAR(common,RscCheckbox);
class EGVAR(common,RscCombo);
class EGVAR(common,RscListBox);
class EGVAR(common,RscSides);
class EGVAR(common,RscOwners);

class GVAR(Row_Base): RscControlsGroupNoScrollbars {
    function = "";
    idc = IDC_ROW_GROUP;
    x = 0;
    y = 0;
    w = QUOTE(POS_W(26));
    h = QUOTE(POS_H(1));
    class controls {
        class Label: EGVAR(common,RscLabel) {
            idc = IDC_ROW_LABEL;
        };
    };
};

class GVAR(Row_Checkbox): GVAR(Row_Base) {
    function = QFUNC(gui_checkbox);
    class controls: controls {
        class Label: Label {};
        class Checkbox: EGVAR(common,RscCheckbox) {
            idc = IDC_ROW_CHECKBOX;
        };
    };
};

class GVAR(Row_ColorRGB): GVAR(Row_Base) {
    function = QFUNC(gui_color);
    h = QUOTE(POS_H(3));
    class controls: controls {
        class Label: Label {};
        class Preview: RscText {
            idc = IDC_ROW_COLOR_PREVIEW;
            x = 0;
            y = QUOTE(POS_H(1));
            w = QUOTE(POS_W(10));
            h = QUOTE(POS_H(2));
        };
        class Red: ctrlXSliderH {
            idc = IDC_ROW_COLOR_RED;
            x = QUOTE(POS_W(10.1));
            y = 0;
            w = QUOTE(POS_W(13.8));
            h = QUOTE(POS_H(1));
            color[] = {1, 0, 0, 0.6};
            colorActive[] = {1, 0, 0, 1};
        };
        class Red_Edit: EGVAR(common,RscEdit) {
            idc = IDC_ROW_COLOR_RED_EDIT;
            x = QUOTE(POS_W(24));
            y = 0;
            w = QUOTE(POS_W(2));
            h = QUOTE(POS_H(1));
        };
        class Green: Red {
            idc = IDC_ROW_COLOR_GREEN;
            y = QUOTE(POS_H(1));
            color[] = {0, 1, 0, 0.6};
            colorActive[] = {0, 1, 0, 1};
        };
        class Green_Edit: Red_Edit {
            idc = IDC_ROW_COLOR_GREEN_EDIT;
            y = QUOTE(POS_H(1));
        };
        class Blue: Red {
            idc = IDC_ROW_COLOR_BLUE;
            y = QUOTE(POS_H(2));
            color[] = {0, 0, 1, 0.6};
            colorActive[] = {0, 0, 1, 1};
        };
        class Blue_Edit: Red_Edit {
            idc = IDC_ROW_COLOR_BLUE_EDIT;
            y = QUOTE(POS_H(2));
        };
    };
};

class GVAR(Row_ColorRGBA): GVAR(Row_ColorRGB) {
    h = QUOTE(POS_H(4));
    class controls: controls {
        class Label: Label {};
        class Preview: Preview {
            h = QUOTE(POS_H(3));
        };
        class Red: Red {};
        class Red_Edit: Red_Edit {};
        class Green: Green {};
        class Green_Edit: Green_Edit {};
        class Blue: Blue {};
        class Blue_Edit: Blue_Edit {};
        class Alpha: Red {
            idc = IDC_ROW_COLOR_ALPHA;
            y = QUOTE(POS_H(3));
            color[] = {1, 1, 1, 0.6};
            colorActive[] = {1, 1, 1, 1};
        };
        class Alpha_Edit: Red_Edit {
            idc = IDC_ROW_COLOR_ALPHA_EDIT;
            y = QUOTE(POS_H(3));
        };
    };
};

class GVAR(Row_Combo): GVAR(Row_Base) {
    function = QFUNC(gui_combo);
    class controls: controls {
        class Label: Label {};
        class Combo: EGVAR(common,RscCombo) {
            idc = IDC_ROW_COMBO;
        };
    };
};

class GVAR(Row_Edit): GVAR(Row_Base) {
    function = QFUNC(gui_edit);
    class controls: controls {
        class Label: Label {};
        class Edit: EGVAR(common,RscEdit) {
            idc = IDC_ROW_EDIT;
        };
    };
};

class GVAR(Row_EditMulti): GVAR(Row_Edit) {
    class controls: controls {
        class Label: Label {
            w = QUOTE(POS_W(26));
        };
        class Edit: Edit {
            style = ST_MULTI;
            x = QUOTE(pixelW);
            y = QUOTE(POS_H(1));
            w = QUOTE(POS_W(26) - pixelW);
        };
    };
};

class GVAR(Row_EditCode): GVAR(Row_EditMulti) {
    class controls: controls {
        class Label: Label {};
        class Edit: Edit {
            font = "EtelkaMonospacePro";
            sizeEx = QUOTE(POS_H(0.7));
            autocomplete = "scripting";
        };
    };
};

class GVAR(Row_List): GVAR(Row_Base) {
    function = QFUNC(gui_list);
    class controls: controls {
        class Label: Label {
            w = QUOTE(POS_W(26));
        };
        class List: EGVAR(common,RscListBox) {
            // Using IDC for combo since handling is identical and the combo initialization function is called to add entries
            idc = IDC_ROW_COMBO;
        };
    };
};

class GVAR(Row_Owners): GVAR(Row_Base) {
    function = QFUNC(gui_owners);
    h = QUOTE(POS_H(11));
    class controls: controls {
        class Label: Label {
            w = QUOTE(POS_W(26));
        };
        class Owners: EGVAR(common,RscOwners) {
            idc = IDC_ROW_OWNERS;
            y = QUOTE(POS_H(1));
        };
    };
};

class GVAR(Row_Sides): GVAR(Row_Base) {
    function = QFUNC(gui_sides);
    h = QUOTE(POS_H(2.5));
    class controls: controls {
        class Label: Label {
            h = QUOTE(POS_H(2.5));
        };
        class Background: EGVAR(common,RscBackground) {};
        class Sides: EGVAR(common,RscSides) {
            idc = IDC_ROW_SIDES;
        };
    };
};

class GVAR(Row_Slider): GVAR(Row_Base) {
    function = QFUNC(gui_slider);
    class controls: controls {
        class Label: Label {};
        class Slider: ctrlXSliderH {
            idc = IDC_ROW_SLIDER;
            x = QUOTE(POS_W(10.1));
            y = 0;
            w = QUOTE(POS_W(13.5));
            h = QUOTE(POS_H(1));
        };
        class Edit: EGVAR(common,RscEdit) {
            idc = IDC_ROW_EDIT;
            x = QUOTE(POS_W(23.7));
            w = QUOTE(POS_W(2.3));
        };
    };
};

class GVAR(Row_Toolbox): GVAR(Row_Base) {
    function = QFUNC(gui_toolbox);
    class controls: controls {
        class Label: Label {};
        /* Toolbox created through script */
    };
};

class GVAR(Row_VectorXY): GVAR(Row_Base) {
    function = QFUNC(gui_vector);
    class controls: controls {
        class Label: Label {};
        class IconX: RscText {
            idc = -1;
            style = ST_CENTER;
            text = "$STR_3DEN_Axis_X";
            x = QUOTE(POS_W(10.1));
            y = 0;
            w = QUOTE(POS_W(1));
            h = QUOTE(POS_H(1));
            font = "RobotoCondensedLight";
            colorBackground[] = {0.77, 0.18, 0.1, 1};
            shadow = 0;
        };
        class EditX: EGVAR(common,RscEdit) {
            idc = IDC_ROW_VECTOR_X;
            x = QUOTE(POS_W(11.2));
            w = QUOTE(POS_W(6.8));
        };
        class IconY: IconX {
            text = "$STR_3DEN_Axis_Y";
            x = QUOTE(POS_W(18.1));
            colorBackground[] = {0.58, 0.82, 0.22, 1};
        };
        class EditY: EditX {
            idc = IDC_ROW_VECTOR_Y;
            x = QUOTE(POS_W(19.2));
        };
    };
};

class GVAR(Row_VectorXYZ): GVAR(Row_VectorXY) {
    class controls: controls {
        class Label: Label {};
        class IconX: IconX {};
        class EditX: EditX {
            w = QUOTE(POS_W(12.4/3));
        };
        class IconY: IconY {
            x = QUOTE(POS_W(11.3 + 12.4/3));
        };
        class EditY: EditY {
            x = QUOTE(POS_W(12.4 + 12.4/3));
            w = QUOTE(POS_W(12.4/3));
        };
        class IconZ: IconX {
            text = "$STR_3DEN_Axis_Z";
            x = QUOTE(POS_W(12.5 + 2 * 12.4/3));
            colorBackground[] = {0.26, 0.52, 0.92, 1};
        };
        class EditZ: EditX {
            idc = IDC_ROW_VECTOR_Z;
            x = QUOTE(POS_W(13.6 + 2 * 12.4/3));
            w = QUOTE(POS_W(12.4/3));
        };
    };
};
