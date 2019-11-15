#define COMPONENT position_logics
#define COMPONENT_BEAUTIFIED Position Logics
#include "\x\zen\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_POSITION_LOGICS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_POSITION_LOGICS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_POSITION_LOGICS
#endif

#include "\x\zen\addons\main\script_macros.hpp"

#define VAR_LIST(type) format [QGVAR(list::%1), type]
#define VAR_NEXTID(type) format [QGVAR(nextID::%1), type]
