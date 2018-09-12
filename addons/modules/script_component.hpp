#define COMPONENT modules
#define COMPONENT_BEAUTIFIED Modules
#include "\x\zen\addons\main\script_mod.hpp"

#define DEBUG_MODE_FULL
#define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_MODULES
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_MODULES
    #define DEBUG_SETTINGS DEBUG_SETTINGS_MODULES
#endif

#include "\x\zen\addons\main\script_macros.hpp"
