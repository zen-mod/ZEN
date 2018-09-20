#define COMPONENT context_menu
#define COMPONENT_BEAUTIFIED Context Menu
#include "\x\zen\addons\main\script_mod.hpp"

#define DEBUG_MODE_FULL
#define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_CONTEXT_MENU
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_CONTEXT_MENU
    #define DEBUG_SETTINGS DEBUG_SETTINGS_CONTEXT_MENU
#endif

#include "\x\zen\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\a3\ui_f_curator\ui\defineResinclDesign.inc"

#define IDC_CONTEXT_GROUP 185000
#define IDC_CONTEXT_BACKGROUND 200
#define IDC_CONTEXT_ROW 300
#define IDC_CONTEXT_HIGHLIGHT 310
#define IDC_CONTEXT_NAME 320
#define IDC_CONTEXT_ICON 330
#define IDC_CONTEXT_EXPANDABLE 340
#define IDC_CONTEXT_MOUSE 350

#define SPACING_W (0.2 * GUI_GRID_W)
#define SPACING_H (0.2 * GUI_GRID_H)

#define SETUP_ACTION_VARS \
    private _contextPosASL = call FUNC(getContextPos);\
    private _hoveredEntity = GVAR(hovered);\
    +GVAR(selected) params ["_selectedObjects", "_selectedGroups", "_selectedWaypoints", "_selectedMarkers"]

#define ACTION_PARAMS [_contextPosASL, _selectedObjects, _selectedGroups, _selectedWaypoints, _selectedMarkers, _hoveredEntity]
