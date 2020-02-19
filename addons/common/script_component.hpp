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

#define ICON_TARGET "\a3\ui_f\data\IGUI\Cfg\Cursors\select_target_ca.paa"

#define VLS_BASE_CLASS "B_Ship_MRLS_01_base_F"

#define ICON_BLUFOR      QPATHTOF(ui\icon_blufor_ca.paa)
#define ICON_OPFOR       QPATHTOF(ui\icon_opfor_ca.paa)
#define ICON_INDEPENDENT QPATHTOF(ui\icon_independent_ca.paa)
#define ICON_CIVILIAN    QPATHTOF(ui\icon_civilian_ca.paa)

// Prevent certain magazines from being handled by ammo functions
#define BLACKLIST_MAGAZINES ["Laserbatteries"]
