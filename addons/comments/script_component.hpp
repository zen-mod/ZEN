#define COMPONENT comments
#define COMPONENT_BEAUTIFIED Comments
#include "\x\zen\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_COMMENTS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_COMMENTS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_COMMENTS
#endif

#include "\x\zen\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\x\zen\addons\common\defineResinclDesign.inc"

#define POS_X(N) ((N) * GUI_GRID_W + GUI_GRID_CENTER_X)
#define POS_Y(N) ((N) * GUI_GRID_H + GUI_GRID_CENTER_Y)
#define POS_W(N) ((N) * GUI_GRID_W)
#define POS_H(N) ((N) * GUI_GRID_H)

// Ignore comments that include following string in the description/tooltip
#define IGNORE_3DEN_COMMENT_STRING "#ZEN_IGNORE#"

#define COMMENT_ICON "a3\3den\Data\Cfg3DEN\Comment\texture_ca.paa"
#define ICON_SCALE 1
#define MAP_ICON_SCALE 1.2
#define MAP_TEXT_SCALE 24

#define TEXT_OFFSET_Y -0.076
#define MIN_TEXT_OFFSET_SCALE 0.35

#define SCALE_DISTANCE_START 300
#define MAX_RENDER_DISTANCE 750

#define GROUND_ICON_CONNECTION_HEIGHT 0.5

#define STR_DISPLAY_NAME "$STR_3DEN_Comment_textPlural"
#define STR_CREATE_COMMENT "$STR_3den_display3den_entitymenu_createcomment_text"

#define COMMENT_TYPE_3DEN "3den"
#define COMMENT_TYPE_ZEUS "zeus"

#define DEFAULT_COLOR [1, 1, 0, 0.7]
