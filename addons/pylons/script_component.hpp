#define COMPONENT pylons
#define COMPONENT_BEAUTIFIED Pylons
#include "\x\zen\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_PYLONS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_PYLONS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_PYLONS
#endif

#include "\x\zen\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\x\zen\addons\common\defineResinclDesign.inc"

#define IDC_PICTURE 800
#define IDC_PRESETS 810
#define IDC_MIRROR  820

#define ICON_DRIVER "\a3\ui_f\data\igui\cfg\commandbar\imagedriver_ca.paa"
#define ICON_GUNNER "\a3\ui_f\data\igui\cfg\commandbar\imagegunner_ca.paa"

#define ICON_JETS "\a3\data_f_jets\logos\jets_logo_small_ca.paa"

// Using pixel grid system in order to match the 3DEN pylons UI
#define GRID_W(N) ((N) * pixelW * pixelGrid * 0.5)
#define GRID_H(N) ((N) * pixelH * pixelGrid * 0.5)

#define CENTER_X ((getResolution select 2) * 0.5 * pixelW)
#define CENTER_Y ((getResolution select 3) * 0.5 * pixelH)

// The pylons UIposition config entry is not used as a direct ratio of the picture's width/height
// UIposition = {1, 1} does not correspond to the bottom-right of the image
// Instead, there seems to be an extra scaling factor involved and very little information exists about this
// Below are experimentally determined values to match as closely as possible the 3DEN pylons UI
#define PICTURE_W GRID_W(124.2)
#define PICTURE_H GRID_H(69.9)

#define SCALE_FACTOR_X 1.25
#define SCALE_FACTOR_Y 1.6667

// Used to exit LBSelChanged event handler code triggered by the lbSetCurSel command
#define LOCK GVAR(lock) = true
#define UNLOCK GVAR(lock) = nil
#define EXIT_LOCKED if (!isNil QGVAR(lock)) exitWith {}
