class ZEN_WaypointTypes {
    class Move {
        displayName = "$STR_ac_move";
        type = "MOVE";
    };
    class Cycle {
        displayName = "$STR_ac_cycle";
        type = "CYCLE";
    };
    class SeekAndDestroy {
        displayName = "$STR_ac_seekanddestroy";
        type = "SAD";
    };
    class Hold {
        displayName = "$STR_ac_hold";
        type = "HOLD";
    };
    class Sentry {
        displayName = "$STR_ac_sentry";
        type = "SENTRY";
    };
    class GetOut {
        displayName = "$STR_ac_getout";
        type = "GETOUT";
    };
    class Unload {
        displayName = "$STR_ac_unload";
        type = "UNLOAD";
    };
    class TransportUnload {
        displayName = "$STR_ac_transportunload";
        type = "TR UNLOAD";
    };
    class Land {
        displayName = "$STR_A3_CfgWaypoints_Land";
        type = "SCRIPTED";
        script = QPATHTOEF(ai,functions\fnc_waypointLand.sqf);
    };
    class Hook {
        displayName = "$STR_ac_hook";
        type = "HOOK";
    };
    class Unhook {
        displayName = "$STR_ac_unhook";
        type = "UNHOOK";
    };
    class Loiter {
        displayName = "$STR_ac_loiter";
        type = "LOITER";
    };
    class Demine {
        displayName = "$STR_A3_Functions_F_Orange_Demine";
        type = "SCRIPTED";
        script = "\a3\functions_f_orange\waypoints\fn_wpDemine.sqf";
    };
    class Paradrop {
        displayName = ECSTRING(ai,Paradrop);
        type = "SCRIPTED";
        script = QPATHTOEF(ai,functions\fnc_waypointParadrop.sqf);
    };
    class Fastrope {
        displayName = ECSTRING(ai,Fastrope);
        type = "SCRIPTED";
        script = QPATHTOEF(ai,functions\fnc_waypointFastrope.sqf);
    };
    class SearchBuilding {
        displayName = ECSTRING(ai,SearchBuilding);
        type = "SCRIPTED";
        script = QPATHTOEF(ai,functions\fnc_waypointSearchBuilding.sqf);
    };
};
