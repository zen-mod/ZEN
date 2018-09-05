#define COMPONENT context
#define COMPONENT_BEAUTIFIED Context
#include "\x\zen\addons\main\script_mod.hpp"

#define DEBUG_MODE_FULL
#define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_CONTEXT
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_CONTEXT
    #define DEBUG_SETTINGS DEBUG_SETTINGS_CONTEXT
#endif

#include "\x\zen\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineCommonGrids.inc"

#define IDC_CONTEXT_GROUP 185000
#define IDC_CONTEXT_BACKGROUND 200

#define IDC_CONTEXT_ROW 300
#define IDC_CONTEXT_HIGHLIGHT 310
#define IDC_CONTEXT_NAME 320
#define IDC_CONTEXT_PICTURE 330
#define IDC_CONTEXT_EXPANDABLE 340
#define IDC_CONTEXT_MOUSE 350
