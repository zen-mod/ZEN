#define COMPONENT faction_filter
#define COMPONENT_BEAUTIFIED Faction Filter
#include "\x\zen\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_FACTION_FILTER
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_FACTION_FILTER
    #define DEBUG_SETTINGS DEBUG_SETTINGS_FACTION_FILTER
#endif

#include "\x\zen\addons\main\script_macros.hpp"

#include "\x\zen\addons\common\defineResinclDesign.inc"
