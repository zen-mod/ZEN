#define COMPONENT cover_map
#define COMPONENT_BEAUTIFIED Cover Map
#include "\x\zen\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_COVER_MAP
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_COVER_MAP
    #define DEBUG_SETTINGS DEBUG_SETTINGS_COVER_MAP
#endif

#include "\x\zen\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\x\zen\addons\common\defineResinclDesign.inc"

#define POS_X(N) ((N) * GUI_GRID_W + GUI_GRID_CENTER_X)
#define POS_Y(N) ((N) * GUI_GRID_H + GUI_GRID_CENTER_Y)
#define POS_W(N) ((N) * GUI_GRID_W)
#define POS_H(N) ((N) * GUI_GRID_H)

#define IDC_CM_MAP 100
#define IDC_CM_DELETE 200
#define IDC_CM_ROTATION_SLIDER 300
#define IDC_CM_ROTATION_EDIT 400
