#define COMPONENT visibility
#define COMPONENT_BEAUTIFIED Visibility
#include "\x\zen\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_VISIBILITY
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_VISIBILITY
    #define DEBUG_SETTINGS DEBUG_SETTINGS_VISIBILITY
#endif

#include "\x\zen\addons\main\script_macros.hpp"

#include "\x\zen\addons\common\defineResinclDesign.inc"

#define INDICATOR_DISABLED       0
#define INDICATOR_ENABLED        1
#define INDICATOR_PLACEMENT_ONLY 2
