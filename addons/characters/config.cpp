#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"zen_common"};
        author = ECSTRING(main,Author);
        authors[] = {"Kex"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;

        // This prevents any patched class from requiring this addon
        addonRootClass = "A3_Characters_F";
    };
};

#include "CfgEditorSubcategories.hpp"
#include "CfgVehicles.hpp"
