class RscActivePicture;
class RscControlsGroupNoScrollbars;

class RscDisplayCurator {
    class Controls {
        class Add: RscControlsGroupNoScrollbars {
            class controls {
                class GVAR(modeIcons): RscActivePicture {
                    idc = IDC_MARKERS_MODE_ICONS;
                    text = "\a3\3den\data\displays\display3den\panelright\submode_marker_icon_ca.paa";
                    tooltip = "$STR_3DEN_Marker_Mode_Icon";
                    x = POS_W(7.4/3);
                    y = POS_H(2.1);
                    w = POS_W(1.8);
                    h = POS_H(1.8);
                };
                class GVAR(modeAreas): GVAR(modeIcons) {
                    idc = IDC_MARKERS_MODE_AREAS;
                    text = "\a3\3den\data\displays\display3den\panelright\submode_marker_area_ca.paa";
                    tooltip = "$STR_3DEN_Marker_Mode_Area";
                    x = POS_W(1.8 + 2 * 7.4/3);
                };
                class CreateUnitsWest;
                class CreateMarkers: CreateUnitsWest {
                    idcSearch = -1;
                    x = 0;
                    y = 0;
                    w = 0;
                    h = 0;
                };
                class GVAR(treeIcons): CreateUnitsWest {
                    idc = IDC_MARKERS_TREE_ICONS;
                    idcSearch = IDC_RSCDISPLAYCURATOR_CREATE_SEARCH;
                    colorPictureSelected[] = {1, 1, 1, 1};
                };
                class GVAR(treeAreas): GVAR(treeIcons) {
                    idc = IDC_MARKERS_TREE_AREAS;
                    colorPictureSelected[] = {0, 0, 0, 1};
                };
            };
        };
    };
};
