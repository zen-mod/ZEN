#define COMPONENT plotting
#define COMPONENT_BEAUTIFIED Plotting
#include "\x\zen\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_PLOTTING
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_PLOTTING
    #define DEBUG_SETTINGS DEBUG_SETTINGS_PLOTTING
#endif

#include "\x\zen\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\x\zen\addons\common\defineResinclDesign.inc"

#define ICON_SCALE 1
#define MAP_ICON_SCALE 24

#define CIRCLE_DOTS_SCALE 0.5
#define CIRCLE_DOTS_MIN 6
#define CIRCLE_DOTS_SPACING 5
