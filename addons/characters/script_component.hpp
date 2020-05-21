#define COMPONENT characters
#define COMPONENT_BEAUTIFIED Characters
#include "\x\zen\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_CHARACTERS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_CHARACTERS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_CHARACTERS
#endif

#include "\x\zen\addons\main\script_macros.hpp"

#define C_MAN_SICK_ATTRIBUTE_MODIFICATIONS \
    editorSubcategory = "EdSubcat_Personnel_Sick";\
    scope = 2;\
    scopeCurator = 2;\
    class EventHandlers {\
        init = "(_this select 0) setIdentity selectRandom [\
            'BIS_Ambient01_sick',\
            'BIS_Ambient02_sick',\
            'BIS_Ambient03_sick',\
            'BIS_Arthur_Sick',\
            'BIS_Howard_sick',\
            'BIS_John_sick',\
            'BIS_Lucas_sick',\
            'BIS_Renly_sick'\
        ];\
        (_this select 0) setDamage 0.45";\
    };
