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
#define IDC_CONTEXT_BACKGROUND 185010
#define IDC_CONTEXT_ROW 185020
#define IDC_CONTEXT_HIGHLIGHT 185030
#define IDC_CONTEXT_NAME 185040
#define IDC_CONTEXT_ICON 185050
#define IDC_CONTEXT_EXPANDABLE 185060
#define IDC_CONTEXT_MOUSE 185070

#define SPACING_W POS_W(0.2)
#define SPACING_H POS_H(0.2)

// _contextPosASL and _selectedObjects, _selectedGroups .., kept for BWC
#define SETUP_ACTION_VARS \
    private _position = [GVAR(mousePos)] call EFUNC(common,getPosFromScreen); \
    private _hoveredEntity = GVAR(hovered); \
    +GVAR(selected) params ["_objects", "_groups", "_waypoints", "_markers"]; \
    private _contextPosASL =  _position; \
    +GVAR(selected) params ["_selectedObjects", "_selectedGroups", "_selectedWaypoints", "_selectedMarkers"]

#define ACTION_PARAMS [_position, _objects, _groups, _waypoints, _markers, _hoveredEntity, _args]
