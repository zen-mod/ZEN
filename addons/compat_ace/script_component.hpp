#define COMPONENT compat_ace
#define COMPONENT_BEAUTIFIED ACE Compatibility
#include "\x\zen\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_COMPAT_ACE
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_COMPAT_ACE
    #define DEBUG_SETTINGS DEBUG_SETTINGS_COMPAT_ACE
#endif

#include "\x\zen\addons\main\script_macros.hpp"

// ACE3 reference macros
#define ACE_PREFIX ace

#define ACEGVAR(component,variable) TRIPLES(ACE_PREFIX,component,variable)
#define QACEGVAR(component,variable) QUOTE(ACEGVAR(component,variable))

#define ACEFUNC(component,function) TRIPLES(DOUBLES(ACE_PREFIX,component),fnc,function)
#define QACEFUNC(component,function) QUOTE(ACEFUNC(component,function))
