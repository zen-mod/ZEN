class RscText;
class RscEdit;
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
    onSetFocus = "";
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

class GVAR(RscAttributesMan): RscDisplayAttributes {
    onLoad = QUOTE([ARR_3('onLoad', _this, QQGVAR(RscAttributesMan))] call EFUNC(common,zeusAttributes));
    onUnload = QUOTE([ARR_3('onUnload', _this, QQGVAR(RscAttributesMan))] call EFUNC(common,zeusAttributes));
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

class GVAR(RscAttributesGroup): RscDisplayAttributes {
    onLoad = QUOTE([ARR_3('onLoad', _this, QQGVAR(RscAttributesGroup))] call EFUNC(common,zeusAttributes));
    onUnload = QUOTE([ARR_3('onUnload', _this, QQGVAR(RscAttributesGroup))] call EFUNC(common,zeusAttributes));
    filterAttributes = 1;
    class Controls: Controls {
        class Background: Background {};
        class Title: Title {};
        class Content: Content {
            class Controls {
                class GroupID: GVAR(RscAttributeGroupID) {};
                class Formation: GVAR(RscAttributeFormation) {};
                class Behaviour: GVAR(RscAttributeBehaviour) {};
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};
