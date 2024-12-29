#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"zen_common"};
        author = ECSTRING(main,Author);
        authors[] = {"Timi007"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

PRELOAD_ADDONS;

#include "CfgEventHandlers.hpp"
#include "Cfg3DEN.hpp"

class RscActivePicture;
class GVAR(RscActiveCommentIcon): RscActivePicture {
    onMouseEnter = QUOTE((_this select 0) setVariable [ARR_2(QQGVAR(isActive),true)]);
    onMouseExit = QUOTE((_this select 0) setVariable [ARR_2(QQGVAR(isActive),false)]);
    shadow = 1;
    text = COMMENT_ICON;
    tooltipMaxWidth = QUOTE(POS_W(15));
};
