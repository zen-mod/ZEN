class RscText;
class RscEdit;
class RscLine;
class RscFrame;
class RscPicture;
class RscButtonSearch;
class RscControlsGroupNoScrollbars;

class RscTree {
    class ScrollBar;
};

class EGVAR(common,RscCheckbox);

class RscDisplayCurator {
    class Controls {
        class Main: RscControlsGroupNoScrollbars {
            x = QUOTE(safeZoneX + POS_EDGE(12.5,11) * GUI_GRID_W);
            y = QUOTE(safeZoneY + POS_EDGE(0.5,0) * GUI_GRID_H);
            w = QUOTE(safeZoneW - POS_EDGE(25,22) * GUI_GRID_W);
            class controls {
                class PointsBackground: RscText {
                    w = QUOTE(safeZoneW - POS_EDGE(25,22) * GUI_GRID_W);
                };
                class Points: RscText {
                    w = QUOTE(safeZoneW - POS_EDGE(25,22) * GUI_GRID_W);
                };
                class PointsPreview: RscText {
                    x = QUOTE(POS_EDGE(7,8) * GUI_GRID_W);
                };
                class PointsFrame: RscFrame {
                    w = QUOTE(safeZoneW - POS_EDGE(25,22) * GUI_GRID_W);
                };
                class Logo: RscPicture {
                    x = QUOTE((safeZoneW - POS_EDGE(25,22) * GUI_GRID_W) / 2 - 0.5 * GUI_GRID_W);
                };
                class FeedbackMessage: RscText {
                    w = QUOTE(safeZoneW - POS_EDGE(25,22) * GUI_GRID_W);
                };
            };
        };
        class AddBar: RscControlsGroupNoScrollbars {
            x = QUOTE(safeZoneX + safeZoneW - POS_EDGE(12.5,11) * GUI_GRID_W);
            y = QUOTE(safeZoneY + POS_EDGE(0.5,0) * GUI_GRID_H);
        };
        class Add: RscControlsGroupNoScrollbars {
            x = QUOTE(safeZoneX + safeZoneW - POS_EDGE(12.5,11) * GUI_GRID_W);
            y = QUOTE(safeZoneY + POS_EDGE(1.5,1) * GUI_GRID_H);
            h = QUOTE(safeZoneH - POS_EDGE(2,1) * GUI_GRID_H);
            class controls {
                class CreateBackground: RscText {
                    h = QUOTE(safeZoneH - POS_EDGE(2,1) * GUI_GRID_H);
                };
                class CreateClassesBackground: RscText {
                    h = QUOTE(safeZoneH - POS_EDGE(6,5) * GUI_GRID_H);
                };
                class CreateFrame: RscFrame {
                    h = QUOTE(safeZoneH - POS_EDGE(6,5) * GUI_GRID_H);
                };
                class CreateSearch: RscEdit {
                    x = QUOTE(0.15 * GUI_GRID_W);
                    w = QUOTE(7.7 * GUI_GRID_W);
                };
                class CreateSearchButton: RscButtonSearch {
                    x = QUOTE(7.9 * GUI_GRID_W);
                };
                class CollapseAll: CreateSearchButton {
                    idc = IDC_COLLAPSE_ALL;
                    text = "\a3\3DEN\Data\Displays\Display3DEN\tree_collapse_ca.paa";
                    tooltip = "$STR_3DEN_ctrlButtonCollapseAll_text";
                    x = QUOTE(8.9 * GUI_GRID_W);
                };
                class ExpandAll: CollapseAll {
                    idc = IDC_EXPAND_ALL;
                    text = QPATHTOF(ui\tree_expand_ca.paa);
                    tooltip = "$STR_3DEN_ctrlButtonExpandAll_text";
                    x = QUOTE(9.9 * GUI_GRID_W);
                };
                class CreateUnitsWest: RscTree {
                    h = QUOTE(safeZoneH - POS_EDGE(8.1,7.1) * GUI_GRID_H);
                    class ScrollBar: ScrollBar {
                        thumb = "\a3\3DEN\Data\Controls\ctrlDefault\thumb_ca.paa";
                        border = "\a3\3DEN\Data\Controls\ctrlDefault\border_ca.paa";
                        arrowFull = "\a3\3DEN\Data\Controls\ctrlDefault\arrowFull_ca.paa";
                        arrowEmpty = "\a3\3DEN\Data\Controls\ctrlDefault\arrowEmpty_ca.paa";
                    };
                };
                class VehicleCrew: RscControlsGroupNoScrollbars {
                    x = 0;
                    y = QUOTE(safeZoneH - POS_EDGE(3,2) * GUI_GRID_H);
                    w = QUOTE(11 * GUI_GRID_W);
                    h = QUOTE(GUI_GRID_H);
                    class controls {
                        class Background: RscText {
                            x = 0;
                            y = 0;
                            w = QUOTE(11 * GUI_GRID_W);
                            h = QUOTE(GUI_GRID_H);
                            colorBackground[] = {0, 0, 0, 0.2};
                        };
                        class Line: RscLine {
                            x = 0;
                            y = QUOTE(pixelH);
                            w = QUOTE(11 * GUI_GRID_W);
                            h = 0;
                            colorText[] = {0, 0, 0, 1};
                        };
                        class Label: RscText {
                            text = "$STR_3DEN_Display3DEN_VehiclePanel_TextEmpty_text";
                            x = QUOTE(GUI_GRID_W);
                            y = 0;
                            w = QUOTE(10 * GUI_GRID_W);
                            h = QUOTE(GUI_GRID_H);
                            sizeEx = QUOTE(0.9 * GUI_GRID_H);
                            shadow = 0;
                        };
                        class Toggle: EGVAR(common,RscCheckbox) {
                            idc = IDC_INCLUDE_CREW;
                            onLoad = QUOTE((_this select 0) cbSetChecked GVAR(includeCrew));
                            onCheckedChanged = QUOTE(GVAR(includeCrew) = !GVAR(includeCrew));
                            x = QUOTE(0.1 * GUI_GRID_W);
                            y = 0;
                            w = QUOTE(GUI_GRID_W);
                            h = QUOTE(GUI_GRID_H);
                        };
                    };
                };
            };
        };
        class MissionBar: RscControlsGroupNoScrollbars {
            x = QUOTE(safeZoneX + POS_EDGE(1.5,0) * GUI_GRID_W);
            y = QUOTE(safeZoneY + POS_EDGE(0.5,0) * GUI_GRID_H);
        };
        class Mission: RscControlsGroupNoScrollbars {
            x = QUOTE(safeZoneX + POS_EDGE(1.5,0) * GUI_GRID_W);
            y = QUOTE(safeZoneY + POS_EDGE(1.5,1) * GUI_GRID_H);
            h = QUOTE(safeZoneH - POS_EDGE(2,1) * GUI_GRID_H);
            class controls {
                class EntitiesBackground: RscText {
                    h = QUOTE(safeZoneH - POS_EDGE(2,1) * GUI_GRID_H);
                };
                class EntitiesFrame: RscFrame {
                    h = QUOTE(safeZoneH - POS_EDGE(2,1) * GUI_GRID_H);
                };
                class Entities: RscTree {
                    h = QUOTE(safeZoneH - POS_EDGE(2,1) * GUI_GRID_H);
                    class ScrollBar: ScrollBar {
                        thumb = "\a3\3DEN\Data\Controls\ctrlDefault\thumb_ca.paa";
                        border = "\a3\3DEN\Data\Controls\ctrlDefault\border_ca.paa";
                        arrowFull = "\a3\3DEN\Data\Controls\ctrlDefault\arrowFull_ca.paa";
                        arrowEmpty = "\a3\3DEN\Data\Controls\ctrlDefault\arrowEmpty_ca.paa";
                    };
                };
            };
        };
    };
};
