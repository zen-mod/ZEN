#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {
            QGVAR(helper)
        };
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"zen_editor"};
        author = ECSTRING(main,Author);
        authors[] = {"mharis001"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

PRELOAD_ADDONS;

#include "CfgEventHandlers.hpp"
#include "CfgVehicleIcons.hpp"
#include "CfgVehicles.hpp"
#include "CfgGroups.hpp"
#include "gui.hpp"
