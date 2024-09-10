#define COMPONENT custom_modules
#define COMPONENT_BEAUTIFIED Custom Modules
#include "\x\zen\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_CUSTOM_MODULES
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_CUSTOM_MODULES
    #define DEBUG_SETTINGS DEBUG_SETTINGS_CUSTOM_MODULES
#endif

#include "\x\zen\addons\main\script_macros.hpp"

#include "\x\zen\addons\common\defineResinclDesign.inc"

#define ICON_DEFAULT "\a3\modules_f\data\portraitmodule_ca.paa"
