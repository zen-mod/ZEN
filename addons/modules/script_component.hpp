#define COMPONENT modules
#define COMPONENT_BEAUTIFIED Modules
#include "\x\zen\addons\main\script_mod.hpp"

#define DEBUG_MODE_FULL
#define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_MODULES
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_MODULES
    #define DEBUG_SETTINGS DEBUG_SETTINGS_MODULES
#endif

#include "\x\zen\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\a3\ui_f_curator\ui\defineResinclDesign.inc"

#define IDC_TELEPORTPLAYERS_BUTTON_SIDES 52000
#define IDC_TELEPORTPLAYERS_BUTTON_GROUPS 52010
#define IDC_TELEPORTPLAYERS_BUTTON_PLAYERS 52020
#define IDC_TELEPORTPLAYERS_TAB_SIDES 52100
#define IDC_TELEPORTPLAYERS_TAB_GROUPS 52110
#define IDC_TELEPORTPLAYERS_TAB_PLAYERS 52120
#define IDC_TELEPORTPLAYERS_BLUFOR 52201
#define IDC_TELEPORTPLAYERS_OPFOR 52200
#define IDC_TELEPORTPLAYERS_INDEPENDENT 52202
#define IDC_TELEPORTPLAYERS_CIVILIAN 52203
#define IDC_TELEPORTPLAYERS_GROUPS 52300
#define IDC_TELEPORTPLAYERS_GROUPS_SEARCH 52310
#define IDC_TELEPORTPLAYERS_GROUPS_BUTTON 52320
#define IDC_TELEPORTPLAYERS_PLAYERS 52400
#define IDC_TELEPORTPLAYERS_PLAYERS_SEARCH 52410
#define IDC_TELEPORTPLAYERS_PLAYERS_BUTTON 52420

#define ICON_CHECKED "\a3\ui_f\data\gui\rsccommon\rsccheckbox\checkbox_checked_ca.paa"
#define ICON_UNCHECKED "\a3\ui_f\data\gui\rsccommon\rsccheckbox\checkbox_unchecked_ca.paa"

#define ICON_BLUFOR QPATHTOEF(common,UI\icon_blufor_ca.paa)
#define ICON_OPFOR QPATHTOEF(common,UI\icon_opfor_ca.paa)
#define ICON_INDEPENDENT QPATHTOEF(common,UI\icon_independent_ca.paa)
#define ICON_CIVILIAN QPATHTOEF(common,UI\icon_civilian_ca.paa)

#define GET_SIDE_ICON(UNIT) ([ARR_4(ICON_OPFOR, ICON_BLUFOR, ICON_INDEPENDENT, ICON_CIVILIAN)] select ([side UNIT] call BIS_fnc_sideID))
