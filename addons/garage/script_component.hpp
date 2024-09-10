#define COMPONENT garage
#define COMPONENT_BEAUTIFIED Garage
#include "\x\zen\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_GARAGE
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_GARAGE
    #define DEBUG_SETTINGS DEBUG_SETTINGS_GARAGE
#endif

#include "\x\zen\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\x\zen\addons\common\defineResinclDesign.inc"

#define POS_X(N) ((N) * GUI_GRID_W + GUI_GRID_CENTER_X)
#define POS_Y(N) ((N) * GUI_GRID_H + GUI_GRID_CENTER_Y)
#define POS_W(N) ((N) * GUI_GRID_W)
#define POS_H(N) ((N) * GUI_GRID_H)

#define ICON_CHECKED   "\a3\ui_f\data\gui\rsccommon\rsccheckbox\checkbox_checked_ca.paa"
#define ICON_UNCHECKED "\a3\ui_f\data\gui\rsccommon\rsccheckbox\checkbox_unchecked_ca.paa"
#define CHECK_ICONS    [ICON_UNCHECKED, ICON_CHECKED]

#define FADE_DELAY 0.15

#define ZEUS_DISPLAY (findDisplay IDD_RSCDISPLAYCURATOR)

#define IDD_DISPLAY 10500

#define IDC_MOUSEAREA 300

#define IDC_BACKGROUND_ANIMATIONS 310
#define IDC_BUTTON_ANIMATIONS 311
#define IDC_LIST_ANIMATIONS 312

#define IDC_BACKGROUND_TEXTURES 320
#define IDC_BUTTON_TEXTURES 321
#define IDC_LIST_TEXTURES 322

#define IDC_LIST_BACKGROUND 330
#define IDC_LIST_FRAME 331
#define IDC_LIST_EMPTY 332

#define IDC_MENU_BAR 340
#define IDC_BUTTON_APPLY 341

#define IDC_INFO_GROUP 350
#define IDC_INFO_NAME 351
#define IDC_INFO_AUTHOR 352
#define IDC_DLC_BACKGROUND 353
#define IDC_DLC_ICON 354
