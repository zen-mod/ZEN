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
                class CreateSearch: RscEdit {
                    x = 0.15 * GUI_GRID_W;
                    w = 7.7 * GUI_GRID_W;
                };
                class CreateSearchButton: RscButtonSearch {
                    x = 7.9 * GUI_GRID_W;
                };
                class CollapseAll: CreateSearchButton {
                    idc = IDC_COLLAPSE_ALL;
                    text = "\a3\3DEN\Data\Displays\Display3DEN\tree_collapse_ca.paa";
                    tooltip = "$STR_3DEN_ctrlButtonCollapseAll_text";
                    x = 8.9 * GUI_GRID_W;
                    onButtonClick = QUOTE(false call FUNC(handleTreeButtons));
                };
                class ExpandAll: CollapseAll {
                    idc = IDC_EXPAND_ALL;
                    text = QPATHTOF(ui\tree_expand_ca.paa);
                    tooltip = "$STR_3DEN_ctrlButtonExpandAll_text";
                    x = 9.9 * GUI_GRID_W;
                    onButtonClick = QUOTE(true call FUNC(handleTreeButtons));
                };
                class CreateUnitsWest: RscTree {
                    h = safeZoneH - POS_EDGE(8.1,7.1) * GUI_GRID_H;
                    class ScrollBar: ScrollBar {
                        thumb = "\a3\3DEN\Data\Controls\ctrlDefault\thumb_ca.paa";
                        border = "\a3\3DEN\Data\Controls\ctrlDefault\border_ca.paa";
                        arrowFull = "\a3\3DEN\Data\Controls\ctrlDefault\arrowFull_ca.paa";
                        arrowEmpty = "\a3\3DEN\Data\Controls\ctrlDefault\arrowEmpty_ca.paa";
                    };
                };
                class VehicleCrew: RscControlsGroupNoScrollbars {
                    x = 0;
                    y = safeZoneH - POS_EDGE(3,2) * GUI_GRID_H;
                    w = 11 * GUI_GRID_W;
                    h = GUI_GRID_H;
                    class controls {
                        class Background: RscText {
                            x = 0;
                            y = 0;
                            w = 11 * GUI_GRID_W;
                            h = GUI_GRID_H;
                            colorBackground[] = {0, 0, 0, 0.2};
                        };
                        class Line: RscLine {
                            x = 0;
                            y = pixelH;
                            w = 11 * GUI_GRID_W;
                            h = 0;
                            colorText[] = {0, 0, 0, 1};
                        };
                        class Label: RscText {
                            text = "$STR_3DEN_Display3DEN_VehiclePanel_TextEmpty_text";
                            x = GUI_GRID_W;
                            y = 0;
                            w = 10 * GUI_GRID_W;
                            h = GUI_GRID_H;
                            sizeEx = 0.9 * GUI_GRID_H;
                            shadow = 0;
                        };
                        class Toggle: EGVAR(common,RscCheckbox) {
                            idc = IDC_INCLUDE_CREW;
                            onLoad = QUOTE((_this select 0) cbSetChecked GVAR(includeCrew));
                            onCheckedChanged = QUOTE(GVAR(includeCrew) = !GVAR(includeCrew));
                            x = 0.1 * GUI_GRID_W;
                            y = 0;
                            w = GUI_GRID_W;
                            h = GUI_GRID_H;
                        };
                    };
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
