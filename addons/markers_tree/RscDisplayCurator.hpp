class RscControlsGroupNoScrollbars;

class RscDisplayCurator {
    class Controls {
        class Add: RscControlsGroupNoScrollbars {
            class controls {
                class CreateUnitsWest;
                class CreateMarkers: CreateUnitsWest {
                    idcSearch = -1;
                    x = 0;
                    y = 0;
                    w = 0;
                    h = 0;
                };
                class ADDON: CreateUnitsWest {
                    idc = IDC_MARKERS_TREE;
                    idcSearch = IDC_RSCDISPLAYCURATOR_CREATE_SEARCH;
                    colorPictureSelected[] = {1, 1, 1, 1};
                };
            };
        };
    };
};
