#define COMPONENT attributes
#define COMPONENT_BEAUTIFIED Attributes
#include "\x\zen\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_ATTRIBUTES
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_ATTRIBUTES
    #define DEBUG_SETTINGS DEBUG_SETTINGS_ATTRIBUTES
#endif

#include "\x\zen\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\x\zen\addons\common\defineResinclDesign.inc"

#define POS_X(N) ((N) * GUI_GRID_W + GUI_GRID_CENTER_X)
#define POS_Y(N) ((N) * GUI_GRID_H + GUI_GRID_CENTER_Y)
#define POS_W(N) ((N) * GUI_GRID_W)
#define POS_H(N) ((N) * GUI_GRID_H)

#define IDC_ATTRIBUTE_GROUP      400
#define IDC_ATTRIBUTE_LABEL      401
#define IDC_ATTRIBUTE_BACKGROUND 402
#define IDC_ATTRIBUTE_COMBO      403
#define IDC_ATTRIBUTE_EDIT       404
#define IDC_ATTRIBUTE_SLIDER     405
#define IDC_ATTRIBUTE_TOOLBOX    406
#define IDC_ATTRIBUTE_MODE       407

#define VERTICAL_SPACING POS_H(0.1)

#define MAX_PLATE_CHARACTERS 15

#define MODE_LOCAL  0
#define MODE_TARGET 1
#define MODE_GLOBAL 2

#define AI_ABILITIES ["AIMINGERROR", "ANIM", "AUTOCOMBAT", "AUTOTARGET", "CHECKVISIBLE", "COVER", "FSM", "LIGHTS", "MINEDETECTION", "MOVE", "NVG", "PATH", "RADIOPROTOCOL", "SUPPRESSION", "TARGET", "TEAMSWITCH", "WEAPONAIM"]
