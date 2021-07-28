#define COMPONENT modules
#define COMPONENT_BEAUTIFIED Modules
#include "\x\zen\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_MODULES
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_MODULES
    #define DEBUG_SETTINGS DEBUG_SETTINGS_MODULES
#endif

#include "\x\zen\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\x\zen\addons\common\defineResinclDesign.inc"

#define POS_X(N) ((N) * GUI_GRID_W + GUI_GRID_CENTER_X)
#define POS_Y(N) ((N) * GUI_GRID_H + GUI_GRID_CENTER_Y)
#define POS_W(N) ((N) * GUI_GRID_W)
#define POS_H(N) ((N) * GUI_GRID_H)

#define IDC_SIDERELATIONS 60200
#define IDC_SIDERELATIONS_TOGGLE 60201
#define IDC_SIDERELATIONS_SIDE_1 60202
#define IDC_SIDERELATIONS_SIDE_2 60203
#define IDC_SIDERELATIONS_RADIO 60204

#define IDC_GLOBALHINT 60600
#define IDC_GLOBALHINT_EDIT 60601
#define IDC_GLOBALHINT_PREVIEW 60602

#define IDC_DAMAGEBUILDINGS 61300
#define IDC_DAMAGEBUILDINGS_MODE 61301
#define IDC_DAMAGEBUILDINGS_RADIUS 61302
#define IDC_DAMAGEBUILDINGS_UNDAMAGED 61303
#define IDC_DAMAGEBUILDINGS_DAMAGED_1 61304
#define IDC_DAMAGEBUILDINGS_DAMAGED_2 61305
#define IDC_DAMAGEBUILDINGS_DAMAGED_3 61306
#define IDC_DAMAGEBUILDINGS_DESTROYED 61307
#define IDC_DAMAGEBUILDINGS_EFFECTS 61308

#define IDC_ATTACHEFFECT 61500
#define IDC_ATTACHEFFECT_TARGET 61501
#define IDC_ATTACHEFFECT_EFFECT 61502

#define IDC_SETDATE 61600
#define IDC_SETDATE_YEAR 61601
#define IDC_SETDATE_MONTH 61602
#define IDC_SETDATE_DAY 61603
#define IDC_SETDATE_PREVIEW 61604
#define IDC_SETDATE_NIGHT1 61605
#define IDC_SETDATE_NIGHT2 61606
#define IDC_SETDATE_DAYTIME 61607
#define IDC_SETDATE_SUNRISE 61608
#define IDC_SETDATE_SUNSET 61609
#define IDC_SETDATE_SUN 61610
#define IDC_SETDATE_SLIDER 61611
#define IDC_SETDATE_HOUR 61612
#define IDC_SETDATE_MINUTE 61613
#define IDC_SETDATE_SECOND 61614

#define IDC_AMBIENTFLYBY 61700
#define IDC_AMBIENTFLYBY_SIDE 61701
#define IDC_AMBIENTFLYBY_FACTION 61702
#define IDC_AMBIENTFLYBY_DIRECTION 61703
#define IDC_AMBIENTFLYBY_AIRCRAFT 61704
#define IDC_AMBIENTFLYBY_HEIGHT_MODE 61705
#define IDC_AMBIENTFLYBY_HEIGHT_SLIDER 61706
#define IDC_AMBIENTFLYBY_HEIGHT_EDIT 61707
#define IDC_AMBIENTFLYBY_DISTANCE_SLIDER 61708
#define IDC_AMBIENTFLYBY_DISTANCE_EDIT 61709
#define IDC_AMBIENTFLYBY_SPEED 61710
#define IDC_AMBIENTFLYBY_AMOUNT 61711

#define IDC_CAS 61800
#define IDC_CAS_LIST 61801

#define IDC_EDITABLEOBJECTS 61900
#define IDC_EDITABLEOBJECTS_MODE 61901
#define IDC_EDITABLEOBJECTS_CURATORS 61902
#define IDC_EDITABLEOBJECTS_RANGE_MODE 61903
#define IDC_EDITABLEOBJECTS_RANGE_SLIDER 61904
#define IDC_EDITABLEOBJECTS_RANGE_EDIT 61905
#define IDC_EDITABLEOBJECTS_FILTER_ALL 61906
#define IDC_EDITABLEOBJECTS_FILTER_UNITS 61907
#define IDC_EDITABLEOBJECTS_FILTER_VEHICLES 61908
#define IDC_EDITABLEOBJECTS_FILTER_STATIC 61909

#define IDC_EXECUTECODE 62100
#define IDC_EXECUTECODE_HISTORY 62101
#define IDC_EXECUTECODE_EDIT 62102
#define IDC_EXECUTECODE_MODE 62103

#define IDC_FIREMISSION 62000
#define IDC_FIREMISSION_MODE 62001
#define IDC_FIREMISSION_TARGET_LABEL 62002
#define IDC_FIREMISSION_TARGET_GRID 62003
#define IDC_FIREMISSION_TARGET_LOGIC 62004
#define IDC_FIREMISSION_SPREAD_SLIDER 62005
#define IDC_FIREMISSION_SPREAD_EDIT 62006
#define IDC_FIREMISSION_UNITS 62007
#define IDC_FIREMISSION_AMMO 62008
#define IDC_FIREMISSION_ROUNDS 62009

#define IDC_SPAWNREINFORCEMENTS 62300
#define IDC_SPAWNREINFORCEMENTS_SIDE 62301
#define IDC_SPAWNREINFORCEMENTS_FACTION 62302
#define IDC_SPAWNREINFORCEMENTS_CATEGORY 62303
#define IDC_SPAWNREINFORCEMENTS_VEHICLE 62304
#define IDC_SPAWNREINFORCEMENTS_TREE_MODE 62305
#define IDC_SPAWNREINFORCEMENTS_TREE_GROUPS 62306
#define IDC_SPAWNREINFORCEMENTS_TREE_UNITS 62307
#define IDC_SPAWNREINFORCEMENTS_UNIT_LIST 62308
#define IDC_SPAWNREINFORCEMENTS_UNIT_COUNT 62309
#define IDC_SPAWNREINFORCEMENTS_UNIT_CLEAR 62310
#define IDC_SPAWNREINFORCEMENTS_VEHICLE_LZ 62311
#define IDC_SPAWNREINFORCEMENTS_VEHICLE_BEHAVIOUR 62312
#define IDC_SPAWNREINFORCEMENTS_VEHICLE_INSERTION 62313
#define IDC_SPAWNREINFORCEMENTS_VEHICLE_HEIGHT 62314
#define IDC_SPAWNREINFORCEMENTS_UNIT_RP 62315
#define IDC_SPAWNREINFORCEMENTS_UNIT_BEHAVIOUR 62316

#define IDC_TRACERS_WEAPON 62400
#define IDC_TRACERS_MAGAZINE 62401
#define IDC_TRACERS_DELAY_MIN 62402
#define IDC_TRACERS_DELAY_MID 62403
#define IDC_TRACERS_DELAY_MAX 62404
#define IDC_TRACERS_DISPERSION 62405
#define IDC_TRACERS_TARGET 62406
#define IDC_TRACERS_CHANGE 62407

#define ICON_HOSTILE "\a3\ui_f\data\igui\cfg\simpletasks\types\attack_ca.paa"
#define ICON_FRIENDLY "\a3\ui_f\data\igui\cfg\simpletasks\types\help_ca.paa"

#define ICON_GROUP "\a3\ui_f_curator\data\displays\rscdisplaycurator\modegroups_ca.paa"

#define ICON_LOCATION "\a3\3den\data\displays\display3den\panelleft\locationlist_ca.paa"

#define ICON_BLUFOR QPATHTOEF(common,ui\icon_blufor_ca.paa)
#define ICON_OPFOR QPATHTOEF(common,ui\icon_opfor_ca.paa)
#define ICON_INDEPENDENT QPATHTOEF(common,ui\icon_independent_ca.paa)
#define ICON_CIVILIAN QPATHTOEF(common,ui\icon_civilian_ca.paa)

#define CHECKBOX_TEXTURES(uncheckedTexture,checkedTexture) \
    textureChecked           = checkedTexture; \
    textureHoverChecked      = checkedTexture; \
    textureFocusedChecked    = checkedTexture; \
    texturePressedChecked    = checkedTexture; \
    textureDisabledChecked   = checkedTexture; \
    textureUnchecked         = uncheckedTexture; \
    textureHoverUnchecked    = uncheckedTexture; \
    textureFocusedUnchecked  = uncheckedTexture; \
    texturePressedUnchecked  = uncheckedTexture; \
    textureDisabledUnchecked = uncheckedTexture

#define ICON_UNDAMAGED_UNCHECKED "\a3\modules_f\data\editterrainobject\textureunchecked_undamaged_ca.paa"
#define ICON_UNDAMAGED_CHECKED   "\a3\modules_f\data\editterrainobject\texturechecked_undamaged_ca.paa"
#define ICON_DAMAGED_1_UNCHECKED "\a3\modules_f\data\editterrainobject\textureunchecked_damaged1_ca.paa"
#define ICON_DAMAGED_1_CHECKED   "\a3\modules_f\data\editterrainobject\texturechecked_damaged1_ca.paa"
#define ICON_DAMAGED_2_UNCHECKED "\a3\modules_f\data\editterrainobject\textureunchecked_damaged2_ca.paa"
#define ICON_DAMAGED_2_CHECKED   "\a3\modules_f\data\editterrainobject\texturechecked_damaged2_ca.paa"
#define ICON_DAMAGED_3_UNCHECKED "\a3\modules_f\data\editterrainobject\textureunchecked_damaged12_ca.paa"
#define ICON_DAMAGED_3_CHECKED   "\a3\modules_f\data\editterrainobject\texturechecked_damaged12_ca.paa"
#define ICON_DESTROYED_UNCHECKED "\a3\modules_f\data\editterrainobject\textureunchecked_destroyed_ca.paa"
#define ICON_DESTROYED_CHECKED   "\a3\modules_f\data\editterrainobject\texturechecked_destroyed_ca.paa"

#define CAS_WEAPON_TYPES [["machinegun"], ["missilelauncher"], ["machinegun", "missilelauncher"], ["bomblauncher"]]

#define MS_TO_KMH(value) ((value) * 3.6)
#define KMH_TO_MS(value) ((value) / 3.6)
