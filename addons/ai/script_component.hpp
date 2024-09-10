#define COMPONENT ai
#define COMPONENT_BEAUTIFIED AI
#include "\x\zen\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_AI
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_AI
    #define DEBUG_SETTINGS DEBUG_SETTINGS_AI
#endif

#include "\x\zen\addons\main\script_macros.hpp"

#define AI_SUB_SKILLS ["aimingAccuracy", "aimingShake", "aimingSpeed", "commanding", "courage", "endurance", "general", "reloadSpeed", "spotDistance", "spotTime"]
