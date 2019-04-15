class RscText;
class RscEdit;
class RscCombo;
class RscFrame;
class RscButton;
class RscPicture;
class RscListBox;
class RscCheckBox;
class ctrlToolbox;
class ctrlXSliderH;
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

class GVAR(RscSides): RscControlsGroupNoScrollbars {
    idc = -1;
    x = 0;
    y = 0;
    w = POS_W(26);
    h = POS_H(2.5);
    class controls {
        class Label: EGVAR(attributes,RscLabel) {
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
        class BLUFOR: RscActivePicture {
            idc = IDC_BLUFOR;
            text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_west_ca.paa";
            tooltip = "$STR_WEST";
            x = POS_W(12.5);
            y = POS_H(0.25);
            w = POS_W(2);
            h = POS_H(2);
        };
        class OPFOR: BLUFOR {
            idc = IDC_OPFOR;
            text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_east_ca.paa";
            tooltip = "$STR_EAST";
            x = POS_W(15.5);
        };
        class Independent: BLUFOR {
            idc = IDC_INDEPENDENT;
            text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_guer_ca.paa";
            tooltip = "$STR_guerrila";
            x = POS_W(18.5);
        };
        class Civilian: BLUFOR {
            idc = IDC_CIVILIAN;
            text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_civ_ca.paa";
            tooltip = "$STR_civilian";
            x = POS_W(21.5);
        };
    };
};

class GVAR(RscLightSourceHelper) {
    idd = -1;
    onLoad = QUOTE(call FUNC(moduleLightSource));
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
    w = POS_W(26);
    h = POS_H(1.1);
    class controls {
        class Label: EGVAR(attributes,RscLabel) {
            text = CSTRING(AttributeRadius);
            tooltip = CSTRING(AttributeRadius_Tooltip);
            y = POS_H(0.1);
        };
        class Value: RscEdit {
            idc = IDC_ATTRIBUTERADIUS_VALUE;
            text = "100";
            x = POS_W(10.1);
            y = POS_H(0.1);
            w = POS_W(15.9);
            h = POS_H(1);
        };
    };
};

class GVAR(RscAttributeSlider): RscControlsGroupNoScrollbars {
    idc = -1;
    x = 0;
    y = 0;
    w = POS_W(26);
    h = POS_H(1);
    class controls {
        class Label: EGVAR(attributes,RscLabel) {};
        class Slider: ctrlXSliderH {
            idc = IDC_SLIDER;
            x = POS_W(10.1);
            y = 0;
            w = POS_W(13.8);
            h = POS_H(1);
        };
        class Edit: EGVAR(attributes,RscEdit) {
            idc = IDC_EDIT;
            x = POS_W(24);
            w = POS_W(2);
        };
    };
};

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

BEGIN_MODULE_DIALOG(RscCreateMinefield)
    class createMinefield: RscControlsGroupNoScrollbars {
        onSetFocus = QUOTE(_this call FUNC(ui_createMinefield));
        idc = IDC_CREATEMINEFIELD;
        x = 0;
        y = 0;
        w = POS_W(26);
        h = POS_H(3.2);
        class controls {
            class AreaLabel: EGVAR(attributes,RscLabel) {
                text = CSTRING(ModuleCreateMinefield_MineArea);
            };
            class AreaIconX: RscText {
                text = "$STR_3DEN_Axis_X";
                x = POS_W(10.1);
                y = 0;
                w = POS_W(1);
                h = POS_H(1);
                font = "RobotoCondensedLight";
                colorBackground[] = {0.77, 0.18, 0.1, 1};
                shadow = 0;
            };
            class AreaEditX: RscEdit {
                idc = IDC_CREATEMINEFIELD_AREA_X;
                text = "100";
                x = POS_W(11.2);
                y = pixelH;
                w = POS_W(6.8);
                h = POS_H(1) - pixelH;
            };
            class AreaIconY: AreaIconX {
                text = "$STR_3DEN_Axis_Y";
                x = POS_W(18.1);
                colorBackground[] = {0.58, 0.82, 0.22, 1};
            };
            class AreaEditY: AreaEditX {
                idc = IDC_CREATEMINEFIELD_AREA_Y;
                x = POS_W(19.2);
            };
            class TypeLabel: EGVAR(attributes,RscLabel) {
                text = CSTRING(ModuleCreateMinefield_MineType);
                y = POS_H(1.1);
            };
            class Type: EGVAR(attributes,RscCombo) {
                idc = IDC_CREATEMINEFIELD_TYPE;
                x = POS_W(10.1);
                y = POS_H(1.1);
                w = POS_W(15.9);
                h = POS_H(1);
                colorBackground[] = {0, 0, 0, 0.7};
            };
            class DensityLabel: EGVAR(attributes,RscLabel) {
                text = CSTRING(ModuleCreateMinefield_MineDensity);
                y = POS_H(2.2);
            };
            class Density: ctrlToolbox {
                idc = IDC_CREATEMINEFIELD_DENSITY;
                x = POS_W(10.1);
                y = POS_H(2.2);
                w = POS_W(15.9);
                h = POS_H(1);
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
END_MODULE_DIALOG;

BEGIN_MODULE_DIALOG(RscGlobalHint)
    class globalHint: RscControlsGroupNoScrollbars {
        onSetFocus = QUOTE(_this call FUNC(ui_globalHint));
        idc = IDC_GLOBALHINT;
        x = 0;
        y = 0;
        w = POS_W(26);
        h = POS_H(6);
        class controls {
            class Edit: RscEditMulti {
                idc = IDC_GLOBALHINT_EDIT;
                x = pixelW;
                y = pixelH;
                w = POS_W(13) - pixelW;
                h = POS_H(6) - pixelH;
                colorBackground[] = {0.25, 0.25, 0.25, 0.1};
            };
            class Container: RscControlsGroup {
                idc = -1;
                x = POS_W(13.1);
                y = 0;
                w = POS_W(12.9);
                h = POS_H(6);
                class controls {
                    class Preview: RscStructuredText {
                        idc = IDC_GLOBALHINT_PREVIEW;
                        x = 0;
                        y = 0;
                        w = POS_W(12.2);
                        h = 2 * safeZoneH;
                        size = POS_H(0.9); // Trial and error to get best representation of actual hint
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
END_MODULE_DIALOG;

BEGIN_MODULE_DIALOG(RscSideRelations)
    class sideRelations: RscControlsGroupNoScrollbars {
        onSetFocus = QUOTE(_this call FUNC(ui_sideRelations));
        idc = IDC_SIDERELATIONS;
        x = 0;
        y = 0;
        w = POS_W(26);
        h = POS_H(2.1);
        class controls {
            class RelationLabel: EGVAR(attributes,RscLabel) {
                text = CSTRING(RelationToChange);
            };
            class RelationToggle: ctrlButtonPictureKeepAspect {
                idc = IDC_SIDERELATIONS_TOGGLE;
                text = ICON_FRIENDLY;
                tooltip = CSTRING(FriendlyTo);
                x = POS_W(17.55);
                y = 0;
                w = POS_W(1);
                h = POS_H(1);
                colorBackground[] = {0, 0, 0, 0.7};
                tooltipColorBox[] = {1, 1, 1, 1};
                tooltipColorShade[] = {0, 0, 0, 0.65};
                offsetPressedX = 0;
                offsetPressedY = 0;
            };
            class RelationSide_1: EGVAR(attributes,RscCombo) {
                idc = IDC_SIDERELATIONS_SIDE_1;
                x = POS_W(10.1);
                y = 0;
                w = POS_W(7.35);
                h = POS_H(1);
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
                x = POS_W(18.65);
                class Items {}; // Special handling through script
            };
            class RadioLabel: EGVAR(attributes,RscLabel) {
                text = CSTRING(PlayRadioMessage);
                y = POS_H(1.1);
            };
            class Radio: GVAR(RscToolboxYesNo) {
                idc = IDC_SIDERELATIONS_RADIO;
                y = POS_H(1.1);
            };
        };
    };
END_MODULE_DIALOG;

BEGIN_MODULE_DIALOG(RscTeleportPlayers)
    class teleportPlayers: RscControlsGroupNoScrollbars {
        onSetFocus = QUOTE(_this call FUNC(ui_teleportPlayers));
        idc = IDC_TELEPORTPLAYERS;
        x = 0;
        y = 0;
        w = POS_W(26);
        h = POS_H(8.2);
        class controls {
            class Background: RscText {
                x = 0;
                y = POS_H(1);
                w = POS_W(26);
                h = POS_H(7.2);
                colorBackground[] = {1, 1, 1, 0.1};
            };
            class ButtonSides: RscButton {
                idc = IDC_TELEPORTPLAYERS_BUTTON_SIDES;
                text = CSTRING(Sides);
                font = "RobotoCondensedLight";
                x = 0;
                y = 0;
                w = POS_W(26/3);
                h = POS_H(1);
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
                x = POS_W(26/3);
            };
            class ButtonPlayers: ButtonSides {
                idc = IDC_TELEPORTPLAYERS_BUTTON_PLAYERS;
                text = CSTRING(Players);
                x = POS_W(52/3);
            };
            class TabSides: RscControlsGroupNoScrollbars {
                idc = IDC_TELEPORTPLAYERS_TAB_SIDES;
                x = 0;
                y = POS_H(1);
                w = POS_W(26);
                h = POS_H(7.2);
                class controls {
                    class BLUFOR: RscActivePicture {
                        idc = IDC_TELEPORTPLAYERS_BLUFOR;
                        text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_west_ca.paa";
                        x = POS_W(4.25);
                        y = POS_H(2.35);
                        w = POS_W(2.5);
                        h = POS_H(2.5);
                    };
                    class OPFOR: BLUFOR {
                        idc = IDC_TELEPORTPLAYERS_OPFOR;
                        text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_east_ca.paa";
                        x = POS_W(9.25);
                    };
                    class Independent: BLUFOR {
                        idc = IDC_TELEPORTPLAYERS_INDEPENDENT;
                        text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_guer_ca.paa";
                        x = POS_W(14.25);
                    };
                    class Civilian: BLUFOR {
                        idc = IDC_TELEPORTPLAYERS_CIVILIAN;
                        text = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_civ_ca.paa";
                        x = POS_W(19.25);
                    };
                };
            };
            class TabGroups: RscControlsGroupNoScrollbars {
                idc = IDC_TELEPORTPLAYERS_TAB_GROUPS;
                x = 0;
                y = POS_H(1);
                w = POS_W(26);
                h = POS_H(7.2);
                class controls {
                    class Groups: RscListBox {
                        idc = IDC_TELEPORTPLAYERS_GROUPS;
                        x = POS_W(0.5);
                        y = POS_H(0.5);
                        w = POS_W(25);
                        h = POS_H(5);
                        colorSelect[] = {1, 1, 1, 1};
                        colorSelect2[] = {1, 1, 1, 1};
                        colorBackground[] = {0, 0, 0, 0.5};
                        colorSelectBackground[] = {0, 0, 0, 0};
                        colorSelectBackground2[] = {0, 0, 0, 0};
                    };
                    class Search: RscEdit {
                        idc = IDC_TELEPORTPLAYERS_GROUPS_SEARCH;
                        x = POS_W(1.6);
                        y = POS_H(5.7);
                        w = POS_W(23.9);
                        h = POS_H(1);
                    };
                    class SearchButton: RscButton {
                        idc = IDC_TELEPORTPLAYERS_GROUPS_BUTTON;
                        style = ST_CENTER + ST_PICTURE + ST_KEEP_ASPECT_RATIO;
                        text = "\a3\Ui_f\data\GUI\RscCommon\RscButtonSearch\search_start_ca.paa";
                        x = POS_W(0.5);
                        y = POS_H(5.65);
                        w = POS_W(1);
                        h = POS_H(1);
                        colorBackground[] = {0, 0, 0, 0.5};
                        colorFocused[] = {0, 0, 0, 0.5};
                    };
                };
            };
            class TabPlayers: RscControlsGroupNoScrollbars {
                idc = IDC_TELEPORTPLAYERS_TAB_PLAYERS;
                x = 0;
                y = POS_H(1);
                w = POS_W(26);
                h = POS_H(7.2);
                class controls {
                    class Players: RscListBox {
                        idc = IDC_TELEPORTPLAYERS_PLAYERS;
                        x = POS_W(0.5);
                        y = POS_H(0.5);
                        w = POS_W(25);
                        h = POS_H(5);
                        colorSelect[] = {1, 1, 1, 1};
                        colorSelect2[] = {1, 1, 1, 1};
                        colorBackground[] = {0, 0, 0, 0.5};
                        colorSelectBackground[] = {0, 0, 0, 0};
                        colorSelectBackground2[] = {0, 0, 0, 0};
                    };
                    class Search: RscEdit {
                        idc = IDC_TELEPORTPLAYERS_PLAYERS_SEARCH;
                        x = POS_W(1.6);
                        y = POS_H(5.7);
                        w = POS_W(23.9);
                        h = POS_H(1);
                    };
                    class SearchButton: RscButton {
                        idc = IDC_TELEPORTPLAYERS_PLAYERS_BUTTON;
                        style = ST_CENTER + ST_PICTURE + ST_KEEP_ASPECT_RATIO;
                        text = "\a3\Ui_f\data\GUI\RscCommon\RscButtonSearch\search_start_ca.paa";
                        x = POS_W(0.5);
                        y = POS_H(5.65);
                        w = POS_W(1);
                        h = POS_H(1);
                        colorBackground[] = {0, 0, 0, 0.5};
                        colorFocused[] = {0, 0, 0, 0.5};
                    };
                };
            };
        };
    };
END_MODULE_DIALOG;

BEGIN_MODULE_DIALOG(RscDamageBuildings)
    class damageBuildings: RscControlsGroupNoScrollbars {
        onSetFocus = QUOTE(_this call FUNC(ui_damageBuildings));
        idc = IDC_DAMAGEBUILDINGS;
        x = 0;
        y = 0;
        w = POS_W(26);
        h = POS_H(4.2);
        class controls {
            class SelectionLabel: EGVAR(attributes,RscLabel) {
                text = CSTRING(BuildingSelection);
            };
            class SelectionMode: ctrlToolbox {
                idc = IDC_DAMAGEBUILDINGS_MODE;
                x = POS_W(10.1);
                y = 0;
                w = POS_W(13.8) - pixelW;
                h = POS_H(1);
                rows = 1;
                columns = 2;
                strings[] = {CSTRING(Nearest), CSTRING(Radius)};
            };
            class SelectionRadius: EGVAR(attributes,RscEdit) {
                idc = IDC_DAMAGEBUILDINGS_RADIUS;
                x = POS_W(24);
                w = POS_W(2);
                maxChars = 4;
            };
            class DamageLabel: EGVAR(attributes,RscLabel) {
                text = CSTRING(DamageState);
                tooltip = CSTRING(DamageState_Tooltip);
                y = POS_H(1.1);
                h = POS_H(2);
            };
            class DamageBlockLeft: RscText {
                idc = -1;
                x = POS_W(10.1);
                y = POS_H(1.1);
                w = POS_W(10);
                h = POS_H(2);
                colorBackground[] = {0, 0, 0, 0.5};
            };
            class DamageblockRight: DamageBlockLeft {
                x = POS_W(20.2);
                w = POS_W(5.8);
            };
            class Undamaged: RscCheckBox {
                idc = IDC_DAMAGEBUILDINGS_UNDAMAGED;
                tooltip = "$STR_a3_to_editTerrainObject15";
                x = POS_W(10.1);
                y = POS_H(1.1);
                w = POS_W(2);
                h = POS_H(2);
                color[] = {1, 1, 1, 1};
                colorBackground[] = {0, 0, 0, 0};
                colorBackgroundHover[] = {0, 0, 0, 0};
                colorBackgroundFocused[] = {0, 0, 0, 0};
                colorBackgroundPressed[] = {0, 0, 0, 0};
                colorBackgroundDisabled[] = {0, 0, 0, 0};
                CHECKBOX_TEXTURES(ICON_UNDAMAGED_UNCHECKED,ICON_UNDAMAGED_CHECKED);
            };
            class Damaged_1: Undamaged {
                idc = IDC_DAMAGEBUILDINGS_DAMAGED_1;
                tooltip = "$STR_a3_to_editTerrainObject16";
                x = POS_W(12.1);
                CHECKBOX_TEXTURES(ICON_DAMAGED_1_UNCHECKED,ICON_DAMAGED_1_CHECKED);
            };
            class Damaged_2: Undamaged {
                idc = IDC_DAMAGEBUILDINGS_DAMAGED_2;
                tooltip = "$STR_a3_to_editTerrainObject17";
                x = POS_W(14.1);
                CHECKBOX_TEXTURES(ICON_DAMAGED_2_UNCHECKED,ICON_DAMAGED_2_CHECKED);
            };
            class Damaged_3: Undamaged {
                idc = IDC_DAMAGEBUILDINGS_DAMAGED_3;
                tooltip = "$STR_a3_to_editTerrainObject18";
                x = POS_W(16.1);
                CHECKBOX_TEXTURES(ICON_DAMAGED_3_UNCHECKED,ICON_DAMAGED_3_CHECKED);
            };
            class Destroyed: Undamaged {
                idc = IDC_DAMAGEBUILDINGS_DESTROYED;
                tooltip = "$STR_a3_to_editTerrainObject19";
                x = POS_W(18.1);
                CHECKBOX_TEXTURES(ICON_DESTROYED_UNCHECKED,ICON_DESTROYED_CHECKED);
            };
            class EffectsLabel: EGVAR(attributes,RscLabel) {
                text = CSTRING(DestructionEffects);
                tooltip = CSTRING(DestructionEffects_Tooltip);
                y = POS_H(3.2);
            };
            class Effects: GVAR(RscToolboxYesNo) {
                idc = IDC_DAMAGEBUILDINGS_EFFECTS;
                y = POS_H(3.2);
            };
        };
    };
END_MODULE_DIALOG;

BEGIN_MODULE_DIALOG(RscAttachEffect)
    class attachEffect: RscControlsGroupNoScrollbars {
        onSetFocus = QUOTE(_this call FUNC(ui_attachEffect));
        idc = IDC_ATTACHEFFECT;
        x = 0;
        y = 0;
        w = POS_W(26);
        h = POS_H(7.5);
        class controls {
            class TargetLabel: EGVAR(attributes,RscLabel) {
                text = CSTRING(ModuleAttachEffect_Target);
            };
            class Target: EGVAR(attributes,RscCombo) {
                idc = IDC_ATTACHEFFECT_TARGET;
                class Items {
                    class Group {
                        text = CSTRING(ModuleAttachEffect_SelectedGroup);
                        picture = ICON_GROUP;
                        default = 1;
                    };
                    class BLUFOR {
                        text = "$STR_WEST";
                        picture = ICON_BLUFOR;
                    };
                    class OPFOR {
                        text = "$STR_EAST";
                        picture = ICON_OPFOR;
                    };
                    class Independent {
                        text = "$STR_guerrila";
                        picture = ICON_INDEPENDENT;
                    };
                    class Civilian {
                        text = "$STR_Civilian";
                        picture = ICON_CIVILIAN;
                    };
                };
            };
            class EffectLabel: EGVAR(attributes,RscLabel) {
                text = CSTRING(ModuleAttachEffect_Effect);
                y = POS_H(1.1);
                w = POS_W(26);
            };
            class Effect: RscListBox {
                idc = IDC_ATTACHEFFECT_EFFECT;
                x = 0;
                y = POS_H(2.1);
                w = POS_W(26);
                h = POS_H(5.4);
                sizeEx = POS_H(0.9);
                class Items {
                    class None {
                        text = "$STR_A3_None";
                        picture = QPATHTOF(ui\none_ca.paa);
                        data = "";
                        colorPictureSelected[] = {0, 0, 0, 1};
                        default = 1;
                    };
                    class Strobe {
                        text = "$STR_A3_CFGMAGAZINES_IR_GRENADE_DNS";
                        picture = "\a3\Modules_F_Curator\Data\portraitIRGrenade_ca.paa";
                        data = "O_IRStrobe";
                    };
                    class Blue {
                        text = "$STR_A3_CFGMAGAZINES_CHEMLIGHTT_BLUE_DNS";
                        picture = "\a3\Modules_F_Curator\Data\portraitChemlightBlue_ca.paa";
                        data = "Chemlight_Blue";
                    };
                    class Green {
                        text = "$STR_A3_CfgMagazines_Chemlight_dns";
                        picture = "\a3\Modules_F_Curator\Data\portraitChemlightGreen_ca.paa";
                        data = "Chemlight_Green";
                    };
                    class Red {
                        text = "$STR_A3_CFGMAGAZINES_CHEMLIGHTT_RED_DNS";
                        picture = "\a3\Modules_F_Curator\Data\portraitChemlightRed_ca.paa";
                        data = "Chemlight_Red";
                    };
                    class Yellow {
                        text = "$STR_A3_CFGMAGAZINES_CHEMLIGHTT_YELLOW_DNS";
                        picture = "\a3\Modules_F_Curator\Data\portraitChemlightYellow_ca.paa";
                        data = "Chemlight_Yellow";
                    };
                };
            };
        };
    };
END_MODULE_DIALOG;

BEGIN_MODULE_DIALOG(RscSetDate)
    class setDate: RscControlsGroupNoScrollbars {
        onSetFocus = QUOTE(_this call FUNC(ui_setDate));
        idc = IDC_SETDATE;
        x = 0;
        y = 0;
        w = POS_W(26);
        h = POS_H(6.1);
        class controls {
            class DateLabel: EGVAR(attributes,RscLabel) {
                text = "$STR_3DEN_Environment_Attribute_Date_displayName";
                w = POS_W(26);
            };
            class DateBackground: RscText {
                idc = -1;
                x = 0;
                y = POS_H(1);
                w = POS_W(26);
                h = POS_H(2);
                colorBackground[] = {1, 1, 1, 0.1};
            };
            class Year: EGVAR(attributes,RscCombo) {
                idc = IDC_SETDATE_YEAR;
                font = "RobotoCondensedLight";
                x = POS_W(3.9);
                y = POS_H(1.5);
                w = POS_W(6);
                sizeEx = POS_H(0.85);
            };
            class Month: Year {
                idc = IDC_SETDATE_MONTH;
                x = POS_W(10);
                class Items {
                    class Month1 {
                        text = "$STR_3DEN_Attributes_Date_Month1_text";
                        value = 1;
                    };
                    class Month2 {
                        text = "$STR_3DEN_Attributes_Date_Month2_text";
                        value = 2;
                    };
                    class Month3 {
                        text = "$STR_3DEN_Attributes_Date_Month3_text";
                        value = 3;
                    };
                    class Month4 {
                        text = "$STR_3DEN_Attributes_Date_Month4_text";
                        value = 4;
                    };
                    class Month5 {
                        text = "$STR_3DEN_Attributes_Date_Month5_text";
                        value = 5;
                    };
                    class Month6 {
                        text = "$STR_3DEN_Attributes_Date_Month6_text";
                        value = 6;
                    };
                    class Month7 {
                        text = "$STR_3DEN_Attributes_Date_Month7_text";
                        value = 7;
                    };
                    class Month8 {
                        text = "$STR_3DEN_Attributes_Date_Month8_text";
                        value = 8;
                    };
                    class Month9 {
                        text = "$STR_3DEN_Attributes_Date_Month9_text";
                        value = 9;
                    };
                    class Month10 {
                        text = "$STR_3DEN_Attributes_Date_Month10_text";
                        value = 10;
                    };
                    class Month11 {
                        text = "$STR_3DEN_Attributes_Date_Month11_text";
                        value = 11;
                    };
                    class Month12 {
                        text = "$STR_3DEN_Attributes_Date_Month12_text";
                        value = 12;
                    };
                };
            };
            class Day: Year {
                idc = IDC_SETDATE_DAY;
                x = POS_W(16.1);
            };
            class TimeLabel: DateLabel {
                text = "$STR_3DEN_Environment_Attribute_Daytime_displayName";
                y = POS_H(3.1);
            };
            class TimeBackground: DateBackground {
                y = POS_H(4.1);
            };
            class TimePreview: RscControlsGroupNoScrollbars {
                idc = IDC_SETDATE_PREVIEW;
                x = POS_W(5.05);
                y = POS_H(4.6);
                w = POS_W(9.8);
                h = POS_H(1);
                class controls {
                    class Night1: RscPicture {
                        idc = IDC_SETDATE_NIGHT1;
                        text = "\a3\3DEN\Data\Attributes\SliderTimeDay\night_ca.paa";
                        x = 0;
                        y = 0;
                        w = POS_W(0.5);
                        h = POS_H(1);
                        colorText[] = {1, 1, 1, 0.6};
                    };
                    class Night2: Night1 {
                        idc = IDC_SETDATE_NIGHT2;
                    };
                    class Daytime: Night1 {
                        idc = IDC_SETDATE_DAYTIME;
                        text = "\a3\3DEN\Data\Attributes\SliderTimeDay\day_ca.paa";
                    };
                    class Sunrise: Night1 {
                        idc = IDC_SETDATE_SUNRISE;
                        text = "\a3\3DEN\Data\Attributes\SliderTimeDay\sunrise_ca.paa";
                    };
                    class Sunset: Night1 {
                        idc = IDC_SETDATE_SUNSET;
                        text = "\a3\3DEN\Data\Attributes\SliderTimeDay\sunset_ca.paa";
                    };
                    class Sun: Night1 {
                        idc = IDC_SETDATE_SUN;
                        text = "\a3\3DEN\Data\Attributes\SliderTimeDay\sun_ca.paa";
                        x = POS_W(4.4);
                        w = POS_W(1);
                    };
                };
            };
            class Slider: ctrlXSliderH {
                idc = IDC_SETDATE_SLIDER;
                x = POS_W(3.9);
                y = POS_H(4.6);
                w = POS_W(12.1);
                h = POS_H(1);
                sliderRange[] = {0, 86399};
                sliderPosition = 0;
                lineSize = 3600;
                pageSize = 3600;
                border = "\a3\3DEN\Data\Attributes\SliderTimeDay\border_ca.paa";
                thumb  = "\a3\3DEN\Data\Attributes\SliderTimeDay\thumb_ca.paa";
            };
            /*
            class Frame: RscFrame {
                idc = -1;
                x = POS_W(16.1);
                y = POS_H(4.6);
                w = POS_W(6);
                h = POS_H(1);
                colorText[] = {0.75, 0.75, 0.75, 1};
            };
            */
            class Separator: RscText {
                idc = -1;
                style = ST_CENTER;
                text = ":   :";
                font = "EtelkaMonospacePro";
                x = POS_W(16.1);
                y = POS_H(4.6);
                w = POS_W(6);
                h = POS_H(1);
                colorBackground[] = {0, 0, 0, 0.5};
            };
            class Hour: EGVAR(attributes,RscEdit) {
                idc = IDC_SETDATE_HOUR;
                style = ST_CENTER + ST_NO_RECT;
                text = "00";
                tooltip = "$STR_3DEN_Attributes_SliderTime_Hour_tooltip";
                font = "EtelkaMonospacePro";
                x = POS_W(16.1);
                y = POS_H(4.6);
                w = POS_W(2);
                sizeEx = POS_H(0.9);
                colorBackground[] = {0, 0, 0, 0};
                maxChars = 2;
            };
            class Minute: Hour {
                idc = IDC_SETDATE_MINUTE;
                tooltip = "$STR_3DEN_Attributes_SliderTime_Minute_tooltip";
                x = POS_W(18.1);
            };
            class Second: Hour {
                idc = IDC_SETDATE_SECOND;
                tooltip = "$STR_3DEN_Attributes_SliderTime_Second_tooltip";
                x = POS_W(20.1);
            };
        };
    };
END_MODULE_DIALOG;
