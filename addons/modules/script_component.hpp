#define COMPONENT modules
#define COMPONENT_BEAUTIFIED Modules
#include "\x\zen\addons\main\script_mod.hpp"

#define DEBUG_MODE_FULL
#define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_MODULES
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_MODULES
    #define DEBUG_SETTINGS DEBUG_SETTINGS_MODULES
#endif

#include "\x\zen\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\a3\ui_f_curator\ui\defineResinclDesign.inc"

#define POS_X(N) ((N) * GUI_GRID_W + GUI_GRID_CENTER_X)
#define POS_Y(N) ((N) * GUI_GRID_H + GUI_GRID_CENTER_Y)
#define POS_W(N) ((N) * GUI_GRID_W)
#define POS_H(N) ((N) * GUI_GRID_H)

#define IDC_BLUFOR 3451
#define IDC_OPFOR 3450
#define IDC_INDEPENDENT 3452
#define IDC_CIVILIAN 3453

#define IDC_SLIDER 1200
#define IDC_EDIT 1300

#define IDC_ATTRIBUTERADIUS 60000
#define IDC_ATTRIBUTERADIUS_VALUE 60001

#define IDC_SIDERELATIONS 60200
#define IDC_SIDERELATIONS_TOGGLE 60201
#define IDC_SIDERELATIONS_SIDE_1 60202
#define IDC_SIDERELATIONS_SIDE_2 60203
#define IDC_SIDERELATIONS_RADIO 60204

#define IDC_TELEPORTPLAYERS 60300
#define IDC_TELEPORTPLAYERS_BUTTON_SIDES 60301
#define IDC_TELEPORTPLAYERS_BUTTON_GROUPS 60302
#define IDC_TELEPORTPLAYERS_BUTTON_PLAYERS 60303
#define IDC_TELEPORTPLAYERS_TAB_SIDES 60311
#define IDC_TELEPORTPLAYERS_TAB_GROUPS 60312
#define IDC_TELEPORTPLAYERS_TAB_PLAYERS 60313
#define IDC_TELEPORTPLAYERS_BLUFOR 60321
#define IDC_TELEPORTPLAYERS_OPFOR 60320
#define IDC_TELEPORTPLAYERS_INDEPENDENT 60322
#define IDC_TELEPORTPLAYERS_CIVILIAN 60323
#define IDC_TELEPORTPLAYERS_GROUPS 60330
#define IDC_TELEPORTPLAYERS_GROUPS_SEARCH 60331
#define IDC_TELEPORTPLAYERS_GROUPS_BUTTON 60332
#define IDC_TELEPORTPLAYERS_PLAYERS 60340
#define IDC_TELEPORTPLAYERS_PLAYERS_SEARCH 60341
#define IDC_TELEPORTPLAYERS_PLAYERS_BUTTON 60342

#define IDC_CREATEMINEFIELD 60400
#define IDC_CREATEMINEFIELD_AREA_X 60401
#define IDC_CREATEMINEFIELD_AREA_Y 60402
#define IDC_CREATEMINEFIELD_TYPE 60403
#define IDC_CREATEMINEFIELD_DENSITY 60404

#define IDC_CHATTER 60500
#define IDC_CHATTER_MESSAGE 60501
#define IDC_CHATTER_LABEL 60502
#define IDC_CHATTER_SIDES 60503
#define IDC_CHATTER_CHANNELS 60504

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

#define ICON_CHECKED "\a3\ui_f\data\gui\rsccommon\rsccheckbox\checkbox_checked_ca.paa"
#define ICON_UNCHECKED "\a3\ui_f\data\gui\rsccommon\rsccheckbox\checkbox_unchecked_ca.paa"

#define ICON_HOSTILE "\a3\ui_f\data\igui\cfg\simpletasks\types\attack_ca.paa"
#define ICON_FRIENDLY "\a3\ui_f\data\igui\cfg\simpletasks\types\help_ca.paa"

#define ICON_GROUP "\a3\ui_f_curator\data\displays\rscdisplaycurator\modegroups_ca.paa"

#define ICON_BLUFOR QPATHTOEF(common,UI\icon_blufor_ca.paa)
#define ICON_OPFOR QPATHTOEF(common,UI\icon_opfor_ca.paa)
#define ICON_INDEPENDENT QPATHTOEF(common,UI\icon_independent_ca.paa)
#define ICON_CIVILIAN QPATHTOEF(common,UI\icon_civilian_ca.paa)

#define GET_SIDE_ICON(unit) (unit call EFUNC(common,getSideIcon))

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
