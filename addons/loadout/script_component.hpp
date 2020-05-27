#define COMPONENT loadout
#define COMPONENT_BEAUTIFIED Loadout
#include "\x\zen\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_LOADOUT
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_LOADOUT
    #define DEBUG_SETTINGS DEBUG_SETTINGS_LOADOUT
#endif

#include "\x\zen\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\x\zen\addons\common\defineResinclDesign.inc"

#define POS_X(N) ((N) * GUI_GRID_W + GUI_GRID_CENTER_X)
#define POS_Y(N) ((N) * GUI_GRID_H + GUI_GRID_CENTER_Y)
#define POS_W(N) ((N) * GUI_GRID_W)
#define POS_H(N) ((N) * GUI_GRID_H)

#define IDC_WEAPON     1610
#define IDC_LIST       1620
#define IDC_BTN_REMOVE 1630
#define IDC_BTN_ADD    1640
#define IDC_BTN_SEARCH 1650
#define IDC_SEARCH_BAR 1660
#define IDC_BTN_CLEAR  1670

// Prevent certain weapons from being handled
#define BLACKLIST_WEAPONS ["TruckHorn", "SmokeLauncher", "Laserdesignator_mounted", "Laserdesignator_pilotCamera", "CMFlareLauncher", "CMFlareLauncher_Singles", "ProbingWeapon_01_F", "ProbingWeapon_02_F", "ProbingLaser_01_F"]
