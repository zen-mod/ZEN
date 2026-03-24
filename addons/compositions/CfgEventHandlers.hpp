class Extended_PreStart_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_SCRIPT(XEH_preStart));
    };
};

class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_SCRIPT(XEH_preInit));
    };
};

class Extended_PostInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_SCRIPT(XEH_postInit));
    };
};

class Extended_DisplayLoad_EventHandlers {
    class Display3DEN {
        ADDON = QUOTE(call (uiNamespace getVariable QQFUNC(initDisplay3DEN)));
    };
    class Display3DENPlace {
        ADDON = QUOTE(call (uiNamespace getVariable QQFUNC(initDisplay3DEN)));
    };
};
