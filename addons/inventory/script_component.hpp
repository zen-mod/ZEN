#define COMPONENT inventory
#define COMPONENT_BEAUTIFIED Inventory
#include "\x\zen\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_INVENTORY
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_INVENTORY
    #define DEBUG_SETTINGS DEBUG_SETTINGS_INVENTORY
#endif

#include "\x\zen\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\x\zen\addons\common\defineResinclDesign.inc"

#define POS_X(N) ((N) * GUI_GRID_W + GUI_GRID_CENTER_X)
#define POS_Y(N) ((N) * GUI_GRID_H + GUI_GRID_CENTER_Y)
#define POS_W(N) ((N) * GUI_GRID_W)
#define POS_H(N) ((N) * GUI_GRID_H)

#define IDC_CATEGORY   1510
#define IDC_LIST       1520
#define IDC_BTN_REMOVE 1530
#define IDC_BTN_ADD    1540
#define IDC_BTN_SEARCH 1550
#define IDC_SEARCH_BAR 1560
#define IDC_LOAD       1570
#define IDC_BTN_CLEAR  1580

#define EMPTY_CARGO [[[], []], [[], []], [[], []], [[], []]]
