class CBA_Extended_EventHandlers_base;

class CfgVehicles {
    class Static;
    class GVAR(helper): Static {
        author = ECSTRING(main,Author);
        displayName = CSTRING(Helper_DisplayName);
        icon = QGVAR(icon);
        mapSize = 0.5;
        scope = 1;
        scopeCurator = 1;
        class EventHandlers {
            init = QUOTE(_this call FUNC(initHelper));
            class CBA_Extended_EventHandlers: CBA_Extended_EventHandlers_base {};
        };
    };
};
