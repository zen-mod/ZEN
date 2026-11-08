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
#include "\a3\ui_f_curator\ui\defineResinclDesign.inc"

#define POS_X(N) ((N) * GUI_GRID_W + GUI_GRID_CENTER_X)
#define POS_Y(N) ((N) * GUI_GRID_H + GUI_GRID_CENTER_Y)
#define POS_W(N) ((N) * GUI_GRID_W)
#define POS_H(N) ((N) * GUI_GRID_H)

#define IDC_CONTAINER    98600
#define IDC_MOUSE        98610

#define IDC_ICON_TITLE   98700
#define IDC_ICON_IMAGE   98710
#define IDC_ICON_CREATOR 98720

#define COMMENT_ICON "\a3\3den\Data\Cfg3DEN\Comment\texture_ca.paa"

// The size of comment icons where the title is drawn above the image and the creator below it
// Texts wider than the max width are cut short with an ellipsis
#define ICON_SIZE 1
#define ICON_TEXT_HEIGHT 0.8
#define ICON_TEXT_MAX_WIDTH 20

// Scale of the icons relative to the sizes above (drawn smaller on the map)
#define ICON_SCALE 1
#define ICON_SCALE_MAP 0.8

// Comment colors are set as RGB with the alpha based on the hover state
#define ICON_ALPHA 0.7
#define ICON_ALPHA_HOVERED 1

// Comments further away from the camera than this are not rendered in 3D
#define MAX_RENDER_DISTANCE 750

// Lines to the surface are only drawn for comments with a height greater than this
#define MIN_LINE_HEIGHT 0.5

// Prefixes used by comment IDs based on where the comment was created
#define COMMENT_TYPE_3DEN "3den"
#define COMMENT_TYPE_ZEUS "zeus"

#define COMMENT_TYPE_PREFIX_LENGTH 4

// Named indexes for items of a comment's data array
#define DATA_INDEX_POSITION      0
#define DATA_INDEX_TITLE         1
#define DATA_INDEX_TOOLTIP       2
#define DATA_INDEX_COLOR         3
#define DATA_INDEX_CREATOR       4
#define DATA_INDEX_LOCK_POSITION 5
