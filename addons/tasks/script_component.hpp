#define COMPONENT tasks
#define COMPONENT_BEAUTIFIED Tasks
#include "\x\zen\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_TASKS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_TASKS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_TASKS
#endif

#include "\x\zen\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\x\zen\addons\common\defineResinclDesign.inc"

#define POS_X(N) ((N) * GUI_GRID_W + GUI_GRID_CENTER_X)
#define POS_Y(N) ((N) * GUI_GRID_H + GUI_GRID_CENTER_Y)
#define POS_W(N) ((N) * GUI_GRID_W)
#define POS_H(N) ((N) * GUI_GRID_H)

#define IDC_TASK_OWNERS 900
#define IDC_TASK_STATE 910
#define IDC_TASK_DESTINATION 920
#define IDC_TASK_TYPE 930
#define IDC_TASK_HISTORY 940
#define IDC_TASK_TITLE 950
#define IDC_TASK_DESCRIPTION 960

#define TASK_STATES ["CREATED", "ASSIGNED", "SUCCEEDED", "FAILED", "CANCELED"]

#define VAR_HISTORY QGVAR(history)
#define MAX_HISTORY_SIZE 20
