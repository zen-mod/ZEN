#define COMPONENT selection_presets
#define COMPONENT_BEAUTIFIED Selection Presets
#include "\x\zen\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_SELECTION_PRESETS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_SELECTION_PRESETS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_SELECTION_PRESETS
#endif

#include "\x\zen\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\a3\ui_f_curator\ui\defineResinclDesign.inc"

#define POS_X(N) ((N) * GUI_GRID_W + GUI_GRID_CENTER_X)
#define POS_Y(N) ((N) * GUI_GRID_H + GUI_GRID_CENTER_Y)
#define POS_W(N) ((N) * GUI_GRID_W)
#define POS_H(N) ((N) * GUI_GRID_H)

#define IDC_PRESETS 93400
#define IDC_PRESETS_FRAME 93410

#define IDC_SLOT_BACKGROUND 93420
#define IDC_SLOT_DIVIDER 93430
#define IDC_SLOT_KEY 93440
#define IDC_SLOT_ICON_1 93450
#define IDC_SLOT_ICON_2 93460
#define IDC_SLOT_ICON_3 93470
#define IDC_SLOT_EXTRA_COUNT 93480
#define IDC_SLOT_MOUSE 93490

#define IDC_ADD_PRESET 93500
#define IDC_ADD_PRESET_BACKGROUND 93510
#define IDC_ADD_PRESET_DIVIDER 93520
#define IDC_ADD_PRESET_PLUS 93530
#define IDC_ADD_PRESET_MOUSE 93540

#define SLOT_LAYOUT_WIDE    "wide"    // Key beside four cells
#define SLOT_LAYOUT_STACKED "stacked" // Key above four cells
#define SLOT_LAYOUT_COMPACT "compact" // Key above a 2x2 grid of cells

#define PLUS_ICON_SIZE 0.5

// Selection presets use hardcoded number keys as identifiers
#define PRESET_KEYS [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]

#define USE_GROUP_ICONS_NO                  0
#define USE_GROUP_ICONS_YES                 1
#define USE_GROUP_ICONS_EXCEPT_SINGLE_UNITS 2

#define EXCLUDE_FROM_PRESETS_NONE              0
#define EXCLUDE_FROM_PRESETS_PROPS             1
#define EXCLUDE_FROM_PRESETS_MODULES           2
#define EXCLUDE_FROM_PRESETS_PROPS_AND_MODULES 3

#define EMPTY_SLOT_MODE_SHOW_ALL                0
#define EMPTY_SLOT_MODE_HIDE_EMPTY_SLOTS        1
#define EMPTY_SLOT_MODE_REPLACE_WITH_ADD_BUTTON 2
