class ctrlStatic;
class ctrlStaticPictureKeepAspect;
class ctrlControlsGroupNoScrollbars;

class GVAR(control): ctrlControlsGroupNoScrollbars {
    idc = IDC_PREVIEW_GROUP;
    x = safeZoneX + safeZoneW - POS_EDGE(12.5,11) * GUI_GRID_W - POS_W(9.8);
    y = 0;
    w = POS_W(9.6);
    h = POS_H(5.4);
    class controls {
        class Background: ctrlStatic {
            idc = -1;
            x = 0;
            y = 0;
            w = POS_W(9.6);
            h = POS_H(5.4);
            colorBackground[] = {0.1, 0.1, 0.1, 0.5};
        };
        class Image: ctrlStaticPictureKeepAspect {
            idc = IDC_PREVIEW_IMAGE;
            x = POS_W(0.1);
            y = POS_H(0.1);
            w = POS_W(9.4);
            h = POS_H(5.2);
        };
    };
};
