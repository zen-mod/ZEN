class RscText;
class RscPicture;
class RscControlsGroupNoScrollbars;

class GVAR(icon): RscControlsGroupNoScrollbars {
    class controls {
        class Title: RscText {
            idc = IDC_ICON_TITLE;
            style = ST_CENTER;
            font = "RobotoCondensed";
            shadow = 0;
        };
        class Image: RscPicture {
            idc = IDC_ICON_IMAGE;
            text = COMMENT_ICON;
        };
        class Creator: Title {
            idc = IDC_ICON_CREATOR;
        };
    };
};

class RscDisplayCurator {
    class ControlsBackground {
        // The comment icons are created in a background container controls group
        // so that they are drawn behind the foreground interface elements
        class GVAR(container): RscControlsGroupNoScrollbars {
            idc = IDC_CONTAINER;
            x = QUOTE(safeZoneXAbs);
            y = QUOTE(safeZoneY);
            w = QUOTE(safeZoneWAbs);
            h = QUOTE(safeZoneH);
        };
        // Mouse handling for all comment icons is done using this one control which
        // is moved over the image of the comment under the cursor every frame
        // Putting this in the background controls automatically ensures that comments
        // do not receive mouse events when behind foreground interface elements
        class GVAR(mouse): RscText {
            idc = IDC_MOUSE;
            style = ST_MULTI;
            tooltipMaxWidth = QUOTE(POS_W(15));
            onMouseButtonDblClick = QUOTE(call FUNC(handleMouseButtonDblClick));
            onMouseButtonDown = QUOTE(call FUNC(handleMouseButtonDown));
            onMouseButtonUp = QUOTE(call FUNC(handleMouseButtonUp));
            onMouseZChanged = QUOTE(call FUNC(handleMouseZChanged));
            x = 0;
            y = 0;
            w = 0;
            h = 0;
        };
    };
};
