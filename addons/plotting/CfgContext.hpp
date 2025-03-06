class EGVAR(context_menu,actions) {
    class Plots {
        displayName = CSTRING(DisplayName);
        icon = "\a3\ui_f\data\IGUI\Cfg\Actions\autohover_ca.paa";
        statement = QUOTE(call FUNC(selectPosition));
        args = "LINE";
        priority = 15;

        class MeasureDistance {
            displayName = "MeasureDistance";
            icon = "\a3\ui_f\data\IGUI\Cfg\Actions\autohover_ca.paa";
            statement = QUOTE(call FUNC(selectPosition));
            args = "LINE";
        };
        class Radius {
            displayName = "Radius";
            icon = "\a3\ui_f\data\IGUI\Cfg\Actions\autohover_ca.paa";
            statement = QUOTE(call FUNC(selectPosition));
            args = "RADIUS";
        };
        class Rectangle {
            displayName = "Rectangle";
            icon = "\a3\ui_f\data\IGUI\Cfg\Actions\autohover_ca.paa";
            statement = QUOTE(call FUNC(selectPosition));
            args = "RECTANGLE";
        };
        class ClearPlots {
            displayName = CSTRING(ClearPlots);
            icon = "A3\3den\Data\Displays\Display3DEN\PanelLeft\entityList_delete_ca.paa";
            statement = QUOTE(call FUNC(clearPlots));
        };
    };
};
