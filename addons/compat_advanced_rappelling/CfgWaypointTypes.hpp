class ZEN_WaypointTypes {
    class AdvancedRappel {
        displayName = CSTRING(Rappel);
        type = "SCRIPTED";
        script = QPATHTOF(functions\fnc_waypointRappel.sqf);
        condition = QUOTE(!isNil 'AR_RAPPELLING_INIT');
    };
};
