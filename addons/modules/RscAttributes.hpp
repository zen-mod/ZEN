class RscText;
class RscEdit;
class RscCombo;
class RscFrame;
class RscPicture;
class RscListBox;
class RscCheckBox;
class ctrlToolbox;
class ctrlXSliderH;
class ctrlListNBox;
class RscEditMulti;
class RscStructuredText;
class ctrlButtonPictureKeepAspect;
class RscControlsGroup;
class RscControlsGroupNoScrollbars;

class EGVAR(attributes,RscLabel);
class EGVAR(attributes,RscBackground);
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
                class controls {

#define END_MODULE_DIALOG \
                }; \
            }; \
            class ButtonOK: ButtonOK {}; \
            class ButtonCancel: ButtonCancel {}; \
        }; \
    }

BEGIN_MODULE_DIALOG(RscEditableObjects)
    class editableObjects: RscControlsGroupNoScrollbars {
        idc = IDC_EDITABLEOBJECTS;
        function = QFUNC(gui_editableObjects);
        x = 0;
        y = 0;
        w = POS_W(26);
        h = POS_H(8.2);
        class controls {
            class EditingModeLabel: EGVAR(attributes,RscLabel) {
                text = CSTRING(ModuleEditableObjects_EditingMode);
                tooltip = CSTRING(ModuleEditableObjects_EditingMode_Tooltip);
            };
            class EditingMode: ctrlToolbox {
                idc = IDC_EDITABLEOBJECTS_MODE;
                x = POS_W(10.1);
                y = 0;
                w = POS_W(15.9);
                h = POS_H(1);
                rows = 1;
                columns = 2;
                strings[] = {CSTRING(ModuleEditableObjects_RemoveObjects), CSTRING(ModuleEditableObjects_AddObjects)};
            };
            class AllCuratorsLabel: EGVAR(attributes,RscLabel) {
                text = CSTRING(ModuleEditableObjects_AllCurators);
                tooltip = CSTRING(ModuleEditableObjects_AllCurators_Tooltip);
                y = POS_H(1.1);
            };
            class AllCurators: GVAR(RscToolboxYesNo) {
                idc = IDC_EDITABLEOBJECTS_CURATORS;
                y = POS_H(1.1);
            };
            class RangeLabel: EGVAR(attributes,RscLabel) {
                text = ECSTRING(common,Range);
                y = POS_H(2.2);
                h = POS_H(2.1);
            };
            class RangeMode: EditingMode {
                idc = IDC_EDITABLEOBJECTS_RANGE_MODE;
                y = POS_H(2.2);
                strings[] = {ECSTRING(common,Radius), CSTRING(ModuleEditableObjects_AllMissionObjects)};
            };
            class RangeSlider: ctrlXSliderH {
                idc = IDC_EDITABLEOBJECTS_RANGE_SLIDER;
                x = POS_W(10.1);
                y = POS_H(3.3);
                w = POS_W(13.4);
                h = POS_H(1);
            };
            class RangeEdit: EGVAR(attributes,RscEdit) {
                idc = IDC_EDITABLEOBJECTS_RANGE_EDIT;
                x = POS_W(23.6);
                y = POS_H(3.3);
                w = POS_W(2.4);
                h = POS_H(1);
            };
            class FilterLabel: EGVAR(attributes,RscLabel) {
                text = ECSTRING(common,Filter);
                y = POS_H(4.4);
                h = POS_H(3.8);
            };
            class FilterBackground: EGVAR(attributes,RscBackground) {
                y = POS_H(4.4);
                h = POS_H(3.8);
            };
            class FilterAll: RscCheckBox {
                idc = IDC_EDITABLEOBJECTS_FILTER_ALL;
                x = POS_W(10.1);
                y = POS_H(4.5);
                w = POS_W(0.9);
                h = POS_H(0.9);
                checked = 1;
            };
            class FilterAllText: RscText {
                idc = -1;
                text = ECSTRING(common,All);
                x = POS_W(11);
                y = POS_H(4.5);
                w = POS_W(10);
                h = POS_H(0.9);
                sizeEx = POS_H(0.9);
                shadow = 0;
            };
            class FilterUnits: FilterAll {
                idc = IDC_EDITABLEOBJECTS_FILTER_UNITS;
                y = POS_H(5.4);
            };
            class FilterUnitsText: FilterAllText {
                text = ECSTRING(common,Units);
                y = POS_H(5.4);
            };
            class FilterVehicles: FilterAll {
                idc = IDC_EDITABLEOBJECTS_FILTER_VEHICLES;
                y = POS_H(6.3);
            };
            class FilterVehiclesText: FilterAllText {
                text = ECSTRING(common,Vehicles);
                y = POS_H(6.3);
            };
            class FilterStatic: FilterAll {
                idc = IDC_EDITABLEOBJECTS_FILTER_STATIC;
                y = POS_H(7.2);
            };
            class FilterStaticText: FilterAllText {
                text = ECSTRING(common,Static);
                y = POS_H(7.2);
            };
        };
    };
END_MODULE_DIALOG;

BEGIN_MODULE_DIALOG(RscCAS)
    class cas: RscControlsGroupNoScrollbars {
        idc = IDC_CAS;
        function = QFUNC(gui_cas);
        x = 0;
        y = 0;
        w = POS_W(26);
        h = POS_H(8);
        class controls {
            class Label: EGVAR(attributes,RscLabel) {
                text = "$STR_DN_Plane";
                w = POS_W(26);
            };
            class Background: EGVAR(attributes,RscBackground) {
                x = 0;
                y = POS_H(1);
                w = POS_W(26);
                h = POS_H(7);
            };
            class List: ctrlListNBox {
                idc = IDC_CAS_LIST;
                x = 0;
                y = POS_H(1);
                w = POS_W(26);
                h = POS_H(7);
                columns[] = {0, 0.1, 0.25};
            };
        };
    };
END_MODULE_DIALOG;

BEGIN_MODULE_DIALOG(RscGlobalHint)
    class globalHint: RscControlsGroupNoScrollbars {
        idc = IDC_GLOBALHINT;
        function = QFUNC(gui_globalHint);
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
        idc = IDC_SIDERELATIONS;
        function = QFUNC(gui_sideRelations);
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

BEGIN_MODULE_DIALOG(RscDamageBuildings)
    class damageBuildings: RscControlsGroupNoScrollbars {
        idc = IDC_DAMAGEBUILDINGS;
        function = QFUNC(gui_damageBuildings);
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
                strings[] = {ECSTRING(common,Nearest), ECSTRING(common,Radius)};
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
        idc = IDC_ATTACHEFFECT;
        function = QFUNC(gui_attachEffect);
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
        idc = IDC_SETDATE;
        function = QFUNC(gui_setDate);
        x = 0;
        y = 0;
        w = POS_W(26);
        h = POS_H(6.1);
        class controls {
            class DateLabel: EGVAR(attributes,RscLabel) {
                text = "$STR_3DEN_Environment_Attribute_Date_displayName";
                w = POS_W(26);
            };
            class DateBackground: EGVAR(attributes,RscBackground) {
                x = 0;
                y = POS_H(1);
                w = POS_W(26);
                h = POS_H(2);
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

BEGIN_MODULE_DIALOG(RscAmbientFlyby)
    class ambientFlyby: RscControlsGroupNoScrollbars {
        idc = IDC_AMBIENTFLYBY;
        function = QFUNC(gui_ambientFlyby);
        x = 0;
        y = 0;
        w = POS_W(26);
        h = POS_H(9.9);
        class controls {
            class AircraftSelect: RscControlsGroupNoScrollbars {
                idc = -1;
                x = 0;
                y = 0;
                w = POS_W(26);
                h = POS_H(4.4);
                class controls {
                    class Title: EGVAR(attributes,RscLabel) {
                        text = CSTRING(ModuleAmbientFlyby_AircraftSelect);
                        w = POS_W(26);
                    };
                    class Background: EGVAR(attributes,RscBackground) {
                        x = 0;
                        y = POS_H(1);
                        w = POS_W(26);
                        h = POS_H(3.4);
                    };
                    class SideLabel: EGVAR(attributes,RscLabel) {
                        text = ECSTRING(common,Side);
                        x = POS_W(3);
                        y = POS_H(1.1);
                        w = POS_W(8.9);
                        colorBackground[] = {0, 0, 0, 0.7};
                    };
                    class SideCombo: EGVAR(attributes,RscCombo) {
                        idc = IDC_AMBIENTFLYBY_SIDE;
                        x = POS_W(12);
                        y = POS_H(1.1);
                        w = POS_W(11);
                        class Items {
                            class BLUFOR {
                                text = "$STR_West";
                                picture = ICON_BLUFOR;
                            };
                            class OPFOR {
                                text = "$STR_East";
                                picture = ICON_OPFOR;
                            };
                            class Independent {
                                text = "$STR_Guerrila";
                                picture = ICON_INDEPENDENT;
                            };
                            class Civilian {
                                text = "$STR_Civilian";
                                picture = ICON_CIVILIAN;
                            };
                        };
                    };
                    class FactionLabel: SideLabel {
                        text = ECSTRING(common,Faction);
                        y = POS_H(2.2);
                    };
                    class FactionCombo: SideCombo {
                        idc = IDC_AMBIENTFLYBY_FACTION;
                        y = POS_H(2.2);
                        wholeHeight = POS_H(6);
                        class Items {};
                    };
                    class AircraftLabel: FactionLabel {
                        text = ECSTRING(common,Aircraft);
                        y = POS_H(3.3);
                    };
                    class AircraftCombo: FactionCombo {
                        idc = IDC_AMBIENTFLYBY_AIRCRAFT;
                        y = POS_H(3.3);
                        wholeHeight = POS_H(5);
                    };
                };
            };
            class DirectionLabel: EGVAR(attributes,RscLabel) {
                text = CSTRING(ModuleAmbientFlyby_FlyTowards);
                tooltip = CSTRING(ModuleAmbientFlyby_FlyTowards_Tooltip);
                y = POS_H(4.5);
            };
            class Direction: ctrlToolbox {
                idc = IDC_AMBIENTFLYBY_DIRECTION;
                x = POS_W(10.1);
                y = POS_H(4.5);
                w = POS_W(15.9);
                h = POS_H(1);
                rows = 1;
                columns = 8;
                strings[] = {"N", "NE", "E", "SE", "S", "SW", "W", "NW"};
            };
            class HeightLabel: EGVAR(attributes,RscLabel) {
                text = ECSTRING(common,Height);
                tooltip = CSTRING(ModuleAmbientFlyby_Height_Tooltip);
                y = POS_H(5.6);
            };
            class HeightSlider: ctrlXSliderH {
                idc = IDC_AMBIENTFLYBY_HEIGHT_SLIDER;
                x = POS_W(10.1);
                y = POS_H(5.6);
                w = POS_W(13.4);
                h = POS_H(1);
            };
            class HeightEdit: EGVAR(attributes,RscEdit) {
                idc = IDC_AMBIENTFLYBY_HEIGHT_EDIT;
                x = POS_W(23.6);
                y = POS_H(5.6);
                w = POS_W(2.4);
                h = POS_H(1);
            };
            class DistanceLabel: EGVAR(attributes,RscLabel) {
                text = CSTRING(ModuleAmbientFlyby_Distance);
                tooltip = CSTRING(ModuleAmbientFlyby_Distance_Tooltip);
                y = POS_H(6.7);
            };
            class DistanceSlider: HeightSlider {
                idc = IDC_AMBIENTFLYBY_DISTANCE_SLIDER;
                y = POS_H(6.7);
            };
            class DistanceEdit: HeightEdit {
                idc = IDC_AMBIENTFLYBY_DISTANCE_EDIT;
                y = POS_H(6.7);
            };
            class SpeedLabel: EGVAR(attributes,RscLabel) {
                text = ECSTRING(common,Speed);
                tooltip = CSTRING(ModuleAmbientFlyby_Speed_Tooltip);
                y = POS_H(7.8);
            };
            class Speed: Direction {
                idc = IDC_AMBIENTFLYBY_SPEED;
                y = POS_H(7.8);
                columns = 3;
                strings[] = {"$STR_A3_Slow", "$STR_A3_Normal", "$STR_A3_Fast"};
            };
            class AmountLabel: EGVAR(attributes,RscLabel) {
                text = CSTRING(ModuleAmbientFlyby_Amount);
                tooltip = CSTRING(ModuleAmbientFlyby_Amount_Tooltip);
                y = POS_H(8.9);
            };
            class Amount: Direction {
                idc = IDC_AMBIENTFLYBY_AMOUNT;
                y = POS_H(8.9);
                columns = 6;
                strings[] = {"1", "2", "3", "4", "5", "6"};
            };
        };
    };
END_MODULE_DIALOG;

BEGIN_MODULE_DIALOG(RscExecuteCode)
    class executeCode: RscControlsGroupNoScrollbars {
        idc = IDC_EXECUTECODE;
        function = QFUNC(gui_executeCode);
        x = 0;
        y = 0;
        w = POS_W(26);
        h = POS_H(15.2);
        class controls {
            class History: EGVAR(attributes,RscCombo) {
                idc = IDC_EXECUTECODE_HISTORY;
                font = "EtelkaMonospacePro";
                x = 0;
                w = POS_W(26);
                sizeEx = POS_H(0.7);
            };
            class Edit: EGVAR(attributes,RscEdit) {
                idc = IDC_EXECUTECODE_EDIT;
                style = ST_MULTI;
                font = "EtelkaMonospacePro";
                tooltip = CSTRING(ModuleExecuteCode_Args_Tooltip);
                x = pixelW;
                y = POS_H(1.1);
                w = POS_W(26) - pixelW;
                h = POS_H(13);
                sizeEx = POS_H(0.7);
                autocomplete = "scripting";
                default = 1;
            };
            class Mode: ctrlToolbox {
                idc = IDC_EXECUTECODE_MODE;
                x = 0;
                y = POS_H(14.2);
                w = POS_W(26);
                h = POS_H(1);
                rows = 1;
                columns = 4;
                strings[] = {
                    CSTRING(ModuleExecuteCode_Local),
                    CSTRING(ModuleExecuteCode_Server),
                    CSTRING(ModuleExecuteCode_Global),
                    CSTRING(ModuleExecuteCode_GlobalAndJIP)
                };
            };
        };
    };
END_MODULE_DIALOG;

BEGIN_MODULE_DIALOG(RscFireMission)
    class fireMission: RscControlsGroupNoScrollbars {
        idc = IDC_FIREMISSION;
        function = QFUNC(gui_fireMission);
        x = 0;
        y = 0;
        w = POS_W(26);
        h = POS_H(8.9);
        class controls {
            class TargetingLabel: EGVAR(attributes,RscLabel) {
                text = CSTRING(ModuleFireMission_Targetting);
                w = POS_W(26);
            };
            class TargetingBackground: RscText {
                idc = -1;
                x = 0;
                y = POS_H(1);
                w = POS_W(26);
                h = POS_H(3.4);
                colorBackground[] = {1, 1, 1, 0.1};
            };
            class ModeLabel: EGVAR(attributes,RscLabel) {
                text = CSTRING(ModuleFireMission_Mode);
                x = POS_W(1);
                y = POS_H(1.1);
                w = POS_W(8);
                colorBackground[] = {0, 0, 0, 0.6};
            };
            class Mode: ctrlToolbox {
                idc = IDC_FIREMISSION_MODE;
                x = POS_W(9.1);
                y = POS_H(1.1);
                w = POS_W(15.9);
                h = POS_H(1);
                rows = 1;
                columns = 2;
                strings[] = {CSTRING(ModuleFireMission_MapGrid), CSTRING(ModuleFireMission_TargetModule)};
            };
            class TargetLabel: ModeLabel {
                idc = IDC_FIREMISSION_TARGET_LABEL;
                text = "$STR_3den_display3den_menubar_grid_text";
                y = POS_H(2.2);
            };
            class TargetGrid: EGVAR(attributes,RscEdit) {
                idc = IDC_FIREMISSION_TARGET_GRID;
                x = POS_W(9.1);
                y = POS_H(2.2) + pixelH;
                colorBackground[] = {0, 0, 0, 0.3};
            };
            class TargetLogic: EGVAR(attributes,RscCombo) {
                idc = IDC_FIREMISSION_TARGET_LOGIC;
                x = POS_W(9.1);
                y = POS_H(2.2);
            };
            class SpreadLabel: ModeLabel {
                text = CSTRING(ModuleFireMission_Spread);
                tooltip = CSTRING(ModuleFireMission_Spread_Tooltip);
                y = POS_H(3.3);
            };
            class SpreadSlider: ctrlXSliderH {
                idc = IDC_FIREMISSION_SPREAD_SLIDER;
                x = POS_W(9.1);
                y = POS_H(3.3);
                w = POS_W(13.4);
                h = POS_H(1);
            };
            class SpreadEdit: EGVAR(attributes,RscEdit) {
                idc = IDC_FIREMISSION_SPREAD_EDIT;
                x = POS_W(22.6);
                y = POS_H(3.3);
                w = POS_W(2.4);
                colorBackground[] = {0, 0, 0, 0.3};
            };
            class FireParamsLabel: TargetingLabel {
                text = CSTRING(ModuleFireMission_FireParameters);
                y = POS_H(4.5);
            };
            class FireParamsBackground: TargetingBackground {
                y = POS_H(5.5);
            };
            class UnitsLabel: ModeLabel {
                text = CSTRING(ModuleFireMission_Units);
                tooltip = CSTRING(ModuleFireMission_Units_Tooltip);
                y = POS_H(5.6);
            };
            class Units: TargetLogic {
                idc = IDC_FIREMISSION_UNITS;
                y = POS_H(5.6);
            };
            class AmmoLabel: ModeLabel {
                text = CSTRING(ModuleFireMission_Ammo);
                y = POS_H(6.7);
            };
            class Ammo: Units {
                idc = IDC_FIREMISSION_AMMO;
                y = POS_H(6.7);
            };
            class RoundsLabel: ModeLabel {
                text = CSTRING(ModuleFireMission_Rounds);
                tooltip = CSTRING(ModuleFireMission_Rounds_Tooltip);
                y = POS_H(7.8);
            };
            class Rounds: TargetGrid {
                idc = IDC_FIREMISSION_ROUNDS;
                y = POS_H(7.8) + pixelH;
            };
        };
    };
END_MODULE_DIALOG;

BEGIN_MODULE_DIALOG(RscPlayMusic)
    class playMusic: RscControlsGroupNoScrollbars {
        idc = IDC_PLAYMUSIC;
        function = QFUNC(gui_playMusic);
        x = 0;
        y = 0;
        w = POS_W(26);
        h = POS_H(8.9);
        class controls {
            // Owners
            // Searchbar for the tree
            // Music tree with alphabetical trees
            // Music volume slider
        };
    };
END_MODULE_DIALOG
