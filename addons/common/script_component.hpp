#define COMPONENT common
#define COMPONENT_BEAUTIFIED Common
#include "\x\zen\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_COMMON
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_COMMON
    #define DEBUG_SETTINGS DEBUG_SETTINGS_COMMON
#endif

#include "\x\zen\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\x\zen\addons\common\defineResinclDesign.inc"

#define POS_X(N) ((N) * GUI_GRID_W + GUI_GRID_CENTER_X)
#define POS_Y(N) ((N) * GUI_GRID_H + GUI_GRID_CENTER_Y)
#define POS_W(N) ((N) * GUI_GRID_W)
#define POS_H(N) ((N) * GUI_GRID_H)

#define IDC_MESSAGE_TITLE      100
#define IDC_MESSAGE_BACKGROUND 110
#define IDC_MESSAGE_PICTURE    120
#define IDC_MESSAGE_TEXT       130

#define IDC_EXPORT_TITLE 200
#define IDC_EXPORT_GROUP 210
#define IDC_EXPORT_EDIT  220
#define IDC_EXPORT_CLOSE 230
#define IDC_EXPORT_COPY  240

#define IDC_SIDES_BLUFOR      300
#define IDC_SIDES_OPFOR       310
#define IDC_SIDES_INDEPENDENT 320
#define IDC_SIDES_CIVILIAN    330

#define IDC_OWNERS_BTN_SIDES          400
#define IDC_OWNERS_BTN_GROUPS         401
#define IDC_OWNERS_BTN_PLAYERS        402
#define IDC_OWNERS_TAB_SIDES          410
#define IDC_OWNERS_TAB_GROUPS         411
#define IDC_OWNERS_TAB_PLAYERS        412
#define IDC_OWNERS_GROUPS_LIST        420
#define IDC_OWNERS_GROUPS_SEARCH_BAR  421
#define IDC_OWNERS_GROUPS_SEARCH_BTN  422
#define IDC_OWNERS_GROUPS_UNCHECK     423
#define IDC_OWNERS_GROUPS_CHECK       424
#define IDC_OWNERS_PLAYERS_LIST       430
#define IDC_OWNERS_PLAYERS_SEARCH_BAR 431
#define IDC_OWNERS_PLAYERS_SEARCH_BTN 432
#define IDC_OWNERS_PLAYERS_UNCHECK    433
#define IDC_OWNERS_PLAYERS_CHECK      434

#define IDCS_OWNERS_BTNS [IDC_OWNERS_BTN_SIDES, IDC_OWNERS_BTN_GROUPS, IDC_OWNERS_BTN_PLAYERS]
#define IDCS_OWNERS_TABS [IDC_OWNERS_TAB_SIDES, IDC_OWNERS_TAB_GROUPS, IDC_OWNERS_TAB_PLAYERS]

#define IDCS_UNIT_TREES [ \
    IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EAST, \
    IDC_RSCDISPLAYCURATOR_CREATE_UNITS_WEST, \
    IDC_RSCDISPLAYCURATOR_CREATE_UNITS_GUER, \
    IDC_RSCDISPLAYCURATOR_CREATE_UNITS_CIV, \
    IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EMPTY \
]

#define IDCS_GROUP_TREES [ \
    IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_EAST, \
    IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_WEST, \
    IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_GUER, \
    IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_CIV, \
    IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_EMPTY \
]

#define ICON_TARGET "\a3\ui_f\data\igui\cfg\cursors\select_target_ca.paa"
#define ICON_CHECKED "\a3\ui_f\data\gui\rsccommon\rsccheckbox\checkbox_checked_ca.paa"
#define ICON_UNCHECKED "\a3\ui_f\data\gui\rsccommon\rsccheckbox\checkbox_unchecked_ca.paa"

#define VLS_BASE_CLASS "B_Ship_MRLS_01_base_F"

#define ICON_BLUFOR      QPATHTOF(ui\icon_blufor_ca.paa)
#define ICON_OPFOR       QPATHTOF(ui\icon_opfor_ca.paa)
#define ICON_INDEPENDENT QPATHTOF(ui\icon_independent_ca.paa)
#define ICON_CIVILIAN    QPATHTOF(ui\icon_civilian_ca.paa)

// Prevent certain magazines from being handled by ammo functions
#define BLACKLIST_MAGAZINES ["Laserbatteries"]

// Prevent certain source animations from being displayed in the garage
#define WHITELIST_ANIMATION_SOURCES ["user", "door", "doors", "proxy"]
#define BLACKLIST_ANIMATION_INNAMES ["proxy", "doors", "offset", "autoloader", "shtora", "elev", "obs", "offset", "recoil", "sight", "hook", "brakes", "eject", "vtol", "pip", "switch", "fuel", "burner" "rwr", "filter"]
#define BLACKLIST_ANIMATION_ATTRIBUTES ["weapon", "wheel", "isComponent"]
