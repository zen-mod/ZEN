#define COMPONENT flashlight
#define COMPONENT_BEAUTIFIED Flashlight
#include "\x\zen\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_FLASHLIGHT
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_FLASHLIGHT
    #define DEBUG_SETTINGS DEBUG_SETTINGS_FLASHLIGHT
#endif

#include "\x\zen\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineDIKCodes.inc"

#define LIGHT_INTENSITY 20
