#define COMPONENT markers_tree
#define COMPONENT_BEAUTIFIED Markers Tree
#include "\x\zen\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_MARKERS_TREE
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_MARKERS_TREE
    #define DEBUG_SETTINGS DEBUG_SETTINGS_MARKERS_TREE
#endif

#include "\x\zen\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\x\zen\addons\common\defineResinclDesign.inc"
#include "\x\zen\addons\editor\script_idc.hpp"

#define IDC_MARKERS_TREE 92892

#define IDCS_MODE_BUTTONS [ \
    IDC_RSCDISPLAYCURATOR_MODEUNITS, \
    IDC_RSCDISPLAYCURATOR_MODEGROUPS, \
    IDC_RSCDISPLAYCURATOR_MODEMODULES, \
    IDC_RSCDISPLAYCURATOR_MODEMARKERS, \
    IDC_RSCDISPLAYCURATOR_MODERECENT \
]
