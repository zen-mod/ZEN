#define COMPONENT context_menu
#define COMPONENT_BEAUTIFIED Context Menu
#include "\x\zen\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_CONTEXT_MENU
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_CONTEXT_MENU
    #define DEBUG_SETTINGS DEBUG_SETTINGS_CONTEXT_MENU
#endif

#include "\x\zen\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\x\zen\addons\common\defineResinclDesign.inc"

#define POS_X(N) ((N) * GUI_GRID_W + GUI_GRID_CENTER_X)
#define POS_Y(N) ((N) * GUI_GRID_H + GUI_GRID_CENTER_Y)
#define POS_W(N) ((N) * GUI_GRID_W)
#define POS_H(N) ((N) * GUI_GRID_H)

#define IDC_CONTEXT_GROUP 185000
#define IDC_CONTEXT_BACKGROUND 200
#define IDC_CONTEXT_ROW 300
#define IDC_CONTEXT_HIGHLIGHT 310
#define IDC_CONTEXT_NAME 320
#define IDC_CONTEXT_ICON 330
#define IDC_CONTEXT_EXPANDABLE 340
#define IDC_CONTEXT_MOUSE 350

#define SPACING_W POS_W(0.2)
#define SPACING_H POS_H(0.2)

#define SETUP_ACTION_VARS \
    private _contextPosASL = call FUNC(getContextPos); \
    private _hoveredEntity = GVAR(hovered); \
    +GVAR(selected) params ["_selectedObjects", "_selectedGroups", "_selectedWaypoints", "_selectedMarkers"]

#define ACTION_PARAMS [_contextPosASL, _selectedObjects, _selectedGroups, _selectedWaypoints, _selectedMarkers, _hoveredEntity, _arguments]
