class RscText;

class RscTitles {
    class GVAR(RscVisionModes) {
        idd = -1;
        fadeIn = 0;
        duration = 2;
        onLoad = QUOTE(_this call FUNC(showHint));
        class controls {
            class Mode_0: RscText {
                idc = IDC_MODE_0;
                style = ST_CENTER;
                x = 0;
                y = QUOTE(safeZoneY + POS_H(3.3));
                w = QUOTE(WIDTH_SINGLE);
                h = QUOTE(POS_H(0.9));
                sizeEx = QUOTE(POS_H(0.8));
                shadow = 0;
            };
            class Mode_1: Mode_0 {
                idc = IDC_MODE_1;
            };
            class Mode_2: Mode_0 {
                idc = IDC_MODE_2;
            };
            class Mode_3: Mode_0 {
                idc = IDC_MODE_3;
            };
            class Mode_4: Mode_0 {
                idc = IDC_MODE_4;
            };
            class Mode_5: Mode_0 {
                idc = IDC_MODE_5;
            };
            class Mode_6: Mode_0 {
                idc = IDC_MODE_6;
            };
            class Mode_7: Mode_0 {
                idc = IDC_MODE_7;
            };
            class Mode_8: Mode_0 {
                idc = IDC_MODE_8;
            };
            class Mode_9: Mode_0 {
                idc = IDC_MODE_9;
            };
        };
    };
};
