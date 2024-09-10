#define COMPONENT editor_previews
#define COMPONENT_BEAUTIFIED Editor Previews
#include "\x\zen\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_EDITOR_PREVIEWS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_EDITOR_PREVIEWS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_EDITOR_PREVIEWS
#endif

#include "\x\zen\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\x\zen\addons\common\defineResinclDesign.inc"

#define POS_X(N) ((N) * GUI_GRID_W + GUI_GRID_CENTER_X)
#define POS_Y(N) ((N) * GUI_GRID_H + GUI_GRID_CENTER_Y)
#define POS_W(N) ((N) * GUI_GRID_W)
#define POS_H(N) ((N) * GUI_GRID_H)

#define IDC_PREVIEW_GROUP 98470
#define IDC_PREVIEW_IMAGE 98480

// Height of the image - other control positions are based on this value and the aspect ratio of the image
#define IMAGE_HEIGHT 5.2

// Size of the border around the image on one side
#define BORDER_SIZE 0.2
