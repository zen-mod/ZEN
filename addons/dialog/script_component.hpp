#define COMPONENT dialog
#define COMPONENT_BEAUTIFIED Dialog
#include "\x\zen\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_DIALOG
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_DIALOG
    #define DEBUG_SETTINGS DEBUG_SETTINGS_DIALOG
#endif

#include "\x\zen\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\x\zen\addons\common\defineResinclDesign.inc"

#define POS_X(N) ((N) * GUI_GRID_W + GUI_GRID_CENTER_X)
#define POS_Y(N) ((N) * GUI_GRID_H + GUI_GRID_CENTER_Y)
#define POS_W(N) ((N) * GUI_GRID_W)
#define POS_H(N) ((N) * GUI_GRID_H)

#define MIN_HEIGHT POS_H(1)
#define MAX_HEIGHT POS_H(20)

#define VERTICAL_SPACING POS_H(0.1)
#define CONTENT_SPACING  POS_H(0.5)

// Macros to calculate dialog control positions based on content height
#define POS_CONTENT_Y(HEIGHT)    (0.5 - HEIGHT / 2)
#define POS_BACKGROUND_Y(HEIGHT) (POS_CONTENT_Y(HEIGHT) - CONTENT_SPACING)
#define POS_BACKGROUND_H(HEIGHT) (HEIGHT + 2 * CONTENT_SPACING)
#define POS_TITLE_Y(HEIGHT)      (POS_BACKGROUND_Y(HEIGHT) - VERTICAL_SPACING - POS_H(1))
#define POS_BUTTON_Y(HEIGHT)     (0.5 + HEIGHT / 2 + CONTENT_SPACING + VERTICAL_SPACING)

#include "script_idc.hpp"
