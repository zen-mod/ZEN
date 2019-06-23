#define COMPONENT doors
#define COMPONENT_BEAUTIFIED Doors
#include "\x\zen\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_DOORS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_DOORS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_DOORS
#endif

#include "\x\zen\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\x\zen\addons\common\defineResinclDesign.inc"

#define POS_X(N) ((N) * GUI_GRID_W + GUI_GRID_CENTER_X)
#define POS_Y(N) ((N) * GUI_GRID_H + GUI_GRID_CENTER_Y)
#define POS_W(N) ((N) * GUI_GRID_W)
#define POS_H(N) ((N) * GUI_GRID_H)

#define ICON_CLOSED "\a3\modules_f\data\editterrainobject\icon3d_doorclosed32_ca.paa"
#define ICON_LOCKED "\a3\modules_f\data\editterrainobject\icon3d_doorlocked32_ca.paa"
#define ICON_OPENED "\a3\modules_f\data\editterrainobject\icon3d_dooropened32_ca.paa"

#define COLOR_CLOSED [1, 1, 1, 1]
#define COLOR_LOCKED [1, 0, 1, 1]
#define COLOR_OPENED [1, 0, 1, 1]

#define STATE_CLOSED 0
#define STATE_LOCKED 1
#define STATE_OPENED 2

#define LOCKED_VAR(DOOR) (format ["bis_disabled_door_%1", DOOR])

#define ANIM_NAME_1(DOOR) (format ["door_%1_sound_source", DOOR])
#define ANIM_NAME_2(DOOR) (format ["door_%1_noSound_source", DOOR])

#define DISTANCE_DRAW   100
#define DISTANCE_CANCEL 200

#define ICON_SIZE_MIN 1
#define ICON_SIZE_MAX 1.75
