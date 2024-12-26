#define COMPONENT comments
#define COMPONENT_BEAUTIFIED Comments
#include "\x\zen\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_COMMENTS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_COMMENTS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_COMMENTS
#endif

#include "\x\zen\addons\main\script_macros.hpp"

#include "\x\zen\addons\common\defineResinclDesign.inc"

// Ignore comments that include following string in the description/tooltip
#define IGNORE_3DEN_COMMENT_STRING "#ZEN_IGNORE#"
