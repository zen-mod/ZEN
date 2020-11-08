#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_main"};
        author = CSTRING(Author);
        authors[] = {"mharis001"};
        url = CSTRING(URL);
        VERSION_CONFIG;
    };
};

PRELOAD_ADDONS;

#include "CfgSettings.hpp"
