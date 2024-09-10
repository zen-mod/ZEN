#define COMPONENT doors
#define COMPONENT_BEAUTIFIED Doors
#include "\x\zen\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

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

#define ICON_DOOR "\a3\ui_f\data\igui\cfg\actions\open_door_ca.paa"

#define TEXT_CLOSED localize "STR_a3_to_editTerrainObject21"
#define TEXT_LOCKED localize "STR_a3_to_editTerrainObject23"
#define TEXT_OPENED localize "STR_a3_to_editTerrainObject22"

#define ICON2D_CLOSED "\a3\modules_f\data\editterrainobject\texturedoor_closed_ca.paa"
#define ICON2D_LOCKED "\a3\modules_f\data\editterrainobject\texturedoor_locked_ca.paa"
#define ICON2D_OPENED "\a3\modules_f\data\editterrainobject\texturedoor_opened_ca.paa"

#define ICON3D_CLOSED "\a3\modules_f\data\editterrainobject\icon3d_doorclosed32_ca.paa"
#define ICON3D_LOCKED "\a3\modules_f\data\editterrainobject\icon3d_doorlocked32_ca.paa"
#define ICON3D_OPENED "\a3\modules_f\data\editterrainobject\icon3d_dooropened32_ca.paa"

#define COLOR_CLOSED [1, 1, 1, 1]
#define COLOR_LOCKED [1, 0, 1, 1]
#define COLOR_OPENED [1, 0, 1, 1]

#define STATE_CLOSED 0
#define STATE_LOCKED 1
#define STATE_OPENED 2

#define VAR_LOCKED(x) format ["bis_disabled_door_%1", x]

#define ANIM_NAME_1(x) format ["door_%1_sound_source", x]
#define ANIM_NAME_2(x) format ["door_%1_noSound_source", x]

#define DISTANCE_DRAW   100
#define DISTANCE_CANCEL 200

#define ICON_SIZE_MIN 1
#define ICON_SIZE_MAX 1.75
