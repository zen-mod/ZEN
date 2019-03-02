class RscText;
class RscEdit;
class ctrlToolbox;
class ctrlXSliderH;
class RscActivePicture;
class RscControlsGroup;
class RscControlsGroupNoScrollbars;
class RscMapControl;
class RscButtonMenu;
class RscButtonMenuCancel;
class RscButtonMenuOK;
class RscCombo {
    class ComboScrollBar;
};

class GVAR(RscLabel): RscText {
    idc = -1;
    x = 0;
    y = 0;
    w = POS_W(10);
    h = POS_H(1);
    colorBackground[] = {0, 0, 0, 0.5};
};

class GVAR(RscEdit): RscEdit {
    idc = -1;
    x = POS_W(10.1);
    y = pixelH;
    w = POS_W(15.9);
    h = POS_H(1) - pixelH;
    colorText[] = {1, 1, 1, 1};
    colorBackground[] = {0, 0, 0, 0.2};
};

class GVAR(RscCombo): RscCombo {
    idc = -1;
    x = POS_W(10.1);
    y = 0;
    w = POS_W(15.9);
    h = POS_H(1);
    arrowEmpty = "\a3\3DEN\Data\Controls\ctrlCombo\arrowEmpty_ca.paa";
    arrowFull = "\a3\3DEN\Data\Controls\ctrlCombo\arrowFull_ca.paa";
    class ComboScrollBar: ComboScrollBar {
        arrowEmpty = "\a3\3DEN\Data\Controls\ctrlDefault\arrowEmpty_ca.paa";
        arrowFull = "\a3\3DEN\Data\Controls\ctrlDefault\arrowFull_ca.paa";
        border = "\a3\3DEN\Data\Controls\ctrlDefault\border_ca.paa";
        thumb = "\a3\3DEN\Data\Controls\ctrlDefault\thumb_ca.paa";
    };
};

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

class GVAR(RscAttributeName): RscControlsGroupNoScrollbars {
    idc = IDC_ATTRIBUTENAME;
    onSetFocus = QUOTE(_this call FUNC(attributeName));
    x = 0;
    y = 0;
    w = POS_W(26);
    h = POS_H(1);
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
    onSetFocus = QUOTE(_this call FUNC(attributeGroupID));
    x = 0;
    y = 0;
    w = POS_W(26);
    h = POS_H(1);
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
    idc = IDC_SKILL_GROUP;
    onSetFocus = QUOTE(_this call FUNC(attributeSkill));
    x = 0;
    y = 0;
    w = POS_W(26);
    h = POS_H(1);
    class controls {
        class Label: GVAR(RscLabel) {
            text = "$STR_3DEN_Object_Attribute_Skill_displayName";
        };
        class Slider: ctrlXSliderH {
            idc = IDC_SKILL_SLIDER;
            x = POS_W(10.1);
            y = 0;
            w = POS_W(13.5);
            h = POS_H(1);
        };
        class Edit: GVAR(RscEdit) {
            idc = IDC_SKILL_EDIT;
            x = POS_W(23.7);
            w = POS_W(2.3);
        };
    };
};

class GVAR(RscAttributeDamage): GVAR(RscAttributeSkill) {
    idc = IDC_DAMAGE_GROUP;
    onSetFocus = QUOTE(_this call FUNC(attributeDamage));
    class controls: controls {
        class Label: Label {
            text = "$STR_3DEN_Object_Attribute_Health_displayName";
        };
        class Slider: Slider {
            idc = IDC_DAMAGE_SLIDER;
        };
        class Edit: Edit {
            idc = IDC_DAMAGE_EDIT;
        };
    };
};

class GVAR(RscAttributeFuel): GVAR(RscAttributeSkill) {
    idc = IDC_FUEL_GROUP;
    onSetFocus = QUOTE(_this call FUNC(attributeFuel));
    class controls: controls {
        class Label: Label {
            text = "$STR_3DEN_Object_Attribute_Fuel_displayName";
        };
        class Slider: Slider {
            idc = IDC_FUEL_SLIDER;
        };
        class Edit: Edit {
            idc = IDC_FUEL_EDIT;
        };
    };
};

class GVAR(RscAttributeAmmo): RscControlsGroupNoScrollbars {
    idc = IDC_ATTRIBUTEAMMO;
    onSetFocus = "";
    x = 0;
    y = 0;
    w = POS_W(26);
    h = POS_H(1);
    class controls {
        class Label: GVAR(RscLabel) {
            text = "$STR_3DEN_Object_Attribute_Ammo_displayName";
        };
        class Slider: ctrlXSliderH {
            idc = IDC_ATTRIBUTEAMMO_SLIDER;
            x = POS_W(10.1);
            y = 0;
            w = POS_W(13.5);
            h = POS_H(1);
        };
        class Edit: GVAR(RscEdit) {
            idc = IDC_ATTRIBUTEAMMO_EDIT;
            x = POS_W(23.7);
            w = POS_W(2.3);
            canModify = 0;
        };
    };
};

class GVAR(RscAttributeRank): RscControlsGroupNoScrollbars {
    idc = IDC_ATTRIBUTERANK;
    onSetFocus = QUOTE(_this call FUNC(attributeRank));
    x = 0;
    y = 0;
    w = POS_W(26);
    h = POS_H(2.5);
    class controls {
        class Label: GVAR(RscLabel) {
            text = "$STR_3DEN_Object_Attribute_Rank_displayName";
            h = POS_H(2.5);
        };
        class Background: RscText {
            idc = -1;
            x = POS_W(10);
            y = 0;
            w = POS_W(16);
            h = POS_H(2.5);
            colorBackground[] = {1, 1, 1, 0.1};
        };
        class Private: RscActivePicture {
            idc = IDC_ATTRIBUTERANK_PRIVATE;
            text = "\a3\Ui_f\data\GUI\Cfg\Ranks\private_gs.paa";
            tooltip = "$STR_Private";
            x = POS_W(11.25);
            y = POS_H(0.5);
            w = POS_W(1.5);
            h = POS_H(1.5);
        };
        class Corporal: Private {
            idc = IDC_ATTRIBUTERANK_CORPORAL;
            text = "\a3\Ui_f\data\GUI\Cfg\Ranks\corporal_gs.paa";
            tooltip = "$STR_Corporal";
            x = POS_W(13.25);
        };
        class Sergeant: Private {
            idc = IDC_ATTRIBUTERANK_SERGEANT;
            text = "\a3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
            tooltip = "$STR_Sergeant";
            x = POS_W(15.25);
        };
        class Lieutenant: Private {
            idc = IDC_ATTRIBUTERANK_LIEUTENANT;
            text = "\a3\Ui_f\data\GUI\Cfg\Ranks\lieutenant_gs.paa";
            tooltip = "$STR_Lieutenant";
            x = POS_W(17.25);
        };
        class Captain: Private {
            idc = IDC_ATTRIBUTERANK_CAPTAIN;
            text = "\a3\Ui_f\data\GUI\Cfg\Ranks\captain_gs.paa";
            tooltip = "$STR_Captain";
            x = POS_W(19.25);
        };
        class Major: Private {
            idc = IDC_ATTRIBUTERANK_MAJOR;
            text = "\a3\Ui_f\data\GUI\Cfg\Ranks\major_gs.paa";
            tooltip = "$STR_Major";
            x = POS_W(21.25);
        };
        class Colonel: Private {
            idc = IDC_ATTRIBUTERANK_COLONEL;
            text = "\a3\Ui_f\data\GUI\Cfg\Ranks\colonel_gs.paa";
            tooltip = "$STR_Colonel";
            x = POS_W(23.25);
        };
    };
};

class GVAR(RscAttributeUnitPos): RscControlsGroupNoScrollbars {
    idc = IDC_ATTRIBUTEUNITPOS;
    onSetFocus = QUOTE(_this call FUNC(attributeUnitPos));
    x = 0;
    y = 0;
    w = POS_W(26);
    h = POS_H(2.5);
    class controls {
        class Label: GVAR(RscLabel) {
            text = "$STR_A3_RscAttributeUnitPos_Title";
            h = POS_H(2.5);
        };
        class Background: RscText {
            idc = -1;
            x = POS_W(10);
            y = 0;
            w = POS_W(16);
            h = POS_H(2.5);
            colorBackground[] = {1, 1, 1, 0.1};
        };
        class Down: RscActivePicture {
            idc = IDC_ATTRIBUTEUNITPOS_DOWN;
            text = "\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_prone_ca.paa";
            tooltip = "$STR_A3_RscAttributeUnitPos_Down_tooltip";
            x = POS_W(13.25);
            y = 0;
            w = POS_W(2.5);
            h = POS_H(2.5);
        };
        class Crouch: Down {
            idc = IDC_ATTRIBUTEUNITPOS_CROUCH;
            text = "\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_crouch_ca.paa";
            tooltip = "$STR_A3_RscAttributeUnitPos_Crouch_tooltip";
            x = POS_W(15.75);
        };
        class Up: Down {
            idc = IDC_ATTRIBUTEUNITPOS_UP;
            text = "\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_stand_ca.paa";
            tooltip = "$STR_A3_RscAttributeUnitPos_Up_tooltip";
            x = POS_W(18.25);
        };
        class Auto: Down {
            idc = IDC_ATTRIBUTEUNITPOS_AUTO;
            text = "\a3\ui_f_curator\Data\default_ca.paa";
            tooltip = "$STR_A3_RscAttributeUnitPos_Auto_tooltip";
            x = POS_W(24);
            y = POS_H(0.5);
            w = POS_W(1.5);
            h = POS_H(1.5);
        };
    };
};

class GVAR(RscAttributeRespawnPosition): RscControlsGroupNoScrollbars {
    idc = IDC_ATTRIBUTERESPAWNPOSITION;
    onSetFocus = QUOTE(_this call FUNC(attributeRespawnPosition));
    x = 0;
    y = 0;
    w = POS_W(26);
    h = POS_H(2.5);
    class controls {
        class Label: GVAR(RscLabel) {
            text = "$STR_A3_RscAttributeRespawnPosition_Title";
            h = POS_H(2.5);
        };
        class Background: RscText {
            idc = IDC_ATTRIBUTERESPAWNPOSITION_BACKGROUND;
            style = ST_CENTER;
            x = POS_W(10);
            y = 0;
            w = POS_W(16);
            h = POS_H(2.5);
            colorText[] = {1, 1, 1, 0.5};
            colorBackground[] = {1, 1, 1, 0.1};
        };
        class West: RscActivePicture {
            idc = IDC_ATTRIBUTERESPAWNPOSITION_WEST;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeRespawnPosition\west_ca.paa";
            tooltip = "$STR_WEST";
            x = POS_W(11.5);
            y = POS_H(0.25);
            w = POS_W(2);
            h = POS_H(2);
        };
        class East: West {
            idc = IDC_ATTRIBUTERESPAWNPOSITION_EAST;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeRespawnPosition\east_ca.paa";
            tooltip = "$STR_EAST";
            x = POS_W(14.5);
        };
        class Guer: West {
            idc = IDC_ATTRIBUTERESPAWNPOSITION_GUER;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeRespawnPosition\guer_ca.paa";
            tooltip = "$STR_guerrila";
            x = POS_W(17.5);
        };
        class Civ: West {
            idc = IDC_ATTRIBUTERESPAWNPOSITION_CIV;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeRespawnPosition\civ_ca.paa";
            tooltip = "$STR_Civilian";
            x = POS_W(20.5);
        };
        class Disabled: West {
            idc = IDC_ATTRIBUTERESPAWNPOSITION_DISABLED;
            text = "\a3\Ui_F_Curator\Data\default_ca.paa";
            tooltip = "$STR_sensoractiv_none";
            x = POS_W(24);
            y = POS_H(0.5);
            w = POS_W(1.5);
            h = POS_H(1.5);
        };
    };
};

class GVAR(RscAttributeFormation): RscControlsGroupNoScrollbars {
    idc = IDC_ATTRIBUTEFORMATION;
    onSetFocus = QUOTE(_this call FUNC(attributeFormation));
    x = 0;
    y = 0;
    w = POS_W(26);
    h = POS_H(5);
    class controls {
        class Label: GVAR(RscLabel) {
            text = "$STR_3DEN_Group_Attribute_Formation_displayName";
            h = POS_H(5);
        };
        class Background: RscText {
            idc = -1;
            x = POS_W(10);
            y = 0;
            w = POS_W(16);
            h = POS_H(5);
            colorBackground[] = {1, 1, 1, 0.1};
        };
        class Wedge: RscActivePicture {
            idc = IDC_ATTRIBUTEFORMATION_WEDGE;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\wedge_ca.paa";
            tooltip = "$STR_wedge";
            x = POS_W(11.75);
            y = 0;
            w = POS_W(2.5);
            h = POS_H(2.5);
        };
        class Vee: Wedge {
            idc = IDC_ATTRIBUTEFORMATION_VEE;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\vee_ca.paa";
            tooltip = "$STR_vee";
            x = POS_W(14.25);
        };
        class Line: Wedge {
            idc = IDC_ATTRIBUTEFORMATION_LINE;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\line_ca.paa";
            tooltip = "$STR_line";
            x = POS_W(16.75);
        };
        class Column: Wedge {
            idc = IDC_ATTRIBUTEFORMATION_COLUMN;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\column_ca.paa";
            tooltip = "$STR_column";
            x = POS_W(19.25);
        };
        class File: Wedge {
            idc = IDC_ATTRIBUTEFORMATION_FILE;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\file_ca.paa";
            tooltip = "$STR_file";
            x = POS_W(21.75);
        };
        class StagColumn: Wedge {
            idc = IDC_ATTRIBUTEFORMATION_STAGCOLUMN;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\stag_column_ca.paa";
            tooltip = "$STR_staggered";
            x = POS_W(11.75);
            y = POS_H(2.5);
        };
        class EchLeft: StagColumn {
            idc = IDC_ATTRIBUTEFORMATION_ECHLEFT;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\ech_left_ca.paa";
            tooltip = "$STR_echl";
            x = POS_W(14.25);
        };
        class EchRight: StagColumn {
            idc = IDC_ATTRIBUTEFORMATION_ECHRIGHT;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\ech_right_ca.paa";
            tooltip = "$STR_echr";
            x = POS_W(16.75);
        };
        class Diamond: StagColumn {
            idc = IDC_ATTRIBUTEFORMATION_DIAMOND;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\diamond_ca.paa";
            tooltip = "$STR_diamond";
            x = POS_W(19.25);
        };
        class Default: StagColumn {
            idc = IDC_ATTRIBUTEFORMATION_DEFAULT;
            text = "\a3\ui_f_curator\Data\default_ca.paa";
            tooltip = "$STR_no_change";
            x = POS_W(22.25);
            y = POS_H(3);
            w = POS_W(1.5);
            h = POS_H(1.5);
        };
    };
};

class GVAR(RscAttributeBehaviour): RscControlsGroupNoScrollbars {
    idc = IDC_ATTRIBUTEBEHAVIOUR;
    onSetFocus = QUOTE(_this call FUNC(attributeBehaviour));
    x = 0;
    y = 0;
    w = POS_W(26);
    h = POS_H(2.5);
    class controls {
        class Label: GVAR(RscLabel) {
            text = "$STR_3DEN_Group_Attribute_Behaviour_displayName";
            h = POS_H(2.5);
        };
        class Background: RscText {
            idc = -1;
            x = POS_W(10);
            y = 0;
            w = POS_W(16);
            h = POS_H(2.5);
            colorBackground[] = {1, 1, 1, 0.1};
        };
        class Careless: RscActivePicture {
            idc = IDC_ATTRIBUTEBEHAVIOUR_CARELESS;
            text = QPATHTOF(UI\careless_ca.paa);
            tooltip = "$STR_3DEN_Attributes_Behaviour_Careless_text";
            x = POS_W(11.25);
            y = POS_H(0.5);
            w = POS_W(1.5);
            h = POS_H(1.5);
        };
        class Safe: Careless {
            idc = IDC_ATTRIBUTEBEHAVIOUR_SAFE;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeBehaviour\safe_ca.paa";
            tooltip = "$STR_safe";
            x = POS_W(13.75);
        };
        class Aware: Careless {
            idc = IDC_ATTRIBUTEBEHAVIOUR_AWARE;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeBehaviour\aware_ca.paa";
            tooltip = "$STR_aware";
            x = POS_W(16.25);
        };
        class Combat: Careless {
            idc = IDC_ATTRIBUTEBEHAVIOUR_COMBAT;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeBehaviour\combat_ca.paa";
            tooltip = "$STR_combat";
            x = POS_W(18.75);
        };
        class Stealth: Careless {
            idc = IDC_ATTRIBUTEBEHAVIOUR_STEALTH;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeBehaviour\stealth_ca.paa";
            tooltip = "$STR_stealth";
            x = POS_W(21.25);
        };
        class Default: Careless {
            idc = IDC_ATTRIBUTEBEHAVIOUR_DEFAULT;
            text = "\a3\ui_f_curator\Data\default_ca.paa";
            tooltip = "$STR_combat_unchanged";
            x = POS_W(24);
        };
    };
};

class GVAR(RscAttributeCombatMode): RscControlsGroupNoScrollbars {
    idc = IDC_COMBATMODE_GROUP;
    onSetFocus = QUOTE(_this call FUNC(attributeCombatMode));
    x = 0;
    y = 0;
    w = POS_W(26);
    h = POS_H(2.5);
    class controls {
        class Label: GVAR(RscLabel) {
            text = "$STR_3DEN_Group_Attribute_CombatMode_displayName";
            h = POS_H(2.5);
        };
        class Background: RscText {
            idc = -1;
            x = POS_W(10);
            y = 0;
            w = POS_W(16);
            h = POS_H(2.5);
            colorBackground[] = {1, 1, 1, 0.1};
        };
        class Blue: RscActivePicture {
            idc = IDC_COMBATMODE_BLUE;
            text = QPATHTOF(UI\hold_ca.paa);
            tooltip = "$STR_3DEN_Attributes_CombatMode_Blue_text";
            x = POS_W(11.25);
            y = POS_H(0.5);
            w = POS_W(1.5);
            h = POS_H(1.5);
        };
        class Green: Blue {
            idc = IDC_COMBATMODE_GREEN;
            text = QPATHTOF(UI\defend_ca.paa);
            tooltip = "$STR_3DEN_Attributes_CombatMode_Green_text";
            x = POS_W(13.75);
        };
        class White: Blue {
            idc = IDC_COMBATMODE_WHITE;
            text = QPATHTOF(UI\engage_ca.paa);
            tooltip = "$STR_3DEN_Attributes_CombatMode_White_text";
            x = POS_W(16.25);
        };
        class Yellow: Blue {
            idc = IDC_COMBATMODE_YELLOW;
            text = QPATHTOF(UI\hold_ca.paa);
            tooltip = "$STR_3DEN_Attributes_CombatMode_Yellow_text";
            x = POS_W(18.75);
        };
        class Red: Blue {
            idc = IDC_COMBATMODE_RED;
            text = QPATHTOF(UI\engage_ca.paa);
            tooltip = "$STR_3DEN_Attributes_CombatMode_Red_text";
            x = POS_W(21.25);
        };
        class Default: Blue {
            idc = IDC_COMBATMODE_DEFAULT;
            text = "\a3\ui_f_curator\Data\default_ca.paa";
            tooltip = "$STR_combat_unchanged";
            x = POS_W(24);
        };
    };
};

class GVAR(RscAttributeSpeedMode): RscControlsGroupNoScrollbars {
    idc = IDC_ATTRIBUTESPEEDMODE;
    onSetFocus = QUOTE(_this call FUNC(attributeSpeedMode));
    x = 0;
    y = 0;
    w = POS_W(26);
    h = POS_H(2.5);
    class controls {
        class Label: GVAR(RscLabel) {
            text = "$STR_HC_Menu_Speed";
            h = POS_H(2.5);
        };
        class Background: RscText {
            idc = -1;
            x = POS_W(10);
            y = 0;
            w = POS_W(16);
            h = POS_H(2.5);
            colorBackground[] = {1, 1, 1, 0.1};
        };
        class Limited: RscActivePicture {
            idc = IDC_ATTRIBUTESPEEDMODE_LIMITED;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeSpeedMode\limited_ca.paa";
            tooltip = "$STR_speed_limited";
            x = POS_W(13.25);
            y = POS_H(0);
            w = POS_W(2.5);
            h = POS_H(2.5);
        };
        class Normal: Limited {
            idc = IDC_ATTRIBUTESPEEDMODE_NORMAL;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeSpeedMode\normal_ca.paa";
            tooltip = "$STR_speed_normal";
            x = POS_W(15.75);
        };
        class Full: Limited {
            idc = IDC_ATTRIBUTESPEEDMODE_FULL;
            text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeSpeedMode\full_ca.paa";
            tooltip = "$STR_speed_full";
            x = POS_W(18.25);
        };
        class Default: Limited {
            idc = IDC_ATTRIBUTESPEEDMODE_DEFAULT;
            text = "\a3\ui_f_curator\Data\default_ca.paa";
            tooltip = "$STR_speed_unchanged";
            x = POS_W(24);
            y = POS_H(0.5);
            w = POS_W(1.5);
            h = POS_H(1.5);
        };
    };
};

class GVAR(RscAttributeWaypointType): RscControlsGroupNoScrollbars {
    idc = IDC_ATTRIBUTEWAYPOINTTYPE;
    onSetFocus = QUOTE(_this call FUNC(attributeWaypointType));
    x = 0;
    y = 0;
    w = POS_W(26);
    h = POS_H(5);
    class controls {
        class Label: GVAR(RscLabel) {
            text = "$STR_3DEN_Object_Attribute_Type_displayName";
            w = POS_W(26);
        };
        class Background: RscText {
            idc = IDC_ATTRIBUTEWAYPOINTTYPE_BACKGROUND;
            style = ST_CENTER;
            x = 0;
            y = POS_H(1);
            w = POS_W(26);
            h = POS_H(4);
            colorText[] = {1, 1, 1, 0.5};
            colorBackground[] = {1, 1, 1, 0.1};
        };
        class Toolbox: ctrlToolbox {
            idc = IDC_ATTRIBUTEWAYPOINTTYPE_TOOLBOX;
            x = 0;
            y = POS_H(1);
            w = POS_W(26);
            h = POS_H(4);
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

class GVAR(RscAttributeWaypointTimeout): GVAR(RscAttributeSkill) {
    idc = IDC_TIMEOUT_GROUP;
    onSetFocus = QUOTE(_this call FUNC(attributeWaypointTimeout));
    class controls: controls {
        class Label: Label {
            text = CSTRING(Timeout);
            tooltip = CSTRING(Timeout_Tooltip);
        };
        class Slider: Slider {
            idc = IDC_TIMEOUT_SLIDER;
        };
        class Edit: Edit {
            idc = IDC_TIMEOUT_EDIT;
        };
    };
};

class GVAR(RscAttributeMarkerText): RscControlsGroupNoScrollbars {
    idc = IDC_ATTRIBUTEMARKERTEXT;
    onSetFocus = QUOTE(_this call FUNC(attributeMarkerText));
    x = 0;
    y = 0;
    w = POS_W(26);
    h = POS_H(1);
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
    onSetFocus = QUOTE(_this call FUNC(attributeMarkerColor));
    x = 0;
    y = 0;
    w = POS_W(26);
    h = POS_H(1);
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
                class Rank: GVAR(RscAttributeRank) {};
                class UnitPos: GVAR(RscAttributeUnitPos) {};
                class RespawnPosition: GVAR(RscAttributeRespawnPosition) {};
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
        class ButtonArsenal: ButtonCustom1 {
            text = "$STR_A3_Arsenal";
            onButtonClick = QUOTE(_this call FUNC(buttonArsenal));
        };
    };
};

class GVAR(RscAttributesVehicle): GVAR(RscAttributesBase) {
    onLoad = QUOTE([ARR_2(_this select 0, QQGVAR(RscAttributesVehicle))] call FUNC(initAttributesDisplay));
    filterAttributes = 1;
    class Controls: Controls {
        class Background: Background {};
        class Title: Title {};
        class Content: Content {
            class Controls {
                class Skill: GVAR(RscAttributeSkill) {};
                class Damage: GVAR(RscAttributeDamage) {};
                class Fuel: GVAR(RscAttributeFuel) {};
                class Rank: GVAR(RscAttributeRank) {};
                class RespawnPosition: GVAR(RscAttributeRespawnPosition) {};
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
        class ButtonGarage: ButtonCustom1 {
            text = "$STR_A3_Garage";
            onButtonClick = QUOTE(_this call FUNC(buttonGarage));
        };
    };
};

class GVAR(RscAttributesVehicleEmpty): GVAR(RscAttributesBase) {
    onLoad = QUOTE([ARR_2(_this select 0, QQGVAR(RscAttributesVehicleEmpty))] call FUNC(initAttributesDisplay));
    filterAttributes = 1;
    class Controls: Controls {
        class Background: Background {};
        class Title: Title {};
        class Content: Content {
            class Controls {
                class Damage: GVAR(RscAttributeDamage) {};
                class Fuel: GVAR(RscAttributeFuel) {};
                class RespawnPosition: GVAR(RscAttributeRespawnPosition) {};
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
        class ButtonGarage: ButtonCustom1 {
            text = "$STR_A3_Garage";
            onButtonClick = QUOTE(_this call FUNC(buttonGarage));
        };
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
                class CombatMode: GVAR(RscAttributeCombatMode) {
                    class controls: controls {
                        class Label: Label {};
                        class Background: Background {};
                        class Blue: Blue {
                            x = POS_W(12.25);
                        };
                        class Green: Green {
                            x = POS_W(14.75);
                        };
                        class White: White {
                            x = POS_W(17.25);
                        };
                        class Yellow: Yellow {
                            x = POS_W(19.75);
                        };
                        class Red: Red {
                            x = POS_W(22.25);
                        };
                        class Default: Default {};
                    };
                };
                class SpeedMode: GVAR(RscAttributeSpeedMode) {};
                class UnitPos: GVAR(RscAttributeUnitPos) {};
                class RespawnPosition: GVAR(RscAttributeRespawnPosition) {
                    class controls: controls {
                        class Label: Label {
                            text = "$STR_A3_RscAttributeRespawnPosition_TitleGroup";
                        };
                        class Background: Background {};
                        class West: West {};
                        class East: East {};
                        class Guer: Guer {};
                        class Civ: Civ {};
                        class Disabled: Disabled {};
                    };
                };
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
                class WaypointTimeout: GVAR(RscAttributeWaypointTimeout) {};
                class Formation: GVAR(RscAttributeFormation) {};
                class Behaviour: GVAR(RscAttributeBehaviour) {};
                class CombatMode: GVAR(RscAttributeCombatMode) {};
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
