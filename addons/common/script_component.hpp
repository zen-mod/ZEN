#define COMPONENT common
#define COMPONENT_BEAUTIFIED Common
#include "\x\zen\addons\main\script_mod.hpp"

#define DEBUG_MODE_FULL
#define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_COMMON
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_COMMON
    #define DEBUG_SETTINGS DEBUG_SETTINGS_COMMON
#endif

#include "\x\zen\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\a3\ui_f_curator\ui\defineResinclDesign.inc"

#define ICON_TARGET "\a3\ui_f\data\IGUI\Cfg\Cursors\select_target_ca.paa"

#define ICON_BLUFOR      QPATHTOF(UI\icon_blufor_ca.paa)
#define ICON_OPFOR       QPATHTOF(UI\icon_opfor_ca.paa)
#define ICON_INDEPENDENT QPATHTOF(UI\icon_independent_ca.paa)
#define ICON_CIVILIAN    QPATHTOF(UI\icon_civilian_ca.paa)
