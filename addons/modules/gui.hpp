class RscText;
class RscEdit;
class RscCombo;
class RscPicture;
class RscListBox;
class RscEditMulti;
class RscStructuredText;
class RscControlsGroup;
class RscControlsGroupNoScrollbars;

class ctrlTree;
class ctrlListbox;
class ctrlToolbox;
class ctrlCheckbox;
class ctrlXSliderH;
class ctrlListNBox;
class ctrlButtonPictureKeepAspect;

class EGVAR(common,RscLabel);
class EGVAR(common,RscBackground);
class EGVAR(common,RscEdit);
class EGVAR(common,RscCheckbox);
class EGVAR(common,RscCombo);
class EGVAR(common,RscControlsGroup);

class EGVAR(common,RscDisplay) {
    class controls {
        class Title;
        class Background;
        class Content;
        class ButtonOK;
        class ButtonCancel;
    };
};

class GVAR(RscDisplay): EGVAR(common,RscDisplay) {
    onLoad = QUOTE(call FUNC(initDisplay));
    function = "";
    checkLogic = 0;
};

class GVAR(RscToolboxYesNo): ctrlToolbox {
    idc = -1;
    x = QUOTE(POS_W(10.1));
    y = 0;
    w = QUOTE(POS_W(15.9));
    h = QUOTE(POS_H(1));
    rows = 1;
    columns = 2;
    strings[] = {ECSTRING(common,No), ECSTRING(common,Yes)};
};

class GVAR(RscSidesCombo): EGVAR(common,RscCombo) {
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

class GVAR(RscEffectFireHelper) {
    idd = -1;
    onLoad = QUOTE(call FUNC(moduleEffectFire));
};

class GVAR(RscLightSourceHelper) {
    idd = -1;
    onLoad = QUOTE(call FUNC(moduleLightSource));
};

class GVAR(RscAmbientFlyby): GVAR(RscDisplay) {
    function = QFUNC(gui_ambientFlyby);
    class controls: controls {
        class Title: Title {};
        class Background: Background {};
        class Content: Content {
            h = QUOTE(POS_H(11));
            class controls {
                class AircraftSelect: RscControlsGroupNoScrollbars {
                    idc = -1;
                    x = 0;
                    y = 0;
                    w = QUOTE(POS_W(26));
                    h = QUOTE(POS_H(4.4));
                    class controls {
                        class Title: EGVAR(common,RscLabel) {
                            text = CSTRING(ModuleAmbientFlyby_AircraftSelect);
                            w = QUOTE(POS_W(26));
                        };
                        class Background: EGVAR(common,RscBackground) {
                            x = 0;
                            y = QUOTE(POS_H(1));
                            w = QUOTE(POS_W(26));
                            h = QUOTE(POS_H(3.4));
                        };
                        class SideLabel: EGVAR(common,RscLabel) {
                            text = ECSTRING(common,Side);
                            x = QUOTE(POS_W(3));
                            y = QUOTE(POS_H(1.1));
                            w = QUOTE(POS_W(8.9));
                            colorBackground[] = {0, 0, 0, 0.7};
                        };
                        class SideCombo: GVAR(RscSidesCombo) {
                            idc = IDC_AMBIENTFLYBY_SIDE;
                            x = QUOTE(POS_W(12));
                            y = QUOTE(POS_H(1.1));
                            w = QUOTE(POS_W(11));
                        };
                        class FactionLabel: SideLabel {
                            text = ECSTRING(common,Faction);
                            y = QUOTE(POS_H(2.2));
                        };
                        class FactionCombo: SideCombo {
                            idc = IDC_AMBIENTFLYBY_FACTION;
                            y = QUOTE(POS_H(2.2));
                            wholeHeight = QUOTE(POS_H(6));
                            class Items {};
                        };
                        class AircraftLabel: FactionLabel {
                            text = ECSTRING(common,Aircraft);
                            y = QUOTE(POS_H(3.3));
                        };
                        class AircraftCombo: FactionCombo {
                            idc = IDC_AMBIENTFLYBY_AIRCRAFT;
                            y = QUOTE(POS_H(3.3));
                            wholeHeight = QUOTE(POS_H(5));
                        };
                    };
                };
                class DirectionLabel: EGVAR(common,RscLabel) {
                    text = CSTRING(ModuleAmbientFlyby_FlyTowards);
                    tooltip = CSTRING(ModuleAmbientFlyby_FlyTowards_Tooltip);
                    y = QUOTE(POS_H(4.5));
                };
                class Direction: ctrlToolbox {
                    idc = IDC_AMBIENTFLYBY_DIRECTION;
                    x = QUOTE(POS_W(10.1));
                    y = QUOTE(POS_H(4.5));
                    w = QUOTE(POS_W(15.9));
                    h = QUOTE(POS_H(1));
                    rows = 1;
                    columns = 8;
                    strings[] = {"N", "NE", "E", "SE", "S", "SW", "W", "NW"};
                };
                class HeightLabel: EGVAR(common,RscLabel) {
                    text = ECSTRING(common,Height);
                    tooltip = CSTRING(ModuleAmbientFlyby_Height_Tooltip);
                    y = QUOTE(POS_H(5.6));
                    h = QUOTE(POS_H(2.1));
                };
                class HeightMode: Direction {
                    idc = IDC_AMBIENTFLYBY_HEIGHT_MODE;
                    y = QUOTE(POS_H(5.6));
                    columns = 2;
                    strings[] = {
                        CSTRING(ModuleAmbientFlyby_Height_Mode_AGL),
                        CSTRING(ModuleAmbientFlyby_Height_Mode_ASL)
                    };
                    tooltips[] = {
                        CSTRING(ModuleAmbientFlyby_Height_Mode_AGL_Tooltip),
                        CSTRING(ModuleAmbientFlyby_Height_Mode_ASL_Tooltip)
                    };
                };
                class HeightSlider: ctrlXSliderH {
                    idc = IDC_AMBIENTFLYBY_HEIGHT_SLIDER;
                    x = QUOTE(POS_W(10.1));
                    y = QUOTE(POS_H(6.7));
                    w = QUOTE(POS_W(13.4));
                    h = QUOTE(POS_H(1));
                };
                class HeightEdit: EGVAR(common,RscEdit) {
                    idc = IDC_AMBIENTFLYBY_HEIGHT_EDIT;
                    x = QUOTE(POS_W(23.6));
                    y = QUOTE(POS_H(6.7));
                    w = QUOTE(POS_W(2.4));
                    h = QUOTE(POS_H(1));
                };
                class DistanceLabel: EGVAR(common,RscLabel) {
                    text = CSTRING(ModuleAmbientFlyby_Distance);
                    tooltip = CSTRING(ModuleAmbientFlyby_Distance_Tooltip);
                    y = QUOTE(POS_H(7.8));
                };
                class DistanceSlider: HeightSlider {
                    idc = IDC_AMBIENTFLYBY_DISTANCE_SLIDER;
                    y = QUOTE(POS_H(7.8));
                };
                class DistanceEdit: HeightEdit {
                    idc = IDC_AMBIENTFLYBY_DISTANCE_EDIT;
                    y = QUOTE(POS_H(7.8));
                };
                class SpeedLabel: EGVAR(common,RscLabel) {
                    text = ECSTRING(common,Speed);
                    tooltip = CSTRING(ModuleAmbientFlyby_Speed_Tooltip);
                    y = QUOTE(POS_H(8.9));
                };
                class Speed: Direction {
                    idc = IDC_AMBIENTFLYBY_SPEED;
                    y = QUOTE(POS_H(8.9));
                    columns = 3;
                    strings[] = {"$STR_A3_Slow", "$STR_A3_Normal", "$STR_A3_Fast"};
                };
                class AmountLabel: EGVAR(common,RscLabel) {
                    text = CSTRING(ModuleAmbientFlyby_Amount);
                    tooltip = CSTRING(ModuleAmbientFlyby_Amount_Tooltip);
                    y = QUOTE(POS_H(10));
                };
                class Amount: Direction {
                    idc = IDC_AMBIENTFLYBY_AMOUNT;
                    y = QUOTE(POS_H(10));
                    columns = 6;
                    strings[] = {"1", "2", "3", "4", "5", "6"};
                };
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};

class GVAR(RscCAS): GVAR(RscDisplay) {
    function = QFUNC(gui_cas);
    checkLogic = 1;
    class controls: controls {
        class Title: Title {};
        class Background: Background {};
        class Content: Content {
            h = QUOTE(POS_H(8));
            class controls {
                class Label: EGVAR(common,RscLabel) {
                    text = "$STR_DN_Plane";
                    w = QUOTE(POS_W(26));
                };
                class Background: EGVAR(common,RscBackground) {
                    x = 0;
                    y = QUOTE(POS_H(1));
                    w = QUOTE(POS_W(26));
                    h = QUOTE(POS_H(7));
                };
                class List: ctrlListNBox {
                    idc = IDC_CAS_LIST;
                    x = 0;
                    y = QUOTE(POS_H(1));
                    w = QUOTE(POS_W(26));
                    h = QUOTE(POS_H(7));
                    columns[] = {0, 0.1, 0.25};
                };
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};

class GVAR(RscDamageBuildings): GVAR(RscDisplay) {
    function = QFUNC(gui_damageBuildings);
    class controls: controls {
        class Title: Title {};
        class Background: Background {};
        class Content: Content {
            h = QUOTE(POS_H(4.2));
            class controls {
                class SelectionLabel: EGVAR(common,RscLabel) {
                    text = CSTRING(BuildingSelection);
                };
                class SelectionMode: ctrlToolbox {
                    idc = IDC_DAMAGEBUILDINGS_MODE;
                    x = QUOTE(POS_W(10.1));
                    y = 0;
                    w = QUOTE(POS_W(13.8) - pixelW);
                    h = QUOTE(POS_H(1));
                    rows = 1;
                    columns = 2;
                    strings[] = {ECSTRING(common,Nearest), ECSTRING(common,Radius)};
                };
                class SelectionRadius: EGVAR(common,RscEdit) {
                    idc = IDC_DAMAGEBUILDINGS_RADIUS;
                    x = QUOTE(POS_W(24));
                    w = QUOTE(POS_W(2));
                    maxChars = 4;
                };
                class DamageLabel: EGVAR(common,RscLabel) {
                    text = CSTRING(DamageState);
                    tooltip = CSTRING(DamageState_Tooltip);
                    y = QUOTE(POS_H(1.1));
                    h = QUOTE(POS_H(2));
                };
                class DamageBlockLeft: RscText {
                    idc = -1;
                    x = QUOTE(POS_W(10.1));
                    y = QUOTE(POS_H(1.1));
                    w = QUOTE(POS_W(10));
                    h = QUOTE(POS_H(2));
                    colorBackground[] = {0, 0, 0, 0.5};
                };
                class DamageblockRight: DamageBlockLeft {
                    x = QUOTE(POS_W(20.2));
                    w = QUOTE(POS_W(5.8));
                };
                class Undamaged: EGVAR(common,RscCheckbox) {
                    idc = IDC_DAMAGEBUILDINGS_UNDAMAGED;
                    tooltip = "$STR_a3_to_editTerrainObject15";
                    x = QUOTE(POS_W(10.1));
                    y = QUOTE(POS_H(1.1));
                    w = QUOTE(POS_W(2));
                    h = QUOTE(POS_H(2));
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
                    x = QUOTE(POS_W(12.1));
                    CHECKBOX_TEXTURES(ICON_DAMAGED_1_UNCHECKED,ICON_DAMAGED_1_CHECKED);
                };
                class Damaged_2: Undamaged {
                    idc = IDC_DAMAGEBUILDINGS_DAMAGED_2;
                    tooltip = "$STR_a3_to_editTerrainObject17";
                    x = QUOTE(POS_W(14.1));
                    CHECKBOX_TEXTURES(ICON_DAMAGED_2_UNCHECKED,ICON_DAMAGED_2_CHECKED);
                };
                class Damaged_3: Undamaged {
                    idc = IDC_DAMAGEBUILDINGS_DAMAGED_3;
                    tooltip = "$STR_a3_to_editTerrainObject18";
                    x = QUOTE(POS_W(16.1));
                    CHECKBOX_TEXTURES(ICON_DAMAGED_3_UNCHECKED,ICON_DAMAGED_3_CHECKED);
                };
                class Destroyed: Undamaged {
                    idc = IDC_DAMAGEBUILDINGS_DESTROYED;
                    tooltip = "$STR_a3_to_editTerrainObject19";
                    x = QUOTE(POS_W(18.1));
                    CHECKBOX_TEXTURES(ICON_DESTROYED_UNCHECKED,ICON_DESTROYED_CHECKED);
                };
                class EffectsLabel: EGVAR(common,RscLabel) {
                    text = CSTRING(DestructionEffects);
                    tooltip = CSTRING(DestructionEffects_Tooltip);
                    y = QUOTE(POS_H(3.2));
                };
                class Effects: GVAR(RscToolboxYesNo) {
                    idc = IDC_DAMAGEBUILDINGS_EFFECTS;
                    y = QUOTE(POS_H(3.2));
                };
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};

class GVAR(RscEditableObjects): GVAR(RscDisplay) {
    function = QFUNC(gui_editableObjects);
    class controls: controls {
        class Title: Title {};
        class Background: Background {};
        class Content: Content {
            h = QUOTE(POS_H(8.2));
            class controls {
                class EditingModeLabel: EGVAR(common,RscLabel) {
                    text = CSTRING(ModuleEditableObjects_EditingMode);
                    tooltip = CSTRING(ModuleEditableObjects_EditingMode_Tooltip);
                };
                class EditingMode: ctrlToolbox {
                    idc = IDC_EDITABLEOBJECTS_MODE;
                    x = QUOTE(POS_W(10.1));
                    y = 0;
                    w = QUOTE(POS_W(15.9));
                    h = QUOTE(POS_H(1));
                    rows = 1;
                    columns = 2;
                    strings[] = {CSTRING(ModuleEditableObjects_RemoveObjects), CSTRING(ModuleEditableObjects_AddObjects)};
                };
                class AllCuratorsLabel: EGVAR(common,RscLabel) {
                    text = CSTRING(ModuleEditableObjects_AllCurators);
                    tooltip = CSTRING(ModuleEditableObjects_AllCurators_Tooltip);
                    y = QUOTE(POS_H(1.1));
                };
                class AllCurators: GVAR(RscToolboxYesNo) {
                    idc = IDC_EDITABLEOBJECTS_CURATORS;
                    y = QUOTE(POS_H(1.1));
                };
                class RangeLabel: EGVAR(common,RscLabel) {
                    text = ECSTRING(common,Range);
                    y = QUOTE(POS_H(2.2));
                    h = QUOTE(POS_H(2.1));
                };
                class RangeMode: EditingMode {
                    idc = IDC_EDITABLEOBJECTS_RANGE_MODE;
                    y = QUOTE(POS_H(2.2));
                    strings[] = {ECSTRING(common,Radius), CSTRING(ModuleEditableObjects_AllMissionObjects)};
                };
                class RangeSlider: ctrlXSliderH {
                    idc = IDC_EDITABLEOBJECTS_RANGE_SLIDER;
                    x = QUOTE(POS_W(10.1));
                    y = QUOTE(POS_H(3.3));
                    w = QUOTE(POS_W(13.4));
                    h = QUOTE(POS_H(1));
                };
                class RangeEdit: EGVAR(common,RscEdit) {
                    idc = IDC_EDITABLEOBJECTS_RANGE_EDIT;
                    x = QUOTE(POS_W(23.6));
                    y = QUOTE(POS_H(3.3));
                    w = QUOTE(POS_W(2.4));
                    h = QUOTE(POS_H(1));
                };
                class FilterLabel: EGVAR(common,RscLabel) {
                    text = ECSTRING(common,Filter);
                    y = QUOTE(POS_H(4.4));
                    h = QUOTE(POS_H(3.8));
                };
                class FilterBackground: EGVAR(common,RscBackground) {
                    y = QUOTE(POS_H(4.4));
                    h = QUOTE(POS_H(3.8));
                };
                class FilterAll: ctrlCheckbox {
                    idc = IDC_EDITABLEOBJECTS_FILTER_ALL;
                    x = QUOTE(POS_W(10.1));
                    y = QUOTE(POS_H(4.5));
                    w = QUOTE(POS_W(0.9));
                    h = QUOTE(POS_H(0.9));
                };
                class FilterAllText: RscText {
                    idc = -1;
                    text = ECSTRING(common,All);
                    x = QUOTE(POS_W(11));
                    y = QUOTE(POS_H(4.5));
                    w = QUOTE(POS_W(10));
                    h = QUOTE(POS_H(0.9));
                    sizeEx = QUOTE(POS_H(0.9));
                    shadow = 0;
                };
                class FilterUnits: FilterAll {
                    idc = IDC_EDITABLEOBJECTS_FILTER_UNITS;
                    y = QUOTE(POS_H(5.4));
                };
                class FilterUnitsText: FilterAllText {
                    text = ECSTRING(common,Units);
                    y = QUOTE(POS_H(5.4));
                };
                class FilterVehicles: FilterAll {
                    idc = IDC_EDITABLEOBJECTS_FILTER_VEHICLES;
                    y = QUOTE(POS_H(6.3));
                };
                class FilterVehiclesText: FilterAllText {
                    text = ECSTRING(common,Vehicles);
                    y = QUOTE(POS_H(6.3));
                };
                class FilterStatic: FilterAll {
                    idc = IDC_EDITABLEOBJECTS_FILTER_STATIC;
                    y = QUOTE(POS_H(7.2));
                };
                class FilterStaticText: FilterAllText {
                    text = ECSTRING(common,Static);
                    y = QUOTE(POS_H(7.2));
                };
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};

class GVAR(RscExecuteCode): GVAR(RscDisplay) {
    function = QFUNC(gui_executeCode);
    checkLogic = 1;
    class controls: controls {
        class Title: Title {};
        class Background: Background {};
        class Content: Content {
            h = QUOTE(POS_H(15.2));
            class controls {
                class History: EGVAR(common,RscCombo) {
                    idc = IDC_EXECUTECODE_HISTORY;
                    font = "EtelkaMonospacePro";
                    x = 0;
                    w = QUOTE(POS_W(26));
                    sizeEx = QUOTE(POS_H(0.7));
                };
                class Edit: EGVAR(common,RscEdit) {
                    idc = IDC_EXECUTECODE_EDIT;
                    style = ST_MULTI;
                    font = "EtelkaMonospacePro";
                    tooltip = CSTRING(ModuleExecuteCode_Args_Tooltip);
                    x = QUOTE(pixelW);
                    y = QUOTE(POS_H(1.1));
                    w = QUOTE(POS_W(26) - pixelW);
                    h = QUOTE(POS_H(13));
                    sizeEx = QUOTE(POS_H(0.7));
                    autocomplete = "scripting";
                    default = 1;
                };
                class Mode: ctrlToolbox {
                    idc = IDC_EXECUTECODE_MODE;
                    x = 0;
                    y = QUOTE(POS_H(14.2));
                    w = QUOTE(POS_W(26));
                    h = QUOTE(POS_H(1));
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
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};

class GVAR(RscFireMission): GVAR(RscDisplay) {
    function = QFUNC(gui_fireMission);
    class controls: controls {
        class Title: Title {};
        class Background: Background {};
        class Content: Content {
            h = QUOTE(POS_H(8.9));
            class controls {
                class TargetingLabel: EGVAR(common,RscLabel) {
                    text = CSTRING(ModuleFireMission_Targetting);
                    w = QUOTE(POS_W(26));
                };
                class TargetingBackground: RscText {
                    idc = -1;
                    x = 0;
                    y = QUOTE(POS_H(1));
                    w = QUOTE(POS_W(26));
                    h = QUOTE(POS_H(3.4));
                    colorBackground[] = {1, 1, 1, 0.1};
                };
                class ModeLabel: EGVAR(common,RscLabel) {
                    text = CSTRING(ModuleFireMission_Mode);
                    x = QUOTE(POS_W(1));
                    y = QUOTE(POS_H(1.1));
                    w = QUOTE(POS_W(8));
                    colorBackground[] = {0, 0, 0, 0.6};
                };
                class Mode: ctrlToolbox {
                    idc = IDC_FIREMISSION_MODE;
                    x = QUOTE(POS_W(9.1));
                    y = QUOTE(POS_H(1.1));
                    w = QUOTE(POS_W(15.9));
                    h = QUOTE(POS_H(1));
                    rows = 1;
                    columns = 2;
                    strings[] = {CSTRING(ModuleFireMission_MapGrid), CSTRING(ModuleFireMission_TargetModule)};
                };
                class TargetLabel: ModeLabel {
                    idc = IDC_FIREMISSION_TARGET_LABEL;
                    text = "$STR_3den_display3den_menubar_grid_text";
                    y = QUOTE(POS_H(2.2));
                };
                class TargetGrid: EGVAR(common,RscEdit) {
                    idc = IDC_FIREMISSION_TARGET_GRID;
                    x = QUOTE(POS_W(9.1));
                    y = QUOTE(POS_H(2.2) + pixelH);
                    colorBackground[] = {0, 0, 0, 0.3};
                };
                class TargetLogic: EGVAR(common,RscCombo) {
                    idc = IDC_FIREMISSION_TARGET_LOGIC;
                    x = QUOTE(POS_W(9.1));
                    y = QUOTE(POS_H(2.2));
                };
                class SpreadLabel: ModeLabel {
                    text = CSTRING(ModuleFireMission_Spread);
                    tooltip = CSTRING(ModuleFireMission_Spread_Tooltip);
                    y = QUOTE(POS_H(3.3));
                };
                class SpreadSlider: ctrlXSliderH {
                    idc = IDC_FIREMISSION_SPREAD_SLIDER;
                    x = QUOTE(POS_W(9.1));
                    y = QUOTE(POS_H(3.3));
                    w = QUOTE(POS_W(13.4));
                    h = QUOTE(POS_H(1));
                };
                class SpreadEdit: EGVAR(common,RscEdit) {
                    idc = IDC_FIREMISSION_SPREAD_EDIT;
                    x = QUOTE(POS_W(22.6));
                    y = QUOTE(POS_H(3.3));
                    w = QUOTE(POS_W(2.4));
                    colorBackground[] = {0, 0, 0, 0.3};
                };
                class FireParamsLabel: TargetingLabel {
                    text = CSTRING(ModuleFireMission_FireParameters);
                    y = QUOTE(POS_H(4.5));
                };
                class FireParamsBackground: TargetingBackground {
                    y = QUOTE(POS_H(5.5));
                };
                class UnitsLabel: ModeLabel {
                    text = CSTRING(ModuleFireMission_Units);
                    tooltip = CSTRING(ModuleFireMission_Units_Tooltip);
                    y = QUOTE(POS_H(5.6));
                };
                class Units: TargetLogic {
                    idc = IDC_FIREMISSION_UNITS;
                    y = QUOTE(POS_H(5.6));
                };
                class AmmoLabel: ModeLabel {
                    text = CSTRING(ModuleFireMission_Ammo);
                    y = QUOTE(POS_H(6.7));
                };
                class Ammo: Units {
                    idc = IDC_FIREMISSION_AMMO;
                    y = QUOTE(POS_H(6.7));
                };
                class RoundsLabel: ModeLabel {
                    text = CSTRING(ModuleFireMission_Rounds);
                    tooltip = CSTRING(ModuleFireMission_Rounds_Tooltip);
                    y = QUOTE(POS_H(7.8));
                };
                class Rounds: TargetGrid {
                    idc = IDC_FIREMISSION_ROUNDS;
                    y = QUOTE(POS_H(7.8) + pixelH);
                };
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};

class GVAR(RscGlobalHint): GVAR(RscDisplay) {
    function = QFUNC(gui_globalHint);
    class controls: controls {
        class Title: Title {};
        class Background: Background {};
        class Content: Content {
            h = QUOTE(POS_H(10));
            class controls {
                class Edit: RscEditMulti {
                    idc = IDC_GLOBALHINT_EDIT;
                    x = QUOTE(pixelW);
                    y = QUOTE(pixelH);
                    w = QUOTE(POS_W(13.2) - pixelW);
                    h = QUOTE(POS_H(10) - pixelH);
                    colorBackground[] = {0.25, 0.25, 0.25, 0.1};
                };
                class Container: EGVAR(common,RscControlsGroup) {
                    idc = -1;
                    x = QUOTE(POS_W(13.3));
                    y = 0;
                    w = QUOTE(POS_W(12.7));
                    h = QUOTE(POS_H(10));
                    class controls {
                        class Preview: RscStructuredText {
                            idc = IDC_GLOBALHINT_PREVIEW;
                            x = 0;
                            y = 0;
                            w = QUOTE(POS_W(12.2));
                            h = 1;
                            size = QUOTE(POS_H(0.9)); // Trial and error to get best representation of actual hint
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
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};

class GVAR(RscSetDate): GVAR(RscDisplay) {
    function = QFUNC(gui_setDate);
    class controls: controls {
        class Title: Title {};
        class Background: Background {};
        class Content: Content {
            h = QUOTE(POS_H(6.1));
            class controls {
                class DateLabel: EGVAR(common,RscLabel) {
                    text = "$STR_3DEN_Environment_Attribute_Date_displayName";
                    w = QUOTE(POS_W(26));
                };
                class DateBackground: EGVAR(common,RscBackground) {
                    x = 0;
                    y = QUOTE(POS_H(1));
                    w = QUOTE(POS_W(26));
                    h = QUOTE(POS_H(2));
                };
                class Year: EGVAR(common,RscCombo) {
                    idc = IDC_SETDATE_YEAR;
                    font = "RobotoCondensedLight";
                    x = QUOTE(POS_W(3.9));
                    y = QUOTE(POS_H(1.5));
                    w = QUOTE(POS_W(6));
                    sizeEx = QUOTE(POS_H(0.85));
                };
                class Month: Year {
                    idc = IDC_SETDATE_MONTH;
                    x = QUOTE(POS_W(10));
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
                    x = QUOTE(POS_W(16.1));
                };
                class TimeLabel: DateLabel {
                    text = "$STR_3DEN_Environment_Attribute_Daytime_displayName";
                    y = QUOTE(POS_H(3.1));
                };
                class TimeBackground: DateBackground {
                    y = QUOTE(POS_H(4.1));
                };
                class TimePreview: RscControlsGroupNoScrollbars {
                    idc = IDC_SETDATE_PREVIEW;
                    x = QUOTE(POS_W(5.05));
                    y = QUOTE(POS_H(4.6));
                    w = QUOTE(POS_W(9.8));
                    h = QUOTE(POS_H(1));
                    class controls {
                        class Night1: RscPicture {
                            idc = IDC_SETDATE_NIGHT1;
                            text = "\a3\3DEN\Data\Attributes\SliderTimeDay\night_ca.paa";
                            x = 0;
                            y = 0;
                            w = QUOTE(POS_W(0.5));
                            h = QUOTE(POS_H(1));
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
                            x = QUOTE(POS_W(4.4));
                            w = QUOTE(POS_W(1));
                        };
                    };
                };
                class Slider: ctrlXSliderH {
                    idc = IDC_SETDATE_SLIDER;
                    x = QUOTE(POS_W(3.9));
                    y = QUOTE(POS_H(4.6));
                    w = QUOTE(POS_W(12.1));
                    h = QUOTE(POS_H(1));
                    sliderRange[] = {0, 86399};
                    sliderPosition = 0;
                    lineSize = 3600;
                    pageSize = 3600;
                    border = "\a3\3DEN\Data\Attributes\SliderTimeDay\border_ca.paa";
                    thumb  = "\a3\3DEN\Data\Attributes\SliderTimeDay\thumb_ca.paa";
                };
                class Separator: RscText {
                    idc = -1;
                    style = ST_CENTER;
                    text = ":   :";
                    font = "EtelkaMonospacePro";
                    x = QUOTE(POS_W(16.1));
                    y = QUOTE(POS_H(4.6));
                    w = QUOTE(POS_W(6));
                    h = QUOTE(POS_H(1));
                    colorBackground[] = {0, 0, 0, 0.5};
                };
                class Hour: EGVAR(common,RscEdit) {
                    idc = IDC_SETDATE_HOUR;
                    style = ST_CENTER + ST_NO_RECT;
                    text = "00";
                    tooltip = "$STR_3DEN_Attributes_SliderTime_Hour_tooltip";
                    font = "EtelkaMonospacePro";
                    x = QUOTE(POS_W(16.1));
                    y = QUOTE(POS_H(4.6));
                    w = QUOTE(POS_W(2));
                    sizeEx = QUOTE(POS_H(0.9));
                    colorBackground[] = {0, 0, 0, 0};
                    maxChars = 2;
                };
                class Minute: Hour {
                    idc = IDC_SETDATE_MINUTE;
                    tooltip = "$STR_3DEN_Attributes_SliderTime_Minute_tooltip";
                    x = QUOTE(POS_W(18.1));
                };
                class Second: Hour {
                    idc = IDC_SETDATE_SECOND;
                    tooltip = "$STR_3DEN_Attributes_SliderTime_Second_tooltip";
                    x = QUOTE(POS_W(20.1));
                };
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};

class GVAR(RscSideRelations): GVAR(RscDisplay) {
    function = QFUNC(gui_sideRelations);
    class controls: controls {
        class Title: Title {};
        class Background: Background {};
        class Content: Content {
            h = QUOTE(POS_H(2.1));
            class controls {
                class RelationLabel: EGVAR(common,RscLabel) {
                    text = CSTRING(RelationToChange);
                };
                class RelationToggle: ctrlButtonPictureKeepAspect {
                    idc = IDC_SIDERELATIONS_TOGGLE;
                    text = ICON_FRIENDLY;
                    tooltip = CSTRING(FriendlyTo);
                    x = QUOTE(POS_W(17.55));
                    y = 0;
                    w = QUOTE(POS_W(1));
                    h = QUOTE(POS_H(1));
                    colorBackground[] = {0, 0, 0, 0.7};
                    tooltipColorBox[] = {1, 1, 1, 1};
                    tooltipColorShade[] = {0, 0, 0, 0.65};
                    offsetPressedX = 0;
                    offsetPressedY = 0;
                };
                class RelationSide_1: EGVAR(common,RscCombo) {
                    idc = IDC_SIDERELATIONS_SIDE_1;
                    x = QUOTE(POS_W(10.1));
                    y = 0;
                    w = QUOTE(POS_W(7.35));
                    h = QUOTE(POS_H(1));
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
                    x = QUOTE(POS_W(18.65));
                    class Items {}; // Special handling through script
                };
                class RadioLabel: EGVAR(common,RscLabel) {
                    text = CSTRING(PlayRadioMessage);
                    y = QUOTE(POS_H(1.1));
                };
                class Radio: GVAR(RscToolboxYesNo) {
                    idc = IDC_SIDERELATIONS_RADIO;
                    y = QUOTE(POS_H(1.1));
                };
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};

class GVAR(RscSpawnReinforcements): GVAR(RscDisplay) {
    function = QFUNC(gui_spawnReinforcements);
    class controls: controls {
        class Title: Title {};
        class Background: Background {};
        class Content: Content {
            h = QUOTE(POS_H(27.4));
            class controls {
                class SideLabel: EGVAR(common,RscLabel) {
                    text = "$STR_eval_typeside";
                };
                class Side: GVAR(RscSidesCombo) {
                    idc = IDC_SPAWNREINFORCEMENTS_SIDE;
                };
                class VehicleSelect: RscControlsGroupNoScrollbars {
                    idc = -1;
                    x = 0;
                    y = QUOTE(POS_H(1.1));
                    w = QUOTE(POS_W(26));
                    h = QUOTE(POS_H(4.4));
                    class controls {
                        class Title: EGVAR(common,RscLabel) {
                            text = CSTRING(VehicleSelect);
                            w = QUOTE(POS_W(26));
                        };
                        class Background: EGVAR(common,RscBackground) {
                            x = 0;
                            y = QUOTE(POS_H(1));
                            w = QUOTE(POS_W(26));
                            h = QUOTE(POS_H(3.4));
                        };
                        class FactionLabel: EGVAR(common,RscLabel) {
                            text = ECSTRING(common,Faction);
                            x = QUOTE(POS_W(3));
                            y = QUOTE(POS_H(1.1));
                            w = QUOTE(POS_W(8.9));
                            colorBackground[] = {0, 0, 0, 0.7};
                        };
                        class FactionCombo: EGVAR(common,RscCombo) {
                            idc = IDC_SPAWNREINFORCEMENTS_FACTION;
                            x = QUOTE(POS_W(12));
                            y = QUOTE(POS_H(1.1));
                            w = QUOTE(POS_W(11));
                        };
                        class CategoryLabel: FactionLabel {
                            text = CSTRING(Category);
                            y = QUOTE(POS_H(2.2));
                        };
                        class CategoryCombo: FactionCombo {
                            idc = IDC_SPAWNREINFORCEMENTS_CATEGORY;
                            y = QUOTE(POS_H(2.2));
                        };
                        class VehicleLabel: FactionLabel {
                            text = ECSTRING(common,Vehicle);
                            y = QUOTE(POS_H(3.3));
                        };
                        class VehicleCombo: FactionCombo {
                            idc = IDC_SPAWNREINFORCEMENTS_VEHICLE;
                            y = QUOTE(POS_H(3.3));
                        };
                    };
                };
                class GroupSelect: RscControlsGroupNoScrollbars {
                    idc = -1;
                    x = 0;
                    y = QUOTE(POS_H(5.5));
                    w = QUOTE(POS_W(26));
                    h = QUOTE(POS_H(14.2));
                    class controls {
                        class Title: EGVAR(common,RscLabel) {
                            text = CSTRING(GroupSelect);
                            w = QUOTE(POS_W(26));
                        };
                        class Background: EGVAR(common,RscBackground) {
                            x = 0;
                            y = QUOTE(POS_H(1));
                            w = QUOTE(POS_W(26));
                            h = QUOTE(POS_H(13.2));
                        };
                        class TreeMode: ctrlToolbox {
                            idc = IDC_SPAWNREINFORCEMENTS_TREE_MODE;
                            x = QUOTE(POS_W(0.1));
                            y = QUOTE(POS_H(1.1));
                            w = QUOTE(POS_W(13));
                            h = QUOTE(POS_H(1));
                            rows = 1;
                            columns = 2;
                            strings[] = {ECSTRING(common,Premade), "$STR_Radio_Custom"};
                            colorBackground[] = {0, 0, 0, 0.7};
                        };
                        class TreeGroups: ctrlTree {
                            idc = IDC_SPAWNREINFORCEMENTS_TREE_GROUPS;
                            x = QUOTE(POS_W(0.1));
                            y = QUOTE(POS_H(2.1) - pixelH);
                            w = QUOTE(POS_W(13));
                            h = QUOTE(POS_H(12));
                            sizeEx = QUOTE(3.96 * (1 / (getResolution select 3)) * pixelGrid * 0.5);
                            colorBackground[] = {0, 0, 0, 0.3};
                            colorBorder[] = {0, 0, 0, 0};
                            disableKeyboardSearch = 1;
                        };
                        class TreeUnits: TreeGroups {
                            idc = IDC_SPAWNREINFORCEMENTS_TREE_UNITS;
                        };
                        class Label: EGVAR(common,RscLabel) {
                            text = CSTRING(CurrentGroup);
                            x = QUOTE(POS_W(13.2));
                            y = QUOTE(POS_H(1.1));
                            w = QUOTE(POS_W(12.7));
                            colorBackground[] = {0, 0, 0, 0.7};
                        };
                        class UnitCount: Label {
                            idc = IDC_SPAWNREINFORCEMENTS_UNIT_COUNT;
                            style = ST_RIGHT;
                            text = "0";
                            w = QUOTE(POS_W(11.1));
                            colorBackground[] = {0, 0, 0, 0};
                        };
                        class UnitList: ctrlListbox {
                            idc = IDC_SPAWNREINFORCEMENTS_UNIT_LIST;
                            x = QUOTE(POS_W(13.2));
                            y = QUOTE(POS_H(2.1) - pixelH);
                            w = QUOTE(POS_W(12.7));
                            h = QUOTE(POS_H(12));
                            colorBackground[] = {0, 0, 0, 0.3};
                        };
                        class UnitIcon: RscPicture {
                            idc = -1;
                            text = QPATHTOF(ui\person_ca.paa);
                            x = QUOTE(POS_W(24));
                            y = QUOTE(POS_H(1.1));
                            w = QUOTE(POS_W(1));
                            h = QUOTE(POS_H(1));
                        };
                        class UnitClear: ctrlButtonPictureKeepAspect {
                            idc = IDC_SPAWNREINFORCEMENTS_UNIT_CLEAR;
                            text = "\a3\3den\data\cfg3den\history\deleteitems_ca.paa";
                            x = QUOTE(POS_W(24.9));
                            y = QUOTE(POS_H(1.1));
                            w = QUOTE(POS_W(1));
                            h = QUOTE(POS_H(1));
                            colorBackground[] = {0, 0, 0, 0};
                            offsetPressedX = 0;
                            offsetPressedY = 0;
                        };
                    };
                };
                class Properties: RscControlsGroupNoScrollbars {
                    idc = -1;
                    x = 0;
                    y = QUOTE(POS_H(19.7));
                    w = QUOTE(POS_W(26));
                    h = QUOTE(POS_H(7.7));
                    class controls {
                        class Title: EGVAR(common,RscLabel) {
                            text = "$STR_A3_RscDisplayLogin_Properties";
                            w = QUOTE(POS_W(26));
                        };
                        class Background: EGVAR(common,RscBackground) {
                            x = 0;
                            y = QUOTE(POS_H(1));
                            w = QUOTE(POS_W(26));
                            h = QUOTE(POS_H(6.7));
                        };
                        class VehicleLZLabel: EGVAR(common,RscLabel) {
                            text = CSTRING(VehicleLZ);
                            x = QUOTE(POS_W(3));
                            y = QUOTE(POS_H(1.1));
                            w = QUOTE(POS_W(8.9));
                            colorBackground[] = {0, 0, 0, 0.7};
                        };
                        class VehicleLZ: EGVAR(common,RscCombo) {
                            idc = IDC_SPAWNREINFORCEMENTS_VEHICLE_LZ;
                            x = QUOTE(POS_W(12));
                            y = QUOTE(POS_H(1.1));
                            w = QUOTE(POS_W(11));
                        };
                        class VehicleBehaviourLabel: VehicleLZLabel {
                            text = "Vehicle Behaviour";
                            y = QUOTE(POS_H(2.2));
                        };
                        class VehicleBehaviour: ctrlToolbox {
                            idc = IDC_SPAWNREINFORCEMENTS_VEHICLE_BEHAVIOUR;
                            x = QUOTE(POS_W(12));
                            y = QUOTE(POS_H(2.2));
                            w = QUOTE(POS_W(11));
                            h = QUOTE(POS_H(1));
                            rows = 1;
                            columns = 2;
                            strings[] = {CSTRING(StayAtLZ), CSTRING(RTBAndDespawn)};
                            colorBackground[] = {0, 0, 0, 0.7};
                        };
                        class InsertionLabel: VehicleLZLabel {
                            text = CSTRING(InsertionMethod);
                            y = QUOTE(POS_H(3.3));
                        };
                        class Insertion: VehicleLZ {
                            idc = IDC_SPAWNREINFORCEMENTS_VEHICLE_INSERTION;
                            y = QUOTE(POS_H(3.3));
                        };
                        class FlyHeightLabel: VehicleLZLabel {
                            text = CSTRING(ModuleFlyHeight);
                            y = QUOTE(POS_H(4.4));
                        };
                        class FlyHeight: EGVAR(common,RscEdit) {
                            idc = IDC_SPAWNREINFORCEMENTS_VEHICLE_HEIGHT;
                            x = QUOTE(POS_W(12));
                            y = QUOTE(POS_H(4.4));
                            w = QUOTE(POS_W(11));
                            h = QUOTE(POS_H(1));
                            colorBackground[] = {0, 0, 0, 0.3};
                        };
                        class UnitRPLabel: VehicleLZLabel {
                            text = CSTRING(UnitRP);
                            y = QUOTE(POS_H(5.5));
                        };
                        class UnitRP: VehicleLZ {
                            idc = IDC_SPAWNREINFORCEMENTS_UNIT_RP;
                            y = QUOTE(POS_H(5.5));
                        };
                        class UnitBehaviourLabel: VehicleLZLabel {
                            text = CSTRING(UnitBehaviour);
                            y = QUOTE(POS_H(6.6));
                        };
                        class UnitBehaviour: VehicleBehaviour {
                            idc = IDC_SPAWNREINFORCEMENTS_UNIT_BEHAVIOUR;
                            y = QUOTE(POS_H(6.6));
                            columns = 4;
                            strings[] = {
                                "$STR_Disp_Default",
                                ECSTRING(common,Relaxed),
                                ECSTRING(common,Cautious),
                                "$STR_Combat"
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

class GVAR(RscTracers): GVAR(RscDisplay) {
    function = QFUNC(gui_tracers);
    checkLogic = 1;
    class controls: controls {
        class Title: Title {};
        class Background: Background {};
        class Content: Content {
            h = QUOTE(POS_H(19.4));
            class controls {
                class WeaponLabel: EGVAR(common,RscLabel) {
                    text = ECSTRING(common,Weapon);
                    w = QUOTE(POS_W(26));
                };
                class WeaponBackground: EGVAR(common,RscBackground) {
                    x = 0;
                    y = QUOTE(POS_H(1));
                    w = QUOTE(POS_W(26));
                    h = QUOTE(POS_H(5));
                };
                class Weapon: ctrlListNBox {
                    idc = IDC_TRACERS_WEAPON;
                    x = 0;
                    y = QUOTE(POS_H(1));
                    w = QUOTE(POS_W(26));
                    h = QUOTE(POS_H(5));
                    rowHeight = QUOTE(POS_H(1.2));
                    columns[] = {0.05, 0.15, 0.9};
                    tooltipPerColumn = 0;
                };
                class MagazineLabel: WeaponLabel {
                    text = ECSTRING(common,Magazine);
                    y = QUOTE(POS_H(6.1));
                };
                class MagazineBackground: WeaponBackground {
                    y = QUOTE(POS_H(7.1));
                };
                class Magazine: Weapon {
                    idc = IDC_TRACERS_MAGAZINE;
                    y = QUOTE(POS_H(7.1));
                };
                class DelayLabel: WeaponLabel {
                    text = CSTRING(Tracers_BurstDelay);
                    tooltip = CSTRING(Tracers_BurstDelay_Tooltip);
                    y = QUOTE(POS_H(12.2));
                };
                class DelayBackground: WeaponBackground {
                    y = QUOTE(POS_H(13.2));
                    h = QUOTE(POS_H(2));
                };
                class DelayMinLabel: RscText {
                    style = ST_RIGHT;
                    text = "$STR_3DEN_Attributes_Timeout_TitleMin_text";
                    font = "RobotoCondensedLight";
                    x = QUOTE(POS_W(4));
                    y = QUOTE(POS_H(13.7));
                    w = QUOTE(POS_W(2));
                    h = QUOTE(POS_H(1));
                    shadow = 0;
                };
                class DelayMin: EGVAR(common,RscEdit) {
                    idc = IDC_TRACERS_DELAY_MIN;
                    font = "EtelkaMonospacePro";
                    x = QUOTE(POS_W(6));
                    y = QUOTE(POS_H(13.7));
                    w = QUOTE(POS_W(4));
                    h = QUOTE(POS_H(1));
                    sizeEx = QUOTE(POS_H(0.8));
                };
                class DelayMidLabel: DelayMinLabel {
                    text = "$STR_3DEN_Attributes_Timeout_TitleMid_text";
                    x = QUOTE(POS_W(10));
                };
                class DelayMid: DelayMin {
                    idc = IDC_TRACERS_DELAY_MID;
                    x = QUOTE(POS_W(12));
                };
                class DelayMaxLabel: DelayMinLabel {
                    text = "$STR_3DEN_Attributes_Timeout_TitleMax_text";
                    x = QUOTE(POS_W(16));
                };
                class DelayMax: DelayMin {
                    idc = IDC_TRACERS_DELAY_MAX;
                    x = QUOTE(POS_W(18));
                };
                class DispersionLabel: WeaponLabel {
                    text = CSTRING(Tracers_Dispersion);
                    tooltip = CSTRING(Tracers_Dispersion_Tooltip);
                    y = QUOTE(POS_H(15.3));
                };
                class Dispersion: ctrlToolbox {
                    idc = IDC_TRACERS_DISPERSION;
                    x = 0;
                    y = QUOTE(POS_H(16.3));
                    w = QUOTE(POS_W(26));
                    h = QUOTE(POS_H(1));
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
                class TargetLabel: WeaponLabel {
                    text = "$STR_A3_CfgVehicles_ModuleAI_F_Arguments_Target_0";
                    y = QUOTE(POS_H(17.4));
                };
                class Target: Dispersion {
                    idc = IDC_TRACERS_TARGET;
                    y = QUOTE(POS_H(18.4));
                    columns = 3;
                    strings[] = {
                        "$STR_A3_RscDisplayArsenal_ButtonRandom",
                        "$STR_3DEN_Camera_textSingular",
                        ECSTRING(common,Cursor)
                    };
                    tooltips[] = {
                        CSTRING(Tracers_Random_Tooltip),
                        CSTRING(Tracers_Camera_Tooltip),
                        CSTRING(Tracers_Cursor_Tooltip)
                    };
                };
                class Change: ctrlCheckbox {
                    idc = IDC_TRACERS_CHANGE;
                    x = QUOTE(POS_W(25));
                    y = QUOTE(POS_H(17.4));
                    w = QUOTE(POS_W(1));
                    h = QUOTE(POS_H(1));
                };
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};
