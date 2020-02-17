#define COMPONENT context_actions
#define COMPONENT_BEAUTIFIED Context Actions
#include "\x\zen\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_CONTEXT_ACTIONS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_CONTEXT_ACTIONS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_CONTEXT_ACTIONS
#endif

#include "\x\zen\addons\main\script_macros.hpp"

#define HEAL_MODE_ALL 0
#define HEAL_MODE_PLAYERS 1
#define HEAL_MODE_AI 2
