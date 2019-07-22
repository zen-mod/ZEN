class RscText;
class RscEdit;
class RscCheckBox;
class ctrlToolbox;
class ctrlXSliderH;
class RscActivePicture;
class RscControlsGroup;
class RscControlsGroupNoScrollbars;
class RscButtonMenuOK;
class RscButtonMenuCancel;
class RscCombo {
    class ComboScrollBar;
};
class RscListBox {
    class ListScrollBar;
};

class GVAR(RscEdit): RscEdit {
    colorText[] = {1, 1, 1, 1};
    colorBackground[] = {0, 0, 0, 0.2};
};

class GVAR(RscCheckbox): RscCheckBox {
    soundEnter[] = {"\a3\ui_f\data\Sound\RscButtonMenu\soundEnter", 0.09, 1};
    soundPush[] = {"\a3\ui_f\data\Sound\RscButtonMenu\soundPush", 0.09, 1};
    soundClick[] = {"\a3\ui_f\data\Sound\RscButtonMenu\soundClick", 0.09, 1};
    soundEscape[] = {"\a3\ui_f\data\Sound\RscButtonMenu\soundEscape", 0.09, 1};
};

class GVAR(RscCombo): RscCombo {
    arrowEmpty = "\a3\3DEN\Data\Controls\ctrlCombo\arrowEmpty_ca.paa";
    arrowFull = "\a3\3DEN\Data\Controls\ctrlCombo\arrowFull_ca.paa";
    class ComboScrollBar: ComboScrollBar {
        arrowEmpty = "\a3\3DEN\Data\Controls\ctrlDefault\arrowEmpty_ca.paa";
        arrowFull = "\a3\3DEN\Data\Controls\ctrlDefault\arrowFull_ca.paa";
        border = "\a3\3DEN\Data\Controls\ctrlDefault\border_ca.paa";
        thumb = "\a3\3DEN\Data\Controls\ctrlDefault\thumb_ca.paa";
    };
};

class GVAR(RscListBox): RscListBox {
    class ListScrollBar: ListScrollBar {
        arrowEmpty = "\a3\3DEN\Data\Controls\ctrlDefault\arrowEmpty_ca.paa";
        arrowFull = "\a3\3DEN\Data\Controls\ctrlDefault\arrowFull_ca.paa";
        border = "\a3\3DEN\Data\Controls\ctrlDefault\border_ca.paa";
        thumb = "\a3\3DEN\Data\Controls\ctrlDefault\thumb_ca.paa";
    };
};

class GVAR(display) {
    idd = -1;
    movingEnable = 1;
    enableSimulation = 1;
    onLoad = QUOTE(with uiNamespace do {GVAR(display) = _this select 0});
    class controls {
        class Title: RscText {
            idc = IDC_TITLE;
            x = POS_X(6.5);
            y = POS_TITLE_Y(MIN_HEIGHT);
            w = POS_W(27);
            h = POS_H(1);
            colorBackground[] = GUI_THEME_COLOR;
            moving = 1;
        };
        class Background: RscText {
            idc = IDC_BACKGROUND;
            x = POS_X(6.5);
            y = POS_BACKGROUND_Y(MIN_HEIGHT);
            w = POS_W(27);
            h = POS_BACKGROUND_H(MIN_HEIGHT);
            colorBackground[] = {0, 0, 0, 0.7};
        };
        class Content: RscControlsGroup {
            idc = IDC_CONTENT;
            x = POS_X(7);
            y = POS_CONTENT_Y(MIN_HEIGHT);
            w = POS_W(26);
            h = MIN_HEIGHT;
        };
        class ButtonOK: RscButtonMenuOK {
            idc = IDC_BTN_OK;
            x = POS_X(28.5);
            y = POS_BUTTON_Y(MIN_HEIGHT);
            w = POS_W(5);
            h = POS_H(1);
        };
        class ButtonCancel: RscButtonMenuCancel {
            idc = IDC_BTN_CANCEL;
            x = POS_X(6.5);
            y = POS_BUTTON_Y(MIN_HEIGHT);
            w = POS_W(5);
            h = POS_H(1);
        };
    };
};

class GVAR(Row_Base): RscControlsGroupNoScrollbars {
    GVAR(script) = "";
    x = 0;
    y = 0;
    w = POS_W(26);
    h = POS_H(1);
    class controls {
        class Name: RscText {
            idc = IDC_ROW_NAME;
            x = 0;
            y = 0;
            w = POS_W(10);
            h = POS_H(1);
            colorBackground[] = {0, 0, 0, 0.5};
        };
    };
};

class GVAR(Row_Checkbox): GVAR(Row_Base) {
    GVAR(script) = QFUNC(gui_checkbox);
    class controls: controls {
        class Name: Name {};
        class Checkbox: GVAR(RscCheckbox) {
            idc = IDC_ROW_CHECKBOX;
            x = POS_W(10.1);
            y = 0;
            w = POS_W(1);
            h = POS_H(1);
        };
    };
};

class GVAR(Row_Edit): GVAR(Row_Base) {
    GVAR(script) = QFUNC(gui_edit);
    class controls: controls {
        class Name: Name {};
        class Edit: GVAR(RscEdit) {
            idc = IDC_ROW_EDIT;
            x = POS_W(10.1);
            y = pixelH;
            w = POS_W(15.9);
            h = POS_H(1) - pixelH;
        };
    };
};

class GVAR(Row_EditMulti): GVAR(Row_Edit) {
    class controls: controls {
        class Name: Name {
            x = 0;
            w = POS_W(26);
        };
        class Edit: Edit {
            style = ST_MULTI;
            x = pixelW;
            y = POS_H(1);
            w = POS_W(26) - pixelW;
            h = POS_H(5);
        };
    };
};

class GVAR(Row_EditCode): GVAR(Row_EditMulti) {
    class controls: controls {
        class Name: Name {};
        class Edit: Edit {
            font = "EtelkaMonospacePro";
            sizeEx = POS_H(0.7);
            autocomplete = "scripting";
        };
    };
};

class GVAR(Row_Combo): GVAR(Row_Base) {
    GVAR(script) = QFUNC(gui_combo);
    class controls: controls {
        class Name: Name {};
        class Combo: GVAR(RscCombo) {
            idc = IDC_ROW_COMBO;
            x = POS_W(10.1);
            y = 0;
            w = POS_W(15.9);
            h = POS_H(1);
        };
    };
};

class GVAR(Row_List): GVAR(Row_Base) {
    GVAR(script) = QFUNC(gui_list);
    h = POS_H(7);
    class controls: controls {
        class Name: Name {
            x = 0;
            w = POS_W(26);
        };
        class List: GVAR(RscListBox) {
            idc = IDC_ROW_LIST;
            x = 0;
            y = POS_H(1);
            w = POS_W(26);
            h = POS_H(6);
        };
    };
};

class GVAR(Row_Toolbox): GVAR(Row_Base) {
    GVAR(script) = QFUNC(gui_toolbox);
    class controls: controls {
        class Name: Name {};
        /* Toolbox created through script */
    };
};

class GVAR(RscToolbox): ctrlToolbox {
    idc = IDC_ROW_TOOLBOX;
    x = POS_W(10.1);
    y = 0;
    w = POS_W(15.9);
    h = POS_H(1);

    tooltipColorBox[] = {0, 0, 0, 0};
    tooltipColorText[] = {0, 0, 0, 0};
    tooltipColorShade[] = {0, 0, 0, 0};

    rows = QUOTE(call compile getText (configFile >> QQGVAR(RscToolbox) >> QQGVAR(rows)));
    GVAR(rows) = QUOTE(missionNamespace getVariable [ARR_2(QQGVAR(toolboxRows),1)]);

    columns = QUOTE(call compile getText (configFile >> QQGVAR(RscToolbox) >> QQGVAR(columns)));
    GVAR(columns) = QUOTE(missionNamespace getVariable [ARR_2(QQGVAR(toolboxColumns),2)]);
};

class GVAR(Row_Slider): GVAR(Row_Base) {
    GVAR(script) = QFUNC(gui_slider);
    class controls: controls {
        class Name: Name {};
        class Slider: ctrlXSliderH {
            idc = IDC_ROW_SLIDER;
            x = POS_W(10.1);
            y = 0;
            w = POS_W(13.5);
            h = POS_H(1);
        };
        class Edit: GVAR(RscEdit) {
            idc = IDC_ROW_SLIDER_EDIT;
            x = POS_W(23.7);
            y = pixelH;
            w = POS_W(2.3);
            h = POS_H(1) - pixelH;
        };
    };
};

class GVAR(Row_Sides): GVAR(Row_Base) {
    GVAR(script) = QFUNC(gui_sides);
    h = POS_H(2.5);
    class controls: controls {
        class Name: Name {
            h = POS_H(2.5);
        };
        class Background: RscText {
            idc = -1;
            x = POS_W(10);
            y = 0;
            w = POS_W(16);
            h = POS_H(2.5);
            SET_BACKGROUND_COLOR;
        };
        class BLUFOR: RscActivePicture {
            idc = IDC_ROW_SIDES_BLUFOR;
            text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_west_ca.paa";
            tooltip = "$STR_WEST";
            x = POS_W(12.5);
            y = POS_H(0.25);
            w = POS_W(2);
            h = POS_H(2);
        };
        class OPFOR: BLUFOR {
            idc = IDC_ROW_SIDES_OPFOR;
            text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_east_ca.paa";
            tooltip = "$STR_EAST";
            x = POS_W(15.5);
        };
        class Independent: BLUFOR {
            idc = IDC_ROW_SIDES_INDEPENDENT;
            text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_guer_ca.paa";
            tooltip = "$STR_guerrila";
            x = POS_W(18.5);
        };
        class Civilian: BLUFOR {
            idc = IDC_ROW_SIDES_CIVILIAN;
            text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_civ_ca.paa";
            tooltip = "$STR_civilian";
            x = POS_W(21.5);
        };
    };
};

class GVAR(Row_ColorRGB): GVAR(Row_Base) {
    GVAR(script) = QFUNC(gui_color);
    h = POS_H(3);
    class controls: controls {
        class Name: Name {
            h = POS_H(3);
        };
        class Preview: RscText {
            idc = IDC_ROW_COLOR_PREVIEW;
            x = POS_W(6.5);
            y = POS_H(0.5);
            w = POS_W(3);
            h = POS_H(2);
        };
        class Red: ctrlXSliderH {
            idc = IDC_ROW_COLOR_RED;
            x = POS_W(10.1);
            y = 0;
            w = POS_W(13.8);
            h = POS_H(1);
            color[] = {1, 0, 0, 0.6};
            colorActive[] = {1, 0, 0, 1};
        };
        class Red_Edit: GVAR(RscEdit) {
            idc = IDC_ROW_COLOR_RED_EDIT;
            x = POS_W(24);
            y = 0;
            w = POS_W(2);
            h = POS_H(1);
        };
        class Green: Red {
            idc = IDC_ROW_COLOR_GREEN;
            y = POS_H(1);
            color[] = {0, 1, 0, 0.6};
            colorActive[] = {0, 1, 0, 1};
        };
        class Green_Edit: Red_Edit {
            idc = IDC_ROW_COLOR_GREEN_EDIT;
            y = POS_H(1);
        };
        class Blue: Red {
            idc = IDC_ROW_COLOR_BLUE;
            y = POS_H(2);
            color[] = {0, 0, 1, 0.6};
            colorActive[] = {0, 0, 1, 1};
        };
        class Blue_Edit: Red_Edit {
            idc = IDC_ROW_COLOR_BLUE_EDIT;
            y = POS_H(2);
        };
    };
};

class GVAR(Row_ColorRGBA): GVAR(Row_ColorRGB) {
    h = POS_H(4);
    class controls: controls {
        class Name: Name {
            h = POS_H(4);
        };
        class Preview: Preview {
            h = POS_H(3);
        };
        class Red: Red {};
        class Red_Edit: Red_Edit {};
        class Green: Green {};
        class Green_Edit: Green_Edit {};
        class Blue: Blue {};
        class Blue_Edit: Blue_Edit {};
        class Alpha: Red {
            idc = IDC_ROW_COLOR_ALPHA;
            y = POS_H(3);
            color[] = {1, 1, 1, 0.6};
            colorActive[] = {1, 1, 1, 1};
        };
        class Alpha_Edit: Red_Edit {
            idc = IDC_ROW_COLOR_ALPHA_EDIT;
            y = POS_H(3);
        };
    };
};

class GVAR(Row_VectorXY): GVAR(Row_Base) {
    GVAR(script) = QFUNC(gui_vector);
    class controls: controls {
        class Name: Name {};
        class IconX: RscText {
            idc = -1;
            style = ST_CENTER;
            text = "$STR_3DEN_Axis_X";
            x = POS_W(10.1);
            y = 0;
            w = POS_W(1);
            h = POS_H(1);
            font = "RobotoCondensedLight";
            colorBackground[] = {0.77, 0.18, 0.1, 1};
            shadow = 0;
        };
        class EditX: GVAR(RscEdit) {
            idc = IDC_ROW_VECTOR_X;
            x = POS_W(11.2);
            y = pixelH;
            w = POS_W(6.8);
            h = POS_H(1) - pixelH;
        };
        class IconY: IconX {
            text = "$STR_3DEN_Axis_Y";
            x = POS_W(18.1);
            colorBackground[] = {0.58, 0.82, 0.22, 1};
        };
        class EditY: EditX {
            idc = IDC_ROW_VECTOR_Y;
            x = POS_W(19.2);
        };
    };
};

class GVAR(Row_VectorXYZ): GVAR(Row_VectorXY) {
    class controls: controls {
        class Name: Name {};
        class IconX: IconX {};
        class EditX: EditX {
            w = POS_W(12.4/3);
        };
        class IconY: IconY {
            x = POS_W(11.3 + 12.4/3);
        };
        class EditY: EditY {
            x = POS_W(12.4 + 12.4/3);
            w = POS_W(12.4/3);
        };
        class IconZ: IconX {
            text = "$STR_3DEN_Axis_Z";
            x = POS_W(12.5 + 2 * 12.4/3);
            colorBackground[] = {0.26, 0.52, 0.92, 1};
        };
        class EditZ: EditX {
            idc = IDC_ROW_VECTOR_Z;
            x = POS_W(13.6 + 2 * 12.4/3);
            w = POS_W(12.4/3);
        };
    };
};
