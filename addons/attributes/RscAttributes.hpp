class RscText;
class RscEdit;
class ctrlCombo;
class ctrlToolbox;
class ctrlXSliderH;
class RscActivePicture;
class RscControlsGroup;
class RscControlsGroupNoScrollbars;

class RscDisplayAttributes {
    class Controls {
        class Background;
        class Title;
        class Content: RscControlsGroup {
            class controls;
        };
        class ButtonOK;
        class ButtonCancel;
    };
};

class RscMapControl;
class RscButtonMenu;
class RscButtonMenuCancel;
class RscButtonMenuOK;

class GVAR(RscAttributesBase) {
    idd = -1;
    movingEnable = 0;
    class controlsBackground {
        class Map: RscMapControl {
            idc = IDC_ATTRIBUTES_MAP;
            x = safeZoneXAbs;
            y = safeZoneY;
            w = safeZoneWAbs;
            h = safeZoneH;
            class CustomMark {
                icon = "#(argb,8,8,3)color(0,0,0,0)";
                color[] = {0, 0, 0, 0};
                importance = 0;
                coefMin = 0;
                coefMax = 0;
                size = 0;
            };
        };
    };
    class controls {
        class Title: RscText {
            idc = IDC_ATTRIBUTES_TITLE;
            font = "PuristaMedium";
            x = POS_X(6.5);
            y = POS_Y(8.4);
            w = POS_W(27);
            h = POS_H(1);
            colorBackground[] = GUI_BCG_COLOR;
        };
        class Background: RscText {
            idc = IDC_ATTRIBUTES_BACKGROUND;
            x = POS_X(6.5);
            y = POS_Y(9.5);
            w = POS_W(27);
            h = POS_H(6.5);
            colorBackground[] = {0, 0, 0, 0.7};
        };
        class Content: RscControlsGroup {
            idc = IDC_ATTRIBUTES_CONTENT;
            x = POS_X(7);
            y = POS_Y(10);
            w = POS_W(26);
            h = POS_H(5.5);
            class controls;
        };
        class ButtonOK: RscButtonMenuOK {
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
        class ButtonCustom1: RscButtonMenu {
            idc = IDC_ATTRIBUTES_CUSTOM_1;
            x = POS_X(23.4);
            y = POS_Y(16.1);
            w = POS_W(5);
            h = POS_H(1);
            colorBackground[] = GUI_BCG_COLOR;
        };
        class ButtonCustom2: ButtonCustom1 {
            idc = IDC_ATTRIBUTES_CUSTOM_2;
            x = POS_X(18.3);
        };
        class ButtonCustom3: ButtonCustom1 {
            idc = IDC_ATTRIBUTES_CUSTOM_3;
            x = POS_X(13.2);
        };
    };
};

class GVAR(RscLabel): RscText {
    idc = -1;
    x = 0;
    y = 0;
    w = 10 * GUI_GRID_W;
    h = GUI_GRID_H;
    colorBackground[] = {0, 0, 0, 0.5};
};

class GVAR(RscEdit): RscEdit {
    idc = -1;
    x = 10.1 * GUI_GRID_W;
    y = pixelH;
    w = 15.9 * GUI_GRID_W;
    h = GUI_GRID_H - pixelH;
    colorText[] = {1, 1, 1, 1};
    colorBackground[] = {0, 0, 0, 0.2};
};

class GVAR(RscCombo): ctrlCombo {
    idc = -1;
    x = 10.1 * GUI_GRID_W;
    y = 0;
    w = 15.9 * GUI_GRID_W;
    h = GUI_GRID_H;
    sizeEx = GUI_GRID_H;
    font = "RobotoCondensed";
};

class GVAR(RscAttributeName): RscControlsGroupNoScrollbars {
    idc = IDC_ATTRIBUTENAME;
    onSetFocus = QUOTE(_this call FUNC(ui_attributeName));
    x = 0;
    y = 0;
    w = 26 * GUI_GRID_W;
    h = GUI_GRID_H;
    class controls {
        class Label: GVAR(RscLabel) {
            text = "$STR_3DEN_Object_Attribute_UnitName_displayName";
        };
        class Edit: GVAR(RscEdit) {
            idc = IDC_ATTRIBUTENAME_EDIT;
        };
    };
};

class GVAR(RscAttributeGroupID): RscControlsGroupNoScrollbars {
    idc = IDC_ATTRIBUTEGROUPID;
    onSetFocus = QUOTE(_this call FUNC(ui_attributeGroupID));
    x = 0;
    y = 0;
    w = 26 * GUI_GRID_W;
    h = GUI_GRID_H;
    class controls {
        class Label: GVAR(RscLabel) {
            text = "$STR_A3_RscAttributeGroupID_Title";
        };
        class Edit: GVAR(RscEdit) {
            idc = IDC_ATTRIBUTEGROUPID_EDIT;
        };
    };
};

class GVAR(RscAttributeSkill): RscControlsGroupNoScrollbars {
    idc = IDC_ATTRIBUTESKILL;
    onSetFocus = QUOTE(_this call FUNC(ui_attributeSkill));
    x = 0;
    y = 0;
    w = 26 * GUI_GRID_W;
    h = GUI_GRID_H;
    class controls {
        class Label: GVAR(RscLabel) {
            text = "$STR_3DEN_Object_Attribute_Skill_displayName";
        };
        class Slider: ctrlXSliderH {
            idc = IDC_ATTRIBUTESKILL_SLIDER;
            x = 10.1 * GUI_GRID_W;
            y = 0;
            w = 13.5 * GUI_GRID_W;
            h = GUI_GRID_H;
        };
        class Edit: GVAR(RscEdit) {
            idc = IDC_ATTRIBUTESKILL_EDIT;
            x = 23.7 * GUI_GRID_W;
            w = 2.3 * GUI_GRID_W;
            canModify = 0;
        };
    };
};

class GVAR(RscAttributeDamage): RscControlsGroupNoScrollbars {
    idc = IDC_ATTRIBUTEDAMAGE;
    onSetFocus = QUOTE(_this call FUNC(ui_attributeDamage));
    x = 0;
    y = 0;
    w = 26 * GUI_GRID_W;
    h = GUI_GRID_H;
    class controls {
        class Label: GVAR(RscLabel) {
            text = "$STR_3DEN_Object_Attribute_Health_displayName";
        };
        class Slider: ctrlXSliderH {
            idc = IDC_ATTRIBUTEDAMAGE_SLIDER;
            x = 10.1 * GUI_GRID_W;
            y = 0;
            w = 13.5 * GUI_GRID_W;
            h = GUI_GRID_H;
        };
        class Edit: GVAR(RscEdit) {
            idc = IDC_ATTRIBUTEDAMAGE_EDIT;
            x = 23.7 * GUI_GRID_W;
            w = 2.3 * GUI_GRID_W;
            canModify = 0;
        };
    };
};

class GVAR(RscAttributeAmmo): RscControlsGroupNoScrollbars {
    idc = IDC_ATTRIBUTEAMMO;
    onSetFocus = "";
    x = 0;
    y = 0;
    w = 26 * GUI_GRID_W;
    h = GUI_GRID_H;
    class controls {
        class Label: GVAR(RscLabel) {
            text = "$STR_3DEN_Object_Attribute_Ammo_displayName";
        };
        class Slider: ctrlXSliderH {
            idc = IDC_ATTRIBUTEAMMO_SLIDER;
            x = 10.1 * GUI_GRID_W;
            y = 0;
            w = 13.5 * GUI_GRID_W;
            h = GUI_GRID_H;
        };
        class Edit: GVAR(RscEdit) {
            idc = IDC_ATTRIBUTEAMMO_EDIT;
            x = 23.7 * GUI_GRID_W;
            w = 2.3 * GUI_GRID_W;
            canModify = 0;
        };
    };
};

class GVAR(RscAttributeRank): RscControlsGroupNoScrollbars {
    idc = IDC_ATTRIBUTERANK;
    onSetFocus = QUOTE(_this call FUNC(ui_attributeRank));
    x = 0;
    y = 0;
    w = 26 * GUI_GRID_W;
    h = 2.5 * GUI_GRID_H;
    class controls {
        class Label: GVAR(RscLabel) {
            text = "$STR_3DEN_Object_Attribute_Rank_displayName";
            h = 2.5 * GUI_GRID_H;
        };
        class Background: RscText {
            idc = -1;
            x = 10 * GUI_GRID_W;
            y = 0;
            w = 16 * GUI_GRID_W;
            h = 2.5 * GUI_GRID_H;
            colorBackground[] = {1, 1, 1, 0.1};
        };
        class Private: RscActivePicture {
            idc = IDC_ATTRIBUTERANK_PRIVATE;
            text = "\a3\Ui_f\data\GUI\Cfg\Ranks\private_gs.paa";
            tooltip = "$STR_Private";
            x = 11.25 * GUI_GRID_W;
            y = 0.5 * GUI_GRID_H;
            w = 1.5 * GUI_GRID_W;
            h = 1.5 * GUI_GRID_H;
        };
        class Corporal: Private {
            idc = IDC_ATTRIBUTERANK_CORPORAL;
            text = "\a3\Ui_f\data\GUI\Cfg\Ranks\corporal_gs.paa";
            tooltip = "$STR_Corporal";
            x = 13.25 * GUI_GRID_W;
        };
        class Sergeant: Private {
            idc = IDC_ATTRIBUTERANK_SERGEANT;
            text = "\a3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
            tooltip = "$STR_Sergeant";
            x = 15.25 * GUI_GRID_W;
        };
        class Lieutenant: Private {
            idc = IDC_ATTRIBUTERANK_LIEUTENANT;
            text = "\a3\Ui_f\data\GUI\Cfg\Ranks\lieutenant_gs.paa";
            tooltip = "$STR_Lieutenant";
            x = 17.25 * GUI_GRID_W;
        };
        class Captain: Private {
            idc = IDC_ATTRIBUTERANK_CAPTAIN;
            text = "\a3\Ui_f\data\GUI\Cfg\Ranks\captain_gs.paa";
            tooltip = "$STR_Captain";
            x = 19.25 * GUI_GRID_W;
        };
        class Major: Private {
            idc = IDC_ATTRIBUTERANK_MAJOR;
            text = "\a3\Ui_f\data\GUI\Cfg\Ranks\major_gs.paa";
            tooltip = "$STR_Major";
            x = 21.25 * GUI_GRID_W;
        };
        class Colonel: Private {
            idc = IDC_ATTRIBUTERANK_COLONEL;
            text = "\a3\Ui_f\data\GUI\Cfg\Ranks\colonel_gs.paa";
            tooltip = "$STR_Colonel";
            x = 23.25 * GUI_GRID_W;
        };
    };
};

class GVAR(RscAttributeUnitPos): RscControlsGroupNoScrollbars {
    idc = IDC_ATTRIBUTEUNITPOS;
    onSetFocus = QUOTE(_this call FUNC(ui_attributeUnitPos));
    x = 0;
    y = 0;
    w = 26 * GUI_GRID_W;
    h = 2.5 * GUI_GRID_H;
    class controls {
        class Label: GVAR(RscLabel) {
            text = "$STR_A3_RscAttributeUnitPos_Title";
            h = 2.5 * GUI_GRID_H;
        };
        class Background: RscText {
            idc = -1;
            x = 10 * GUI_GRID_W;
            y = 0;
            w = 16 * GUI_GRID_W;
            h = 2.5 * GUI_GRID_H;
            colorBackground[] = {1, 1, 1, 0.1};
        };
        class Down: RscActivePicture {
            idc = IDC_ATTRIBUTEUNITPOS_DOWN;
            text = "\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_prone_ca.paa";
            tooltip = "$STR_A3_RscAttributeUnitPos_Down_tooltip";
            x = 13.25 * GUI_GRID_W;
            y = 0;
            w = 2.5 * GUI_GRID_W;
            h = 2.5 * GUI_GRID_H;
        };
        class Crouch: Down {
            idc = IDC_ATTRIBUTEUNITPOS_CROUCH;
            text = "\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_crouch_ca.paa";
            tooltip = "$STR_A3_RscAttributeUnitPos_Crouch_tooltip";
            x = 15.75 * GUI_GRID_W;
        };
        class Up: Down {
            idc = IDC_ATTRIBUTEUNITPOS_UP;
            text = "\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_stand_ca.paa";
            tooltip = "$STR_A3_RscAttributeUnitPos_Up_tooltip";
            x = 18.25 * GUI_GRID_W;
        };
        class Auto: Down {
            idc = IDC_ATTRIBUTEUNITPOS_AUTO;
            text = "\a3\ui_f_curator\Data\default_ca.paa";
            tooltip = "$STR_A3_RscAttributeUnitPos_Auto_tooltip";
            x = 24 * GUI_GRID_W;
            y = 0.5 * GUI_GRID_H;
            w = 1.5 * GUI_GRID_W;
            h = 1.5 * GUI_GRID_H;
        };
    };
};

class GVAR(RscAttributeRespawnPosition): RscControlsGroupNoScrollbars {
    idc = IDC_ATTRIBUTERESPAWNPOSITION;
    onSetFocus = "";
    x = 0;
    y = 0;
    w = 26 * GUI_GRID_W;
    h = 2.5 * GUI_GRID_H;
    class controls {
        class Label: GVAR(RscLabel) {
            text = "$STR_A3_RscAttributeRespawnPosition_Title";
            h = 2.5 * GUI_GRID_H;
        };
        class Background: RscText {
            idc = -1;
            x = 10 * GUI_GRID_W;
            y = 0;
            w = 16 * GUI_GRID_W;
            h = 2.5 * GUI_GRID_H;
            colorBackground[] = {1, 1, 1, 0.1};
        };
        class West: RscActivePicture {
            idc = IDC_ATTRIBUTERESPAWNPOSITION_WEST;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeRespawnPosition\west_ca.paa";
            tooltip = "$STR_WEST";
            x = 12.25 * GUI_GRID_W;
            y = 0.25 * GUI_GRID_H;
            w = 2 * GUI_GRID_W;
            h = 2 * GUI_GRID_H;
        };
        class East: West {
            idc = IDC_ATTRIBUTERESPAWNPOSITION_EAST;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeRespawnPosition\east_ca.paa";
            tooltip = "$STR_EAST";
            x = 14.75 * GUI_GRID_W;
        };
        class Guer: West {
            idc = IDC_ATTRIBUTERESPAWNPOSITION_GUER;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeRespawnPosition\guer_ca.paa";
            tooltip = "$STR_guerrila";
            x = 17.25 * GUI_GRID_W;
        };
        class Civ: West {
            idc = IDC_ATTRIBUTERESPAWNPOSITION_CIV;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeRespawnPosition\civ_ca.paa";
            tooltip = "$STR_Civilian";
            x = 19.75 * GUI_GRID_W;
        };
        class Disabled: West {
            idc = IDC_ATTRIBUTERESPAWNPOSITION_DISABLED;
            text = "\a3\Ui_F_Curator\Data\default_ca.paa";
            tooltip = "$STR_sensoractiv_none";
            x = 24 * GUI_GRID_W;
            y = 0.5 * GUI_GRID_H;
            w = 1.5 * GUI_GRID_W;
            h = 1.5 * GUI_GRID_H;
        };
    };
};

class GVAR(RscAttributeFormation): RscControlsGroupNoScrollbars {
    idc = IDC_ATTRIBUTEFORMATION;
    onSetFocus = QUOTE(_this call FUNC(ui_attributeFormation));
    x = 0;
    y = 0;
    w = 26 * GUI_GRID_W;
    h = 5 * GUI_GRID_H;
    class controls {
        class Label: GVAR(RscLabel) {
            text = "$STR_3DEN_Group_Attribute_Formation_displayName";
            h = 5 * GUI_GRID_H;
        };
        class Background: RscText {
            idc = -1;
            x = 10 * GUI_GRID_W;
            y = 0;
            w = 16 * GUI_GRID_W;
            h = 5 * GUI_GRID_H;
            colorBackground[] = {1, 1, 1, 0.1};
        };
        class Wedge: RscActivePicture {
            idc = IDC_ATTRIBUTEFORMATION_WEDGE;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\wedge_ca.paa";
            tooltip = "$STR_wedge";
            x = 11.75 * GUI_GRID_W;
            y = 0;
            w = 2.5 * GUI_GRID_W;
            h = 2.5 * GUI_GRID_H;
        };
        class Vee: Wedge {
            idc = IDC_ATTRIBUTEFORMATION_VEE;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\vee_ca.paa";
            tooltip = "$STR_vee";
            x = 14.25 * GUI_GRID_W;
        };
        class Line: Wedge {
            idc = IDC_ATTRIBUTEFORMATION_LINE;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\line_ca.paa";
            tooltip = "$STR_line";
            x = 16.75 * GUI_GRID_W;
        };
        class Column: Wedge {
            idc = IDC_ATTRIBUTEFORMATION_COLUMN;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\column_ca.paa";
            tooltip = "$STR_column";
            x = 19.25 * GUI_GRID_W;
        };
        class File: Wedge {
            idc = IDC_ATTRIBUTEFORMATION_FILE;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\file_ca.paa";
            tooltip = "$STR_file";
            x = 21.75 * GUI_GRID_W;
        };
        class StagColumn: Wedge {
            idc = IDC_ATTRIBUTEFORMATION_STAGCOLUMN;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\stag_column_ca.paa";
            tooltip = "$STR_staggered";
            x = 11.75 * GUI_GRID_W;
            y = 2.5 * GUI_GRID_H;
        };
        class EchLeft: StagColumn {
            idc = IDC_ATTRIBUTEFORMATION_ECHLEFT;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\ech_left_ca.paa";
            tooltip = "$STR_echl";
            x = 14.25 * GUI_GRID_W;
        };
        class EchRight: StagColumn {
            idc = IDC_ATTRIBUTEFORMATION_ECHRIGHT;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\ech_right_ca.paa";
            tooltip = "$STR_echr";
            x = 16.75 * GUI_GRID_W;
        };
        class Diamond: StagColumn {
            idc = IDC_ATTRIBUTEFORMATION_DIAMOND;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\diamond_ca.paa";
            tooltip = "$STR_diamond";
            x = 19.25 * GUI_GRID_W;
        };
        class Default: StagColumn {
            idc = IDC_ATTRIBUTEFORMATION_DEFAULT;
            text = "\a3\ui_f_curator\Data\default_ca.paa";
            tooltip = "$STR_no_change";
            x = 22.25 * GUI_GRID_W;
            y = 3 * GUI_GRID_H;
            w = 1.5 * GUI_GRID_W;
            h = 1.5 * GUI_GRID_H;
        };
    };
};

class GVAR(RscAttributeBehaviour): RscControlsGroupNoScrollbars {
    idc = IDC_ATTRIBUTEBEHAVIOUR;
    onSetFocus = QUOTE(_this call FUNC(ui_attributeBehaviour));
    x = 0;
    y = 0;
    w = 26 * GUI_GRID_W;
    h = 2.5 * GUI_GRID_H;
    class controls {
        class Label: GVAR(RscLabel) {
            text = "$STR_3DEN_Group_Attribute_Behaviour_displayName";
            h = 2.5 * GUI_GRID_H;
        };
        class Background: RscText {
            idc = -1;
            x = 10 * GUI_GRID_W;
            y = 0;
            w = 16 * GUI_GRID_W;
            h = 2.5 * GUI_GRID_H;
            colorBackground[] = {1, 1, 1, 0.1};
        };
        class Careless: RscActivePicture {
            idc = IDC_ATTRIBUTEBEHAVIOUR_CARELESS;
            text = QPATHTOF(UI\careless_ca.paa);
            tooltip = "$STR_3DEN_Attributes_Behaviour_Careless_text";
            x = 11.25 * GUI_GRID_W;
            y = 0.5 * GUI_GRID_H;
            w = 1.5 * GUI_GRID_W;
            h = 1.5 * GUI_GRID_H;
        };
        class Safe: Careless {
            idc = IDC_ATTRIBUTEBEHAVIOUR_SAFE;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeBehaviour\safe_ca.paa";
            tooltip = "$STR_safe";
            x = 13.75 * GUI_GRID_W;
        };
        class Aware: Careless {
            idc = IDC_ATTRIBUTEBEHAVIOUR_AWARE;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeBehaviour\aware_ca.paa";
            tooltip = "$STR_aware";
            x = 16.25 * GUI_GRID_W;
        };
        class Combat: Careless {
            idc = IDC_ATTRIBUTEBEHAVIOUR_COMBAT;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeBehaviour\combat_ca.paa";
            tooltip = "$STR_combat";
            x = 18.75 * GUI_GRID_W;
        };
        class Stealth: Careless {
            idc = IDC_ATTRIBUTEBEHAVIOUR_STEALTH;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeBehaviour\stealth_ca.paa";
            tooltip = "$STR_stealth";
            x = 21.25 * GUI_GRID_W;
        };
        class Default: Careless {
            idc = IDC_ATTRIBUTEBEHAVIOUR_DEFAULT;
            text = "\a3\ui_f_curator\Data\default_ca.paa";
            tooltip = "$STR_combat_unchanged";
            x = 24 * GUI_GRID_W;
        };
    };
};

class GVAR(RscAttributeSpeedMode): RscControlsGroupNoScrollbars {
    idc = IDC_ATTRIBUTESPEEDMODE;
    onSetFocus = QUOTE(_this call FUNC(ui_attributeSpeedMode));
    x = 0;
    y = 0;
    w = 26 * GUI_GRID_W;
    h = 2.5 * GUI_GRID_H;
    class controls {
        class Label: GVAR(RscLabel) {
            text = "$STR_HC_Menu_Speed";
            h = 2.5 * GUI_GRID_H;
        };
        class Background: RscText {
            idc = -1;
            x = 10 * GUI_GRID_W;
            y = 0;
            w = 16 * GUI_GRID_W;
            h = 2.5 * GUI_GRID_H;
            colorBackground[] = {1, 1, 1, 0.1};
        };
        class Limited: RscActivePicture {
            idc = IDC_ATTRIBUTESPEEDMODE_LIMITED;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeSpeedMode\limited_ca.paa";
            tooltip = "$STR_speed_limited";
            x = 13.25 * GUI_GRID_W;
            y = 0;
            w = 2.5 * GUI_GRID_W;
            h = 2.5 * GUI_GRID_H;
        };
        class Normal: Limited {
            idc = IDC_ATTRIBUTESPEEDMODE_NORMAL;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeSpeedMode\normal_ca.paa";
            tooltip = "$STR_speed_normal";
            x = 15.75 * GUI_GRID_W;
        };
        class Full: Limited {
            idc = IDC_ATTRIBUTESPEEDMODE_FULL;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeSpeedMode\full_ca.paa";
            tooltip = "$STR_speed_full";
            x = 18.25 * GUI_GRID_W;
        };
        class Default: Limited {
            idc = IDC_ATTRIBUTESPEEDMODE_DEFAULT;
            text = "\a3\ui_f_curator\Data\default_ca.paa";
            tooltip = "$STR_speed_unchanged";
            x = 24 * GUI_GRID_W;
            y = 0.5 * GUI_GRID_H;
            w = 1.5 * GUI_GRID_W;
            h = 1.5 * GUI_GRID_H;
        };
    };
};

class GVAR(RscAttributeWaypointType): RscControlsGroupNoScrollbars {
    idc = IDC_ATTRIBUTEWAYPOINTTYPE;
    onSetFocus = QUOTE(_this call FUNC(ui_attributeWaypointType));
    x = 0;
    y = 0;
    w = 26 * GUI_GRID_W;
    h = 5 * GUI_GRID_H;
    class controls {
        class Label: GVAR(RscLabel) {
            text = "$STR_3DEN_Object_Attribute_Type_displayName";
            w = 26 * GUI_GRID_H;
        };
        class Background: RscText {
            idc = IDC_ATTRIBUTEWAYPOINTTYPE_BACKGROUND;
            style = ST_CENTER;
            x = 0;
            y = GUI_GRID_H;
            w = 26 * GUI_GRID_W;
            h = 4 * GUI_GRID_H;
            colorText[] = {1, 1, 1, 0.5};
            colorBackground[] = {1, 1, 1, 0.1};
        };
        class Toolbox: ctrlToolbox {
            idc = IDC_ATTRIBUTEWAYPOINTTYPE_TOOLBOX;
            x = 0;
            y = GUI_GRID_H;
            w = 26 * GUI_GRID_W;
            h = 4 * GUI_GRID_H;
            colorBackground[] = {0, 0, 0, 0};
            rows = 4;
            columns = 3;
            strings[] = {
                "$STR_ac_move",
                "$STR_ac_cycle",
                "$STR_ac_seekanddestroy",
                "$STR_ac_hold",
                "$STR_ac_sentry",
                "$STR_ac_getout",
                "$STR_ac_unload",
                "$STR_ac_transportunload",
                "$STR_A3_CfgWaypoints_Land",
                "$STR_ac_hook",
                "$STR_ac_unhook",
                "$STR_A3_Functions_F_Orange_Demine"
            };
        };
    };
};

class GVAR(RscAttributeMarkerText): RscControlsGroupNoScrollbars {
    idc = IDC_ATTRIBUTEMARKERTEXT;
    onSetFocus = QUOTE(_this call FUNC(ui_attributeMarkerText));
    x = 0;
    y = 0;
    w = 26 * GUI_GRID_W;
    h = GUI_GRID_H;
    class controls {
        class Label: GVAR(RscLabel) {
            text = "$STR_3DEN_Marker_Attribute_Text_displayName";
        };
        class Edit: GVAR(RscEdit) {
            idc = IDC_ATTRIBUTEMARKERTEXT_EDIT;
        };
    };
};

class GVAR(RscAttributeMarkerColor): RscControlsGroupNoScrollbars {
    idc = IDC_ATTRIBUTEMARKERCOLOR;
    onSetFocus = QUOTE(_this call FUNC(ui_attributeMarkerColor));
    x = 0;
    y = 0;
    w = 26 * GUI_GRID_W;
    h = GUI_GRID_H;
    class controls {
        class Label: GVAR(RscLabel) {
            text = "$STR_3DEN_Marker_Attribute_Color_displayName";
        };
        class Combo: GVAR(RscCombo) {
            idc = IDC_ATTRIBUTEMARKERCOLOR_COMBO;
        };
    };
};

class GVAR(RscAttributesMan): GVAR(RscAttributesBase) {
    onLoad = QUOTE([ARR_2(_this select 0, QQGVAR(RscAttributesMan))] call FUNC(initAttributesDisplay));
    filterAttributes = 1;
    class Controls: Controls {
        class Background: Background {};
        class Title: Title {};
        class Content: Content {
            class Controls {
                class Name: GVAR(RscAttributeName) {};
                class Skill: GVAR(RscAttributeSkill) {};
                class Damage: GVAR(RscAttributeDamage) {};
                class Ammo: GVAR(RscAttributeAmmo) {};
                class Rank: GVAR(RscAttributeRank) {};
                class UnitPos: GVAR(RscAttributeUnitPos) {};
                class RespawnPosition: GVAR(RscAttributeRespawnPosition) {};
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};

class GVAR(RscAttributesGroup): GVAR(RscAttributesBase) {
    onLoad = QUOTE([ARR_2(_this select 0, QQGVAR(RscAttributesGroup))] call FUNC(initAttributesDisplay));
    filterAttributes = 1;
    class Controls: Controls {
        class Background: Background {};
        class Title: Title {};
        class Content: Content {
            class Controls {
                class GroupID: GVAR(RscAttributeGroupID) {};
                class Skill: GVAR(RscAttributeSkill) {};
                class Formation: GVAR(RscAttributeFormation) {};
                class Behaviour: GVAR(RscAttributeBehaviour) {};
                class SpeedMode: GVAR(RscAttributeSpeedMode) {};
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};

class GVAR(RscAttributesWaypoint): GVAR(RscAttributesBase) {
    onLoad = QUOTE([ARR_2(_this select 0, QQGVAR(RscAttributesWaypoint))] call FUNC(initAttributesDisplay));
    filterAttributes = 1;
    class Controls: Controls {
        class Background: Background {};
        class Title: Title {};
        class Content: Content {
            class Controls {
                class WaypointType: GVAR(RscAttributeWaypointType) {};
                class Formation: GVAR(RscAttributeFormation) {};
                class Behaviour: GVAR(RscAttributeBehaviour) {};
                class SpeedMode: GVAR(RscAttributeSpeedMode) {};
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};

class GVAR(RscAttributesMarker): GVAR(RscAttributesBase) {
    onLoad = QUOTE([ARR_2(_this select 0, QQGVAR(RscAttributesMarker))] call FUNC(initAttributesDisplay));
    filterAttributes = 1;
    class Controls: Controls {
        class Background: Background {};
        class Title: Title {};
        class Content: Content {
            class Controls {
                class MarkerText: GVAR(RscAttributeMarkerText) {};
                class MarkerColor: GVAR(RscAttributeMarkerColor) {};
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};
