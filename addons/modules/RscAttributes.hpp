class RscText;
class RscEdit;
class RscCombo;
class RscButton;
class RscListBox;
class ctrlToolbox;
class RscEditMulti;
class RscStructuredText;
class ctrlButtonPictureKeepAspect;
class RscActivePicture;
class RscControlsGroup;
class RscControlsGroupNoScrollbars;

class EGVAR(attributes,RscLabel);
class EGVAR(attributes,RscEdit);
class EGVAR(attributes,RscCombo);

class GVAR(RscToolboxYesNo): ctrlToolbox {
    idc = -1;
    x = POS_W(10.1);
    y = 0;
    w = POS_W(15.9);
    h = POS_H(1);
    rows = 1;
    columns = 2;
    strings[] = {ECSTRING(common,No), ECSTRING(common,Yes)};
};

class EGVAR(attributes,RscAttributesBase) {
    class controls {
        class Title;
        class Background;
        class Content;
        class ButtonOK;
        class ButtonCancel;
    };
};

#define BEGIN_MODULE_DIALOG(name) \
    class GVAR(name): EGVAR(attributes,RscAttributesBase) { \
        onLoad = QUOTE([ARR_2(_this select 0, QQGVAR(name))] call EFUNC(attributes,initAttributesDisplay)); \
        class controls: controls { \
            class Title: Title {}; \
            class Background: Background {}; \
            class Content: Content { \
                class controls { \

#define END_MODULE_DIALOG \
                }; \
            }; \
            class ButtonOK: ButtonOK {}; \
            class ButtonCancel: ButtonCancel {}; \
        }; \
    }

class GVAR(AttributeRadius): RscControlsGroupNoScrollbars {
    onSetFocus = QUOTE(_this call FUNC(ui_attributeRadius));
    idc = IDC_ATTRIBUTERADIUS;
    x = 0;
    y = 0;
    w = 26 * GUI_GRID_W;
    h = 1.1 * GUI_GRID_H;
    class controls {
        class Label: EGVAR(attributes,RscLabel) {
            text = CSTRING(AttributeRadius);
            tooltip = CSTRING(AttributeRadius_Tooltip);
            y = 0.1 * GUI_GRID_H;
        };
        class Value: RscEdit {
            idc = IDC_ATTRIBUTERADIUS_VALUE;
            text = "100";
            x = 10.1 * GUI_GRID_W;
            y = 0.1 * GUI_GRID_H;
            w = 15.9 * GUI_GRID_W;
            h = GUI_GRID_H;
        };
    };
};

BEGIN_MODULE_DIALOG(RscChangeHeight)
    class changeHeight: RscControlsGroupNoScrollbars {
        onSetFocus = QUOTE(_this call FUNC(ui_changeHeight));
        idc = IDC_CHANGEHEIGHT;
        x = 0;
        y = 0;
        w = POS_W(26);
        h = POS_H(1);
        class controls {
            class Label: EGVAR(attributes,RscLabel) {
                text = CSTRING(ModuleChangeHeight_Label);
                tooltip = CSTRING(ModuleChangeHeight_Tooltip);
            };
            class Height: EGVAR(attributes,RscEdit) {
                idc = IDC_CHANGEHEIGHT_HEIGHT;
            };
        };
    };
END_MODULE_DIALOG;

BEGIN_MODULE_DIALOG(RscChatter)
    class chatter: RscControlsGroupNoScrollbars {
        onSetFocus = QUOTE(_this call FUNC(ui_chatter));
        x = 0;
        y = 0;
        w = POS_W(26);
        h = POS_H(2.1);
        class controls {
            class MessageLabel: EGVAR(attributes,RscLabel) {
                text = CSTRING(ModuleChatter_Message);
            };
            class Message: EGVAR(attributes,RscEdit) {
                idc = IDC_CHATTER_MESSAGE;
            };
            class TargetLabel: EGVAR(attributes,RscLabel) {
                idc = IDC_CHATTER_LABEL;
                y = POS_H(1.1);
            };
            class Sides: EGVAR(attributes,RscCombo) {
                idc = IDC_CHATTER_SIDES;
                y = POS_H(1.1);
                class Items {
                    class BLUFOR {
                        text = "$STR_WEST";
                        picture = ICON_BLUFOR;
                        value = 1;
                        default = 1;
                    };
                    class OPFOR {
                        text = "$STR_EAST";
                        picture = ICON_OPFOR;
                        value = 0;
                    };
                    class Independent {
                        text = "$STR_guerrila";
                        picture = ICON_INDEPENDENT;
                        value = 2;
                    };
                    class Civilian {
                        text = "$STR_Civilian";
                        picture = ICON_CIVILIAN;
                        value = 3;
                    };
                };
            };
            class Channels: EGVAR(attributes,RscCombo) {
                idc = IDC_CHATTER_CHANNELS;
                y = POS_H(1.1);
                class Items {
                    class Global {
                        text = "$STR_channel_global";
                        color[] = {0.85, 0.85, 0.85, 1};
                    };
                    class Side {
                        text = "$STR_channel_side";
                        color[] = {0.27, 0.83, 0.99, 1};
                        default = 1;
                    };
                    class Command {
                        text = "$STR_channel_command";
                        color[] = {1, 1, 0.27, 1};
                    };
                    class Group {
                        text = "$STR_channel_group";
                        color[] = {0.71, 0.97, 0.38, 1};
                    };
                    class Vehicle {
                        text = "$STR_channel_vehicle";
                        color[] = {1, 0.82, 0, 1};
                    };
                };
            };
        };
    };
END_MODULE_DIALOG;

BEGIN_MODULE_DIALOG(RscMakeInvincible)
    class makeInvincible: RscControlsGroupNoScrollbars {
        onSetFocus = QUOTE(_this call FUNC(ui_makeInvincible));
        idc = IDC_MAKEINVINCIBLE;
        x = 0;
        y = 0;
        w = POS_W(26);
        h = POS_H(2.1);
        class controls {
            class InvincibleLabel: EGVAR(attributes,RscLabel) {
                text = CSTRING(ModuleMakeInvincible_Invincible);
            };
            class Invincible: GVAR(RscToolboxYesNo) {
                idc = IDC_MAKEINVINCIBLE_INVINCIBLE;
            };
            class IncludeCrewLabel: EGVAR(attributes,RscLabel) {
                text = CSTRING(ModuleMakeInvincible_IncludeCrew);
                y = POS_H(1.1);
            };
            class IncludeCrew: GVAR(RscToolboxYesNo) {
                idc = IDC_MAKEINVINCIBLE_INCLUDECREW;
                y = POS_H(1.1);
            };
        };
    };
END_MODULE_DIALOG;

class GVAR(RscCreateMinefield): EGVAR(attributes,RscAttributesBase) {
    onLoad = QUOTE([ARR_2(_this select 0, QQGVAR(RscCreateMinefield))] call EFUNC(attributes,initAttributesDisplay));
    class Controls: Controls {
        class Background: Background {};
        class Title: Title {};
        class Content: Content {
            class Controls {
                class createMinefield: RscControlsGroupNoScrollbars {
                    onSetFocus = QUOTE(_this call FUNC(ui_createMinefield));
                    idc = IDC_CREATEMINEFIELD;
                    x = 0;
                    y = 0;
                    w = 26 * GUI_GRID_W;
                    h = 3.2 * GUI_GRID_H;
                    class controls {
                        class AreaLabel: EGVAR(attributes,RscLabel) {
                            text = CSTRING(ModuleCreateMinefield_MineArea);
                        };
                        class AreaIconX: RscText {
                            text = "$STR_3DEN_Axis_X";
                            x = 10.1 * GUI_GRID_W;
                            y = 0;
                            w = GUI_GRID_W;
                            h = GUI_GRID_H;
                            font = "RobotoCondensedLight";
                            colorBackground[] = {0.77, 0.18, 0.1, 1};
                            shadow = 0;
                        };
                        class AreaEditX: RscEdit {
                            idc = IDC_CREATEMINEFIELD_AREA_X;
                            text = "100";
                            x = 11.2 * GUI_GRID_W;
                            y = pixelH;
                            w = 6.8 * GUI_GRID_W;
                            h = GUI_GRID_H - pixelH;
                        };
                        class AreaIconY: AreaIconX {
                            text = "$STR_3DEN_Axis_Y";
                            x = 18.1 * GUI_GRID_W;
                            colorBackground[] = {0.58, 0.82, 0.22, 1};
                        };
                        class AreaEditY: AreaEditX {
                            idc = IDC_CREATEMINEFIELD_AREA_Y;
                            x = 19.2 * GUI_GRID_W;
                        };
                        class TypeLabel: EGVAR(attributes,RscLabel) {
                            text = CSTRING(ModuleCreateMinefield_MineType);
                            y = 1.1 * GUI_GRID_H;
                        };
                        class Type: RscCombo {
                            idc = IDC_CREATEMINEFIELD_TYPE;
                            x = 10.1 * GUI_GRID_W;
                            y = 1.1 * GUI_GRID_H;
                            w = 15.9 * GUI_GRID_W;
                            h = GUI_GRID_H;
                            colorBackground[] = {0, 0, 0, 0.7};
                        };
                        class DensityLabel: EGVAR(attributes,RscLabel) {
                            text = CSTRING(ModuleCreateMinefield_MineDensity);
                            y = 2.2 * GUI_GRID_H;
                        };
                        class Density: ctrlToolbox {
                            idc = IDC_CREATEMINEFIELD_DENSITY;
                            x = 10.1 * GUI_GRID_W;
                            y = 2.2 * GUI_GRID_H;
                            w = 15.9 * GUI_GRID_W;
                            h = GUI_GRID_H;
                            rows = 1;
                            columns = 5;
                            strings[] = {
                                ECSTRING(common,VeryLow),
                                ECSTRING(common,Low),
                                ECSTRING(common,Medium),
                                ECSTRING(common,High),
                                ECSTRING(common,VeryHigh)
                            };
                        };
                    };
                };
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};

class GVAR(RscGlobalHint): EGVAR(attributes,RscAttributesBase) {
    onLoad = QUOTE([ARR_2(_this select 0, QQGVAR(RscGlobalHint))] call EFUNC(attributes,initAttributesDisplay));
    class Controls: Controls {
        class Background: Background {};
        class Title: Title {};
        class Content: Content {
            class Controls {
                class globalHint: RscControlsGroupNoScrollbars {
                    onSetFocus = QUOTE(_this call FUNC(ui_globalHint));
                    idc = IDC_GLOBALHINT;
                    x = 0;
                    y = 0;
                    w = 26 * GUI_GRID_W;
                    h = 6 * GUI_GRID_H;
                    class controls {
                        class Edit: RscEditMulti {
                            idc = IDC_GLOBALHINT_EDIT;
                            x = pixelW;
                            y = pixelH;
                            w = 13 * GUI_GRID_W - pixelW;
                            h = 6 * GUI_GRID_H - pixelH;
                            colorBackground[] = {0.25, 0.25, 0.25, 0.1};
                        };
                        class Container: RscControlsGroup {
                            idc = -1;
                            x = 13.1 * GUI_GRID_W;
                            y = 0;
                            w = 12.9 * GUI_GRID_W;
                            h = 6 * GUI_GRID_H;
                            class controls {
                                class Preview: RscStructuredText {
                                    idc = IDC_GLOBALHINT_PREVIEW;
                                    x = 0;
                                    y = 0;
                                    w = 12.2 * GUI_GRID_W;
                                    h = 2 * safeZoneH;
                                    size = 0.9 * GUI_GRID_H; // Trial and error to get best representation of actual hint
                                    colorBackground[] = {0, 0, 0, 0.6};
                                    class Attributes {
                                        font = "RobotoCondensed";
                                        color = "#FFFFFF";
                                        colorLink = "#D09B43";
                                        align = "center";
                                        shadow = 1;
                                    };
                                };
                            };
                        };
                    };
                };
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};

class GVAR(RscHideZeus): EGVAR(attributes,RscAttributesBase) {
    onLoad = QUOTE([ARR_2(_this select 0, QQGVAR(RscHideZeus))] call EFUNC(attributes,initAttributesDisplay));
    class Controls: Controls {
        class Background: Background {};
        class Title: Title {};
        class Content: Content {
            class Controls {
                class hideZeus: RscControlsGroupNoScrollbars {
                    onSetFocus = QUOTE(_this call FUNC(ui_hideZeus));
                    idc = IDC_HIDEZEUS;
                    x = 0;
                    y = 0;
                    w = 26 * GUI_GRID_W;
                    h = GUI_GRID_H;
                    class controls {
                        class Label: EGVAR(attributes,RscLabel) {
                            text = CSTRING(ModuleHideZeus);
                        };
                        class Value: GVAR(RscToolboxYesNo) {
                            idc = IDC_HIDEZEUS_VALUE;
                        };
                    };
                };
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};

class GVAR(RscPatrolArea): EGVAR(attributes,RscAttributesBase) {
    onLoad = QUOTE([ARR_2(_this select 0, QQGVAR(RscPatrolArea))] call EFUNC(attributes,initAttributesDisplay));
    class Controls: Controls {
        class Background: Background {};
        class Title: Title {};
        class Content: Content {
            class Controls {
                class radius: GVAR(AttributeRadius) {};
                class patrolArea: RscControlsGroupNoScrollbars {
                    onSetFocus = QUOTE(_this call FUNC(ui_patrolArea));
                    idc = IDC_PATROLAREA;
                    x = 0;
                    y = 0;
                    w = 26 * GUI_GRID_W;
                    h = GUI_GRID_H;
                    class controls {
                        class BehaviourLabel: EGVAR(attributes,RscLabel) {
                            text = "$STR_3DEN_Group_Attribute_Behaviour_displayName";
                            tooltip = CSTRING(ModulePatrolArea_Behaviour_Tooltip);
                        };
                        class Behaviour: ctrlToolbox {
                            idc = IDC_PATROLAREA_BEHAVIOUR;
                            x = 10.1 * GUI_GRID_W;
                            y = 0;
                            w = 15.9 * GUI_GRID_W;
                            h = GUI_GRID_H;
                            rows = 1;
                            columns = 4;
                            strings[] = {
                                "$STR_3den_attributes_default_unchanged_text",
                                CSTRING(ModulePatrolArea_Relaxed),
                                CSTRING(ModulePatrolArea_Cautious),
                                "$STR_combat"
                            };
                        };
                    };
                };
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};

class GVAR(RscSideRelations): EGVAR(attributes,RscAttributesBase) {
    onLoad = QUOTE([ARR_2(_this select 0, QQGVAR(RscSideRelations))] call EFUNC(attributes,initAttributesDisplay));
    class Controls: Controls {
        class Background: Background {};
        class Title: Title {};
        class Content: Content {
            class Controls {
                class sideRelations: RscControlsGroupNoScrollbars {
                    onSetFocus = QUOTE(_this call FUNC(ui_sideRelations));
                    idc = IDC_SIDERELATIONS;
                    x = 0;
                    y = 0;
                    w = 26 * GUI_GRID_W;
                    h = 2.1 * GUI_GRID_H;
                    class controls {
                        class RelationLabel: EGVAR(attributes,RscLabel) {
                            text = CSTRING(RelationToChange);
                        };
                        class RelationToggle: ctrlButtonPictureKeepAspect {
                            idc = IDC_SIDERELATIONS_TOGGLE;
                            text = ICON_FRIENDLY;
                            tooltip = CSTRING(FriendlyTo);
                            x = 17.55 * GUI_GRID_W;
                            y = 0;
                            w = GUI_GRID_W;
                            h = GUI_GRID_H;
                            colorBackground[] = {0, 0, 0, 0.7};
                            tooltipColorBox[] = {1, 1, 1, 1};
                            tooltipColorShade[] = {0, 0, 0, 0.65};
                            offsetPressedX = 0;
                            offsetPressedY = 0;
                        };
                        class RelationSide_1: RscCombo {
                            idc = IDC_SIDERELATIONS_SIDE_1;
                            x = 10.1 * GUI_GRID_W;
                            y = 0;
                            w = 7.35 * GUI_GRID_W;
                            h = GUI_GRID_H;
                            colorBackground[] = {0, 0, 0, 0.7};
                            class Items {
                                class BLUFOR {
                                    text = "$STR_WEST";
                                    picture = ICON_BLUFOR;
                                    value = 1;
                                };
                                class OPFOR {
                                    text = "$STR_EAST";
                                    picture = ICON_OPFOR;
                                    value = 0;
                                };
                                class Independent {
                                    text = "$STR_guerrila";
                                    picture = ICON_INDEPENDENT;
                                    value = 2;
                                };
                            };
                        };
                        class RelationSide_2: RelationSide_1 {
                            idc = IDC_SIDERELATIONS_SIDE_2;
                            x = 18.65 * GUI_GRID_W;
                            class Items {}; // Special handling through script
                        };
                        class RadioLabel: EGVAR(attributes,RscLabel) {
                            text = CSTRING(PlayRadioMessage);
                            y = 1.1 * GUI_GRID_H;
                        };
                        class Radio: GVAR(RscToolboxYesNo) {
                            idc = IDC_SIDERELATIONS_RADIO;
                            y = 1.1 * GUI_GRID_H;
                        };
                    };
                };
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};

class GVAR(RscSmokePillar): EGVAR(attributes,RscAttributesBase) {
    onLoad = QUOTE([ARR_2(_this select 0, QQGVAR(RscSmokePillar))] call EFUNC(attributes,initAttributesDisplay));
    class Controls: Controls {
        class Background: Background {};
        class Title: Title {};
        class Content: Content {
            class Controls {
                class smokePillar: RscControlsGroupNoScrollbars {
                    onSetFocus = QUOTE(_this call FUNC(ui_smokePillar));
                    idc = IDC_SMOKEPILLAR;
                    x = 0;
                    y = 0;
                    w = 26 * GUI_GRID_W;
                    h = GUI_GRID_H;
                    class controls {
                        class TypeLabel: EGVAR(attributes,RscLabel) {
                            text = CSTRING(SmokePillarType);
                        };
                        class Type: EGVAR(attributes,RscCombo) {
                            idc = IDC_SMOKEPILLAR_TYPE;
                            class Items {
                                class VehicleFire {
                                    text = CSTRING(VehicleFire);
                                };
                                class SmallOily {
                                    text = CSTRING(SmallOilySmoke);
                                };
                                class MediumOily {
                                    text = CSTRING(MediumOilySmoke);
                                };
                                class LargeOily {
                                    text = CSTRING(LargeOilySmoke);
                                };
                                class SmallWood {
                                    text = CSTRING(SmallWoodSmoke);
                                };
                                class MediumWood {
                                    text = CSTRING(MediumWoodSmoke);
                                };
                                class LargeWood {
                                    text = CSTRING(LargeWoodSmoke);
                                };
                                class SmallMixed {
                                    text = CSTRING(SmallMixedSmoke);
                                };
                                class MediumMixed {
                                    text = CSTRING(MediumMixedSmoke);
                                };
                                class LargeMixed {
                                    text = CSTRING(LargeMixedSmoke);
                                };
                            };
                        };
                    };
                };
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};

class GVAR(RscTeleportPlayers): EGVAR(attributes,RscAttributesBase) {
    onLoad = QUOTE([ARR_2(_this select 0, QQGVAR(RscTeleportPlayers))] call EFUNC(attributes,initAttributesDisplay));
    class Controls: Controls {
        class Background: Background {};
        class Title: Title {};
        class Content: Content {
            class Controls {
                class teleportPlayers: RscControlsGroupNoScrollbars {
                    onSetFocus = QUOTE(_this call FUNC(ui_teleportPlayers));
                    idc = IDC_TELEPORTPLAYERS;
                    x = 0;
                    y = 0;
                    w = 26 * GUI_GRID_W;
                    h = 8.2 * GUI_GRID_H;
                    class controls {
                        class Background: RscText {
                            x = 0;
                            y = GUI_GRID_H;
                            w = 26 * GUI_GRID_W;
                            h = 7.2 * GUI_GRID_H;
                            colorBackground[] = {1, 1, 1, 0.1};
                        };
                        class ButtonSides: RscButton {
                            idc = IDC_TELEPORTPLAYERS_BUTTON_SIDES;
                            text = CSTRING(Sides);
                            font = "RobotoCondensedLight";
                            x = 0;
                            y = 0;
                            w = 26/3 * GUI_GRID_W;
                            h = GUI_GRID_H;
                            colorBackground[] = {0, 0, 0, 0.5};
                            colorBackgroundActive[] = {1, 1, 1, 0.15};
                            colorBackgroundDisabled[] = {1, 1, 1, 0.1};
                            colorDisabled[] = {1, 1, 1, 1};
                            colorFocused[] = {1, 1, 1, 0.1};
                            period = 0;
                            periodOver = 0;
                            periodFocus = 0;
                            shadow = 0;
                        };
                        class ButtonGroups: ButtonSides {
                            idc = IDC_TELEPORTPLAYERS_BUTTON_GROUPS;
                            text = CSTRING(Groups);
                            x = 26/3 * GUI_GRID_W;
                        };
                        class ButtonPlayers: ButtonSides {
                            idc = IDC_TELEPORTPLAYERS_BUTTON_PLAYERS;
                            text = CSTRING(Players);
                            x = 52/3 * GUI_GRID_W;
                        };
                        class TabSides: RscControlsGroupNoScrollbars {
                            idc = IDC_TELEPORTPLAYERS_TAB_SIDES;
                            x = 0;
                            y = GUI_GRID_H;
                            w = 26 * GUI_GRID_W;
                            h = 7.2 * GUI_GRID_H;
                            class controls {
                                class BLUFOR: RscActivePicture {
                                    idc = IDC_TELEPORTPLAYERS_BLUFOR;
                                    text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_west_ca.paa";
                                    x = 4.25 * GUI_GRID_W;
                                    y = 2.35 * GUI_GRID_H;
                                    w = 2.5 * GUI_GRID_W;
                                    h = 2.5 * GUI_GRID_H;
                                };
                                class OPFOR: BLUFOR {
                                    idc = IDC_TELEPORTPLAYERS_OPFOR;
                                    text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_east_ca.paa";
                                    x = 9.25 * GUI_GRID_W;
                                };
                                class Independent: BLUFOR {
                                    idc = IDC_TELEPORTPLAYERS_INDEPENDENT;
                                    text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_guer_ca.paa";
                                    x = 14.25 * GUI_GRID_W;
                                };
                                class Civilian: BLUFOR {
                                    idc = IDC_TELEPORTPLAYERS_CIVILIAN;
                                    text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_civ_ca.paa";
                                    x = 19.25 * GUI_GRID_W;
                                };
                            };
                        };
                        class TabGroups: RscControlsGroupNoScrollbars {
                            idc = IDC_TELEPORTPLAYERS_TAB_GROUPS;
                            x = 0;
                            y = GUI_GRID_H;
                            w = 26 * GUI_GRID_W;
                            h = 7.2 * GUI_GRID_H;
                            class controls {
                                class Groups: RscListBox {
                                    idc = IDC_TELEPORTPLAYERS_GROUPS;
                                    x = 0.5 * GUI_GRID_W;
                                    y = 0.5 * GUI_GRID_H;
                                    w = 25 * GUI_GRID_W;
                                    h = 5 * GUI_GRID_H;
                                    colorSelect[] = {1, 1, 1, 1};
                                    colorSelect2[] = {1, 1, 1, 1};
                                    colorBackground[] = {0, 0, 0, 0.5};
                                    colorSelectBackground[] = {0, 0, 0, 0};
                                    colorSelectBackground2[] = {0, 0, 0, 0};
                                };
                                class Search: RscEdit {
                                    idc = IDC_TELEPORTPLAYERS_GROUPS_SEARCH;
                                    x = 1.6 * GUI_GRID_W;
                                    y = 5.7 * GUI_GRID_H;
                                    w = 23.9 * GUI_GRID_W;
                                    h = GUI_GRID_H;
                                };
                                class SearchButton: RscButton {
                                    idc = IDC_TELEPORTPLAYERS_GROUPS_BUTTON;
                                    style = ST_CENTER + ST_PICTURE + ST_KEEP_ASPECT_RATIO;
                                    text = "\a3\Ui_f\data\GUI\RscCommon\RscButtonSearch\search_start_ca.paa";
                                    x = 0.5 * GUI_GRID_W;
                                    y = 5.65 * GUI_GRID_H;
                                    w = GUI_GRID_W;
                                    h = GUI_GRID_H;
                                    colorBackground[] = {0, 0, 0, 0.5};
                                    colorFocused[] = {0, 0, 0, 0.5};
                                };
                            };
                        };
                        class TabPlayers: RscControlsGroupNoScrollbars {
                            idc = IDC_TELEPORTPLAYERS_TAB_PLAYERS;
                            x = 0;
                            y = GUI_GRID_H;
                            w = 26 * GUI_GRID_W;
                            h = 7.2 * GUI_GRID_H;
                            class controls {
                                class Players: RscListBox {
                                    idc = IDC_TELEPORTPLAYERS_PLAYERS;
                                    x = 0.5 * GUI_GRID_W;
                                    y = 0.5 * GUI_GRID_H;
                                    w = 25 * GUI_GRID_W;
                                    h = 5 * GUI_GRID_H;
                                    colorSelect[] = {1, 1, 1, 1};
                                    colorSelect2[] = {1, 1, 1, 1};
                                    colorBackground[] = {0, 0, 0, 0.5};
                                    colorSelectBackground[] = {0, 0, 0, 0};
                                    colorSelectBackground2[] = {0, 0, 0, 0};
                                };
                                class Search: RscEdit {
                                    idc = IDC_TELEPORTPLAYERS_PLAYERS_SEARCH;
                                    x = 1.6 * GUI_GRID_W;
                                    y = 5.7 * GUI_GRID_H;
                                    w = 23.9 * GUI_GRID_W;
                                    h = GUI_GRID_H;
                                };
                                class SearchButton: RscButton {
                                    idc = IDC_TELEPORTPLAYERS_PLAYERS_BUTTON;
                                    style = ST_CENTER + ST_PICTURE + ST_KEEP_ASPECT_RATIO;
                                    text = "\a3\Ui_f\data\GUI\RscCommon\RscButtonSearch\search_start_ca.paa";
                                    x = 0.5 * GUI_GRID_W;
                                    y = 5.65 * GUI_GRID_H;
                                    w = GUI_GRID_W;
                                    h = GUI_GRID_H;
                                    colorBackground[] = {0, 0, 0, 0.5};
                                    colorFocused[] = {0, 0, 0, 0.5};
                                };
                            };
                        };
                    };
                };
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};
