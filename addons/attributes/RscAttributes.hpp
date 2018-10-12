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
    onSetFocus = "";
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

class GVAR(RscAttributeSkill): RscControlsGroupNoScrollbars {
    idc = IDC_ATTRIBUTESKILL;
    onSetFocus = "";
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
    onSetFocus = "";
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
            x = 11 * GUI_GRID_W;
            y = 0.5 * GUI_GRID_H;
            w = 1.5 * GUI_GRID_W;
            h = 1.5 * GUI_GRID_H;
        };
        class Corporal: Private {
            idc = IDC_ATTRIBUTERANK_CORPORAL;
            text = "\a3\Ui_f\data\GUI\Cfg\Ranks\corporal_gs.paa";
            tooltip = "$STR_Corporal";
            x = 13 * GUI_GRID_W;
        };
        class Sergeant: Private {
            idc = IDC_ATTRIBUTERANK_SERGEANT;
            text = "\a3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
            tooltip = "$STR_Sergeant";
            x = 15 * GUI_GRID_W;
        };
        class Lieutenant: Private {
            idc = IDC_ATTRIBUTERANK_LIEUTENANT;
            text = "\a3\Ui_f\data\GUI\Cfg\Ranks\lieutenant_gs.paa";
            tooltip = "$STR_Lieutenant";
            x = 17 * GUI_GRID_W;
        };
        class Captain: Private {
            idc = IDC_ATTRIBUTERANK_CAPTAIN;
            text = "\a3\Ui_f\data\GUI\Cfg\Ranks\captain_gs.paa";
            tooltip = "$STR_Captain";
            x = 19 * GUI_GRID_W;
        };
        class Major: Private {
            idc = IDC_ATTRIBUTERANK_MAJOR;
            text = "\a3\Ui_f\data\GUI\Cfg\Ranks\major_gs.paa";
            tooltip = "$STR_Major";
            x = 21 * GUI_GRID_W;
        };
        class Colonel: Private {
            idc = IDC_ATTRIBUTERANK_COLONEL;
            text = "\a3\Ui_f\data\GUI\Cfg\Ranks\colonel_gs.paa";
            tooltip = "$STR_Colonel";
            x = 23 * GUI_GRID_W;
        };
    };
};

class GVAR(RscAttributeUnitPos): RscControlsGroupNoScrollbars {
    idc = IDC_ATTRIBUTEUNITPOS;
    onSetFocus = "";
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
