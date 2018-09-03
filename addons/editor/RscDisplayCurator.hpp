class RscText;
class RscFrame;
class RscPicture;
class RscTree;
class RscControlsGroupNoScrollbars;

#define POS_EDGE(DEFAULT,MOVED) ([ARR_2(DEFAULT,MOVED)] select GETMVAR(GVAR(moveDisplayToEdge),false))

class RscDisplayCurator {
    class Controls {
        class Main: RscControlsGroupNoScrollbars {
            x = safeZoneX + POS_EDGE(12.5,11) * GUI_GRID_W;
            y = safeZoneY + POS_EDGE(0.5,0) * GUI_GRID_H;
            w = safeZoneW - POS_EDGE(25,22) * GUI_GRID_W;
            class controls {
                class PointsBackground: RscText {
                    w = safeZoneW - POS_EDGE(25,22) * GUI_GRID_W;
                };
                class Points: RscText {
                    w = safeZoneW - POS_EDGE(25,22) * GUI_GRID_W;
                };
                class PointsPreview: RscText {
                    x = POS_EDGE(7,8) * GUI_GRID_W;
                };
                class PointsFrame: RscFrame {
                    w = safeZoneW - POS_EDGE(25,22) * GUI_GRID_W;
                };
                class Logo: RscPicture {
                    x = (safeZoneW - POS_EDGE(25,22) * GUI_GRID_W) / 2 - 0.5 * GUI_GRID_W;
                };
                class FeedbackMessage: RscText {
                    w = safeZoneW - POS_EDGE(25,22) * GUI_GRID_W;
                };
            };
        };
        class AddBar: RscControlsGroupNoScrollbars {
            x = safeZoneX + safeZoneW - POS_EDGE(12.5,11) * GUI_GRID_W;
            y = safeZoneY + POS_EDGE(0.5,0) * GUI_GRID_H;
        };
        class Add: RscControlsGroupNoScrollbars {
            x = safeZoneX + safeZoneW - POS_EDGE(12.5,11) * GUI_GRID_W;
            y = safeZoneY + POS_EDGE(1.5,1) * GUI_GRID_H;
            h = safeZoneH - POS_EDGE(2,1) * GUI_GRID_H;
            class controls {
                class CreateBackground: RscText {
                    h = safeZoneH - POS_EDGE(2,1) * GUI_GRID_H;
                };
                class CreateClassesBackground: RscText {
                    h = safeZoneH - POS_EDGE(6,5) * GUI_GRID_H;
                };
                class CreateFrame: RscFrame {
                    h = safeZoneH - POS_EDGE(6,5) * GUI_GRID_H;
                };
                class CreateUnitsWest: RscTree {
                    h = safeZoneH - POS_EDGE(7.1,6.1) * GUI_GRID_H;
                };
            };
        };
        class MissionBar: RscControlsGroupNoScrollbars {
            x = safeZoneX + POS_EDGE(1.5,0) * GUI_GRID_W;
            y = safeZoneY + POS_EDGE(0.5,0) * GUI_GRID_H;
        };
        class Mission: RscControlsGroupNoScrollbars {
            x = safeZoneX + POS_EDGE(1.5,0) * GUI_GRID_W;
            y = safeZoneY + POS_EDGE(1.5,1) * GUI_GRID_H;
            h = safeZoneH - POS_EDGE(2,1) * GUI_GRID_H;
            class controls {
                class EntitiesBackground: RscText {
                    h = safeZoneH - POS_EDGE(2,1) * GUI_GRID_H;
                };
                class EntitiesFrame: RscFrame {
                    h = safeZoneH - POS_EDGE(2,1) * GUI_GRID_H;
                };
                class Entities: RscTree {
                    h = safeZoneH - POS_EDGE(2,1) * GUI_GRID_H;
                };
            };
        };
    };
};
