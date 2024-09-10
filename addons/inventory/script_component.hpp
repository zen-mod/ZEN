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

#define IDC_CATEGORY   1500
#define IDC_SORTING    1501
#define IDC_LIST       1503
#define IDC_BTN_REMOVE 1504
#define IDC_BTN_ADD    1505
#define IDC_BTN_SEARCH 1506
#define IDC_SEARCH_BAR 1507
#define IDC_LOAD_BAR   1508
#define IDC_BTN_WEAPON 1509
#define IDC_BTN_RESET  1510
#define IDC_BTN_CLEAR  1511

#define IDC_WEAPON_GROUP    1512
#define IDC_WEAPON_TITLE    1513
#define IDC_WEAPON_PICTURE  1514
#define IDC_WEAPON_CATEGORY 1515
#define IDC_WEAPON_CLOSE    1516

#define ALPHA_NONE 0.5
#define ALPHA_SOME 1

// Master Items List
#define ITEMS_PRIMARY    0
#define ITEMS_SECONDARY  1
#define ITEMS_HANDGUN    2
#define ITEMS_OPTIC      3
#define ITEMS_SIDE       4
#define ITEMS_MUZZLE     5
#define ITEMS_BIPOD      6
#define ITEMS_MAGAZINES  7
#define ITEMS_HEADGEAR   8
#define ITEMS_UNIFORMS   9
#define ITEMS_VESTS      10
#define ITEMS_BACKPACKS  11
#define ITEMS_GOGGLES    12
#define ITEMS_NVGS       13
#define ITEMS_BINOCULARS 14
#define ITEMS_MAP        15
#define ITEMS_COMPASS    16
#define ITEMS_RADIO      17
#define ITEMS_WATCH      18
#define ITEMS_COMMS      19
#define ITEMS_THROW      20
#define ITEMS_PUT        21
#define ITEMS_MISC       22

// Object Cargo Array
#define CARGO_ITEMS     0
#define CARGO_WEAPONS   1
#define CARGO_MAGAZINES 2
#define CARGO_BACKPACKS 3

#define EMPTY_CARGO [[[], []], [[], []], [[], []], [[], []]]
