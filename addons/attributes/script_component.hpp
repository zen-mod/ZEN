#define COMPONENT attributes
#define COMPONENT_BEAUTIFIED Attributes
#include "\x\zen\addons\main\script_mod.hpp"

#define DEBUG_MODE_FULL
#define DISABLE_COMPILE_CACHE
#define ENABLE_PERFORMANCE_COUNTERS

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

#define IDD_DISPLAY 530
#define IDC_DISPLAY_TITLE 10
#define IDC_DISPLAY_BACKGROUND 11
#define IDC_DISPLAY_CONTENT 12

#define IDC_ATTRIBUTE_GROUP 30
#define IDC_ATTRIBUTE_LABEL 31
#define IDC_ATTRIBUTE_BACKGROUND 32
#define IDC_ATTRIBUTE_SLIDER 33
#define IDC_ATTRIBUTE_EDIT 34
#define IDC_ATTRIBUTE_COMBO 35
#define IDC_ATTRIBUTE_TOOLBOX 36
#define IDC_ATTRIBUTE_CHECKBOX 37

#define MAX_HEIGHT POS_H(25)
#define VERTICAL_SPACING POS_H(0.1)

#define RANKS ["PRIVATE", "CORPORAL", "SERGEANT", "LIEUTENANT", "CAPTAIN", "MAJOR", "COLONEL"]
#define STANCES ["DOWN", "MIDDLE", "UP", "AUTO"]
#define FORMATIONS ["WEDGE", "VEE", "LINE", "COLUMN", "FILE", "STAG COLUMN", "ECH LEFT", "ECH RIGHT", "DIAMOND", "NO CHANGE"]
#define BEHAVIOURS ["CARELESS", "SAFE", "AWARE", "COMBAT", "STEALTH", "UNCHANGED"]
#define COMBATMODES ["BLUE", "GREEN", "WHITE", "YELLOW", "RED", "NO CHANGE"]
#define SPEEDMODES ["LIMITED", "NORMAL", "FULL", "UNCHANGED"]

#define MAX_PLATE_CHARACTERS 15
