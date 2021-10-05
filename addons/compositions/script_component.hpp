#define COMPONENT compositions
#define COMPONENT_BEAUTIFIED Compositions
#include "\x\zen\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_COMPOSITIONS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_COMPOSITIONS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_COMPOSITIONS
#endif

#include "\x\zen\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\x\zen\addons\common\defineResinclDesign.inc"
#include "\x\zen\addons\editor\script_idc.hpp"

#define POS_X(N) ((N) * GUI_GRID_W + GUI_GRID_CENTER_X)
#define POS_Y(N) ((N) * GUI_GRID_H + GUI_GRID_CENTER_Y)
#define POS_W(N) ((N) * GUI_GRID_W)
#define POS_H(N) ((N) * GUI_GRID_H)

#define IDC_PANEL_GROUP 9500
#define IDC_PANEL_CREATE 9501
#define IDC_PANEL_EDIT 9502
#define IDC_PANEL_RANDOMIZE 9503
#define IDC_PANEL_DELETE 9504

#define IDC_DISPLAY_TITLE 1000
#define IDC_DISPLAY_CATEGORY 1001
#define IDC_DISPLAY_LIST 1002
#define IDC_DISPLAY_NAME 1003

#define ICON_CUSTOM "\a3\3den\data\cfg3den\group\iconcustomcomposition_ca.paa"

#define CATEGORY GVAR(category)
#define CATEGORY_STR QUOTE(CATEGORY)

#define SUBCATEGORY GVAR(subcategory)
#define SUBCATEGORY_STR QUOTE(SUBCATEGORY)

#define COMPOSITION GVAR(composition)
#define COMPOSITION_STR QUOTE(COMPOSITION)

#define VAR_COMPOSITIONS QGVAR(data)
#define GET_COMPOSITIONS (profileNamespace getVariable [VAR_COMPOSITIONS, createHashMap])
#define SET_COMPOSITIONS(value) (profileNamespace setVariable [VAR_COMPOSITIONS, value])

#define GET_COMPOSITION(category,name) (GET_COMPOSITIONS get category get name)

#define OBJECT_DATA_VAR(category,name) format [QGVAR(%1:%2), category, name]

#define GET_PARENT_PATH(path) (path select [0, count path - 1])
