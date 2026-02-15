class EGVAR(context_menu,actions) {
    class Plots {
        displayName = CSTRING(DisplayName);
        icon = QPATHTOF(ui\ruler.paa);
        statement = QUOTE(call FUNC(selectPosition));
        args = "LINE";
        priority = 15;

        class MeasureDistance {
            displayName = CSTRING(MeasureDistance);
            icon = QPATHTOF(ui\ruler.paa);
            statement = QUOTE(call FUNC(selectPosition));
            args = "LINE";
        };
        class MeasureDistanceFromCamera {
            displayName = CSTRING(MeasureDistanceFromCamera);
            icon = QPATHTOF(ui\ruler.paa);
            statement = QUOTE([ARR_2(_args,curatorCamera)] call FUNC(setActivePlot));
            args = "LINE";
        };
        class MeasureRadius {
            displayName = CSTRING(MeasureRadius);
            icon = QPATHTOF(ui\radius.paa);
            statement = QUOTE(call FUNC(selectPosition));
            args = "RADIUS";
        };
        class MeasureOffset {
            displayName = CSTRING(MeasureOffset);
            icon = QPATHTOF(ui\cuboid.paa);
            statement = QUOTE(call FUNC(selectPosition));
            args = "RECTANGLE";
        };
        class ClearPlots {
            displayName = CSTRING(ClearPlots);
            icon = "A3\3den\Data\Displays\Display3DEN\PanelLeft\entityList_delete_ca.paa";
            statement = QUOTE([QQGVAR(plotsCleared)] call CBA_fnc_localEvent);
        };
    };
};
