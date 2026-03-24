#define COMPONENT markers_tree
#define COMPONENT_BEAUTIFIED Markers Tree
#include "\x\zen\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_MARKERS_TREE
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_MARKERS_TREE
    #define DEBUG_SETTINGS DEBUG_SETTINGS_MARKERS_TREE
#endif

#include "\x\zen\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\x\zen\addons\common\defineResinclDesign.inc"
#include "\x\zen\addons\editor\script_idc.hpp"

#define POS_X(N) ((N) * GUI_GRID_W + GUI_GRID_CENTER_X)
#define POS_Y(N) ((N) * GUI_GRID_H + GUI_GRID_CENTER_Y)
#define POS_W(N) ((N) * GUI_GRID_W)
#define POS_H(N) ((N) * GUI_GRID_H)

#define IDC_MARKERS_MODE_ICONS 92800
#define IDC_MARKERS_MODE_AREAS 92810
#define IDC_MARKERS_TREE_ICONS 92820
#define IDC_MARKERS_TREE_AREAS 92830
