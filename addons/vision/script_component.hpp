#define COMPONENT vision
#define COMPONENT_BEAUTIFIED Vision
#include "\x\zen\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_VISION
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_VISION
    #define DEBUG_SETTINGS DEBUG_SETTINGS_VISION
#endif

#include "\x\zen\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\a3\ui_f\hpp\defineResincl.inc"

#define POS_X(N) ((N) * GUI_GRID_W + GUI_GRID_CENTER_X)
#define POS_Y(N) ((N) * GUI_GRID_H + GUI_GRID_CENTER_Y)
#define POS_W(N) ((N) * GUI_GRID_W)
#define POS_H(N) ((N) * GUI_GRID_H)

#define WIDTH_TOTAL (safeZoneW - POS_W(26))
#define WIDTH_SINGLE (WIDTH_TOTAL / 10)

#define IDC_MODE_0 840
#define IDC_MODE_1 841
#define IDC_MODE_2 842
#define IDC_MODE_3 843
#define IDC_MODE_4 844
#define IDC_MODE_5 845
#define IDC_MODE_6 846
#define IDC_MODE_7 847
#define IDC_MODE_8 848
#define IDC_MODE_9 849

#define IDCS_MODES [IDC_MODE_0, IDC_MODE_1, IDC_MODE_2, IDC_MODE_3, IDC_MODE_4, IDC_MODE_5, IDC_MODE_6, IDC_MODE_7, IDC_MODE_8, IDC_MODE_9]

#define MIN_BRIGHTNESS -5
#define MAX_BRIGHTNESS 5
#define MIN_CONTRAST 0.4
#define MAX_CONTRAST 1.6
