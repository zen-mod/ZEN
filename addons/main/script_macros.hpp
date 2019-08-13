#define DEBUG_SYNCHRONOUS
#include "\x\cba\addons\main\script_macros_common.hpp"
#include "\x\cba\addons\xeh\script_xeh.hpp"

// Default versioning level
#define DEFAULT_VERSIONING_LEVEL 2

#define GETVAR_SYS(var1,var2) getVariable [ARR_2(QUOTE(var1),var2)]
#define SETVAR_SYS(var1,var2) setVariable [ARR_2(QUOTE(var1),var2)]
#define SETPVAR_SYS(var1,var2) setVariable [ARR_3(QUOTE(var1),var2,true)]

#undef GETVAR
#define GETVAR(var1,var2,var3) (var1 GETVAR_SYS(var2,var3))
#define GETMVAR(var1,var2) (missionNamespace GETVAR_SYS(var1,var2))
#define GETUVAR(var1,var2) (uiNamespace GETVAR_SYS(var1,var2))
#define GETPRVAR(var1,var2) (profileNamespace GETVAR_SYS(var1,var2))
#define GETPAVAR(var1,var2) (parsingNamespace GETVAR_SYS(var1,var2))

#undef SETVAR
#define SETVAR(var1,var2,var3) var1 SETVAR_SYS(var2,var3)
#define SETPVAR(var1,var2,var3) var1 SETPVAR_SYS(var2,var3)
#define SETMVAR(var1,var2) missionNamespace SETVAR_SYS(var1,var2)
#define SETUVAR(var1,var2) uiNamespace SETVAR_SYS(var1,var2)
#define SETPRVAR(var1,var2) profileNamespace SETVAR_SYS(var1,var2)
#define SETPAVAR(var1,var2) parsingNamespace SETVAR_SYS(var1,var2)

#define GETGVAR(var1,var2) GETMVAR(GVAR(var1),var2)
#define GETEGVAR(var1,var2,var3) GETMVAR(EGVAR(var1,var2),var3)

// Weapon types
#define TYPE_WEAPON_PRIMARY 1
#define TYPE_WEAPON_HANDGUN 2
#define TYPE_WEAPON_SECONDARY 4

// Magazine types
#define TYPE_MAGAZINE_HANDGUN_AND_GL 16 // mainly
#define TYPE_MAGAZINE_PRIMARY_AND_THROW 256
#define TYPE_MAGAZINE_SECONDARY_AND_PUT 512 // mainly

// More types
#define TYPE_BINOCULAR_AND_NVG 4096
#define TYPE_WEAPON_VEHICLE 65536
#define TYPE_ITEM 131072

// Item types
#define TYPE_DEFAULT 0
#define TYPE_MUZZLE 101
#define TYPE_OPTICS 201
#define TYPE_FLASHLIGHT 301
#define TYPE_BIPOD 302
#define TYPE_FIRST_AID_KIT 401
#define TYPE_FINS 501 // not implemented
#define TYPE_BREATHING_BOMB 601 // not implemented
#define TYPE_NVG 602
#define TYPE_GOGGLE 603
#define TYPE_SCUBA 604 // not implemented
#define TYPE_HEADGEAR 605
#define TYPE_FACTOR 607
#define TYPE_RADIO 611
#define TYPE_HMD 616
#define TYPE_BINOCULAR 617
#define TYPE_MEDIKIT 619
#define TYPE_TOOLKIT 620
#define TYPE_UAV_TERMINAL 621
#define TYPE_VEST 701
#define TYPE_UNIFORM 801

#define ZEN_isHC (!hasInterface && !isDedicated)

#define SELECTED_OBJECTS   (curatorSelected select 0)
#define SELECTED_GROUPS    (curatorSelected select 1)
#define SELECTED_WAYPOINTS (curatorSelected select 2)
#define SELECTED_MARKERS   (curatorSelected select 3)

#define COLOR_BACKGROUND_LIGHT 1, 1, 1, 0.1
#define COLOR_BACKGROUND_DARK  0, 0, 0, 0.2

#define GUI_THEME_RGB_R "(profileNamespace getVariable ['GUI_BCG_RGB_R',0.13])"
#define GUI_THEME_RGB_G "(profileNamespace getVariable ['GUI_BCG_RGB_G',0.54])"
#define GUI_THEME_RGB_B "(profileNamespace getVariable ['GUI_BCG_RGB_B',0.21])"
#define GUI_THEME_ALPHA "(profileNamespace getVariable ['GUI_BCG_RGB_A',0.8])"

#define GUI_THEME_COLOR {GUI_THEME_RGB_R,GUI_THEME_RGB_G,GUI_THEME_RGB_B,GUI_THEME_ALPHA}

 #define SET_BACKGROUND_COLOR \
    onLoad = QUOTE( \
        params ['_ctrl']; \
        private _color = if (EGVAR(common,darkMode)) then {[COLOR_BACKGROUND_DARK]} else {[COLOR_BACKGROUND_LIGHT]}; \
        _ctrl ctrlSetBackgroundColor _color; \
    )


#define DEGREE_SYMBOL toString [176]

#ifdef DISABLE_COMPILE_CACHE
    #undef PREP
    #define PREP(fncName) FUNC(fncName) = compile preprocessFileLineNumbers QPATHTOF(functions\DOUBLES(fnc,fncName).sqf)
#else
    #undef PREP
    #define PREP(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction
#endif

#include "script_debug.hpp"
