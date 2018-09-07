#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"zen_main"};
        author = "";
        url = "";
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgCurator.hpp"
