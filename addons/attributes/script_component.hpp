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
#include "\x\zen\addons\common\defineResinclDesign.inc"

#define POS_X(N) ((N) * GUI_GRID_W + GUI_GRID_CENTER_X)
#define POS_Y(N) ((N) * GUI_GRID_H + GUI_GRID_CENTER_Y)
#define POS_W(N) ((N) * GUI_GRID_W)
#define POS_H(N) ((N) * GUI_GRID_H)

#define IDC_TITLE      110
#define IDC_BACKGROUND 120
#define IDC_CONTENT    130

#define IDD_DISPLAY 26514
#define IDC_DISPLAY_TITLE      100
#define IDC_DISPLAY_BACKGROUND 200
#define IDC_DISPLAY_CONTENT    300

#define IDC_ATTRIBUTE_GROUP      400
#define IDC_ATTRIBUTE_LABEL      401
#define IDC_ATTRIBUTE_BACKGROUND 402
#define IDC_ATTRIBUTE_COMBO      403
#define IDC_ATTRIBUTE_EDIT       404
#define IDC_ATTRIBUTE_SLIDER     405
#define IDC_ATTRIBUTE_TOOLBOX    406

#define MAX_HEIGHT POS_H(25)
#define VERTICAL_SPACING POS_H(0.1)

#define MAX_PLATE_CHARACTERS 15

#define RANKS       ["PRIVATE", "CORPORAL", "SERGEANT", "LIEUTENANT", "CAPTAIN", "MAJOR", "COLONEL"]
#define STANCES     ["DOWN", "MIDDLE", "UP", "AUTO"]
#define FORMATIONS  ["WEDGE", "VEE", "LINE", "COLUMN", "FILE", "STAG COLUMN", "ECH LEFT", "ECH RIGHT", "DIAMOND", "NO CHANGE"]
#define BEHAVIOURS  ["CARELESS", "SAFE", "AWARE", "COMBAT", "STEALTH", "UNCHANGED"]
#define COMBATMODES ["BLUE", "GREEN", "WHITE", "YELLOW", "RED", "NO CHANGE"]
#define SPEEDMODES  ["LIMITED", "NORMAL", "FULL", "UNCHANGED"]
