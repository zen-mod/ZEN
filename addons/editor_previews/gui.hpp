class ctrlStatic;
class ctrlStaticPictureKeepAspect;
class ctrlControlsGroupNoScrollbars;

class GVAR(control): ctrlControlsGroupNoScrollbars {
    idc = IDC_PREVIEW_GROUP;
    x = 0;
    y = 0;
    w = 0;
    h = QUOTE(POS_H(IMAGE_HEIGHT + 2 * BORDER_SIZE));
    class controls {
        class Background: ctrlStatic {
            idc = -1;
            x = 0;
            y = 0;
            w = 1;
            h = 1;
            colorBackground[] = {0.1, 0.1, 0.1, 0.5};
        };
        class Image: ctrlStaticPictureKeepAspect {
            idc = IDC_PREVIEW_IMAGE;
            x = QUOTE(POS_W(BORDER_SIZE));
            y = QUOTE(POS_H(BORDER_SIZE));
            w = 0;
            h = QUOTE(POS_H(IMAGE_HEIGHT));
        };
    };
};
