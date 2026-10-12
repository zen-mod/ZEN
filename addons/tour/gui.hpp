class RscText;
class RscPicture;
class RscStructuredText;
class RscDisplayEmpty;
class RscControlsGroupNoScrollbars;
class ctrlButton;
class ctrlButtonPictureKeepAspect;

class EGVAR(common,RscControlsGroup);

// Opened by the pause menu option, which can only open displays by class name
class GVAR(pauseMenuHelper): RscDisplayEmpty {
    onLoad = QUOTE(call FUNC(handlePauseMenu));
};

class GVAR(title): RscText {
    font = "RobotoCondensedBold";
    sizeEx = QUOTE(POS_H(2));
    shadow = 0;
};

class GVAR(heading): RscText {
    font = "RobotoCondensedBold";
    sizeEx = QUOTE(POS_H(1.3));
    shadow = 0;
};

class GVAR(text): RscStructuredText {
    size = QUOTE(POS_H(0.9));
    class Attributes {
        font = "RobotoCondensed";
        color = "#c8c8c8";
        align = "left";
        shadow = 0;
    };
};

class GVAR(lead): GVAR(text) {
    size = QUOTE(POS_H(1.1));
    class Attributes: Attributes {
        font = "RobotoCondensedLight";
        color = "#ebebeb";
    };
};

class GVAR(label): RscText {
    font = "RobotoCondensedBold";
    sizeEx = QUOTE(POS_H(0.8));
    colorText[] = {1, 1, 1, 0.5};
    shadow = 0;
};

// A picture with dims that spotlight its focus area
class GVAR(picture): RscControlsGroupNoScrollbars {
    class controls {
        class Picture: RscPicture {
            idc = IDC_PICTURE_IMAGE;
        };
        class DimTop: RscText {
            idc = IDC_PICTURE_DIM_TOP;
            colorBackground[] = {0, 0, 0, 0.55};
        };
        class DimBottom: DimTop {
            idc = IDC_PICTURE_DIM_BOTTOM;
        };
        class DimLeft: DimTop {
            idc = IDC_PICTURE_DIM_LEFT;
        };
        class DimRight: DimTop {
            idc = IDC_PICTURE_DIM_RIGHT;
        };
    };
};

// Two pictures split by a divider that can be dragged to compare them, with the "before" picture on the left
class GVAR(comparison): RscControlsGroupNoScrollbars {
    class controls {
        class After: RscPicture {
            idc = IDC_COMPARISON_AFTER;
        };
        class LabelAfter: RscText {
            idc = IDC_COMPARISON_LABEL_AFTER;
            style = ST_RIGHT;
            text = CSTRING(After);
            font = "RobotoCondensedBold";
            sizeEx = QUOTE(POS_H(0.8));
            colorText[] = {1, 1, 1, 0.9};
            shadow = 2;
        };
        class Clip: RscControlsGroupNoScrollbars {
            idc = IDC_COMPARISON_CLIP;
            class controls {
                class Before: RscPicture {
                    idc = IDC_COMPARISON_BEFORE;
                };
                class LabelBefore: LabelAfter {
                    idc = IDC_COMPARISON_LABEL_BEFORE;
                    style = ST_LEFT;
                    text = CSTRING(Before);
                };
            };
        };
        class Divider: RscText {
            idc = IDC_COMPARISON_DIVIDER;
            colorBackground[] = {1, 1, 1, 1};
        };
        class Handle: RscPicture {
            idc = IDC_COMPARISON_HANDLE;
            text = QPATHTOF(ui\icons\compare_ca.paa);
        };
        class Mouse: RscText {
            idc = IDC_COMPARISON_MOUSE;
            style = ST_MULTI;
            onMouseButtonDown = QUOTE([ARR_2(_this select 0,true)] call FUNC(handleComparisonDrag));
            onMouseButtonUp = QUOTE([ARR_2(_this select 0,false)] call FUNC(handleComparisonDrag));
            onMouseExit = QUOTE([ARR_2(_this select 0,false)] call FUNC(handleComparisonDrag));
            onMouseMoving = QUOTE([_this select 0] call FUNC(handleComparisonDrag));
        };
    };
};

// Slideshow with pictures shown one at a time, with a caption and dots below them
// Slides are created in their own group, which keeps them below the area clicked to show the next slide
class GVAR(slideshowMouse): RscText {
    style = ST_MULTI;
    onMouseButtonDown = QUOTE(call FUNC(handleSlideClick));
};

class GVAR(slideshow): RscControlsGroupNoScrollbars {
    class controls {
        class Slides: RscControlsGroupNoScrollbars {
            idc = IDC_SLIDESHOW_SLIDES;
        };
        class Next: GVAR(slideshowMouse) {
            idc = IDC_SLIDESHOW_NEXT;
        };
        class Caption: GVAR(text) {
            idc = IDC_SLIDESHOW_CAPTION;
            size = QUOTE(POS_H(0.8));
            class Attributes: Attributes {
                color = "#969696";
            };
        };
    };
};

class GVAR(entry): RscControlsGroupNoScrollbars {
    class controls {
        class Background: RscText {
            idc = IDC_ENTRY_BACKGROUND;
            x = 0;
            y = 0;
            w = QUOTE(POS_W(SIDEBAR_WIDTH));
            h = QUOTE(POS_H(ENTRY_HEIGHT));
        };
        class Accent: RscText {
            idc = IDC_ENTRY_ACCENT;
            x = 0;
            y = 0;
            w = QUOTE(POS_W(ENTRY_ACCENT_WIDTH));
            h = QUOTE(POS_H(ENTRY_HEIGHT));
            colorBackground[] = {GUI_BCG_RGB, 1};
        };
        class Title: RscText {
            idc = IDC_ENTRY_TITLE;
            x = QUOTE(POS_W(SIDEBAR_INSET));
            y = 0;
            w = QUOTE(POS_W(SIDEBAR_WIDTH - 2 * SIDEBAR_INSET));
            h = QUOTE(POS_H(ENTRY_HEIGHT));
            sizeEx = QUOTE(POS_H(1));
            shadow = 0;
        };
        class Tag: RscText {
            idc = IDC_ENTRY_TAG;
            style = ST_RIGHT;
            text = CSTRING(New);
            x = QUOTE(POS_W(SIDEBAR_WIDTH - ENTRY_TAG_WIDTH - ENTRY_TAG_INSET));
            y = 0;
            w = QUOTE(POS_W(ENTRY_TAG_WIDTH));
            h = QUOTE(POS_H(ENTRY_HEIGHT));
            font = "RobotoCondensedBold";
            sizeEx = QUOTE(POS_H(0.65));
            colorText[] = {GUI_BCG_RGB, 1};
            shadow = 0;
        };
        class Mouse: RscText {
            idc = IDC_ENTRY_MOUSE;
            style = ST_MULTI;
            x = 0;
            y = 0;
            w = QUOTE(POS_W(SIDEBAR_WIDTH));
            h = QUOTE(POS_H(ENTRY_HEIGHT));
            onMouseButtonDown = QUOTE(call FUNC(handleEntryClick));
            onMouseEnter = QUOTE([ARR_2(_this select 0,true)] call FUNC(handleEntryHover));
            onMouseExit = QUOTE([ARR_2(_this select 0,false)] call FUNC(handleEntryHover));
        };
    };
};

class GVAR(display) {
    idd = IDD_DISPLAY;
    movingEnable = 0;
    onLoad = QUOTE(call FUNC(handleLoad));
    onKeyDown = QUOTE(call FUNC(handleKeyDown));
    class ControlsBackground {
        class Dim: RscText {
            idc = -1;
            x = QUOTE(safeZoneXAbs);
            y = QUOTE(safeZoneY);
            w = QUOTE(safeZoneWAbs);
            h = QUOTE(safeZoneH);
            colorBackground[] = {0, 0, 0, 0.6};
        };
    };
    class controls {
        class TitleBar: RscText {
            idc = -1;
            x = QUOTE(POS_X(3));
            y = QUOTE(POS_Y(0.5));
            w = QUOTE(POS_W(34));
            h = QUOTE(POS_H(1.2));
            colorBackground[] = GUI_BCG_COLOR;
        };
        class Title: RscText {
            idc = IDC_TITLE_TEXT;
            x = QUOTE(POS_X(3.2));
            y = QUOTE(POS_Y(0.5));
            w = QUOTE(POS_W(31));
            h = QUOTE(POS_H(1.2));
            sizeEx = QUOTE(POS_H(1.05));
            shadow = 0;
        };
        class ButtonClose: ctrlButtonPictureKeepAspect {
            idc = IDC_BUTTON_CLOSE;
            text = "\a3\3DEN\Data\Displays\Display3DEN\search_end_ca.paa";
            tooltip = "$STR_DISP_CLOSE";
            x = QUOTE(POS_X(37 - 1.2));
            y = QUOTE(POS_Y(0.5));
            w = QUOTE(POS_W(1.2));
            h = QUOTE(POS_H(1.2));
            colorBackground[] = {0, 0, 0, 0};
            colorBackgroundActive[] = {0.77, 0.17, 0.11, 1};
            colorFocused[] = {0, 0, 0, 0};
            onButtonClick = QUOTE(ctrlParent (_this select 0) closeDisplay IDC_CANCEL);
        };
        class SidebarBackground: RscText {
            idc = -1;
            x = QUOTE(POS_X(3));
            y = QUOTE(POS_Y(1.7));
            w = QUOTE(POS_W(SIDEBAR_WIDTH));
            h = QUOTE(POS_H(CONTENT_HEIGHT));
            colorBackground[] = {0.1, 0.1, 0.1, 0.95};
        };
        class ButtonAllFeatures: ctrlButton {
            idc = IDC_BUTTON_ALL_FEATURES;
            style = ST_LEFT;
            x = QUOTE(POS_X(3 + GITHUB_BUTTON_INSET) - TEXT_MARGIN);
            y = QUOTE(POS_Y(1.7 + CONTENT_HEIGHT - ENTRY_HEIGHT));
            w = QUOTE(POS_W(SIDEBAR_WIDTH - GITHUB_BUTTON_INSET - ENTRY_HEIGHT));
            h = QUOTE(POS_H(ENTRY_HEIGHT));
            font = "RobotoCondensedBold";
            sizeEx = QUOTE(POS_H(0.8));
            colorText[] = {1, 1, 1, 0.5};
            colorBackground[] = {0, 0, 0, 0};
            colorBackgroundActive[] = {0, 0, 0, 0};
            colorFocused[] = {0, 0, 0, 0};
            onButtonClick = QUOTE(call FUNC(handleViewAllClick));
            onMouseEnter = QUOTE((_this select 0) ctrlSetTextColor [ARR_4(1,1,1,1)]);
            onMouseExit = QUOTE((_this select 0) ctrlSetTextColor [ARR_4(1,1,1,0.5)]);
        };
        class ButtonGitHub: ctrlButtonPictureKeepAspect {
            idc = -1;
            text = QPATHTOF(ui\icons\github_ca.paa);
            tooltip = CSTRING(GitHub);
            url = GITHUB_URL;
            x = QUOTE(POS_X(3 + SIDEBAR_WIDTH - (ENTRY_HEIGHT + GITHUB_BUTTON_SIZE) / 2));
            y = QUOTE(POS_Y(1.7 + CONTENT_HEIGHT - (ENTRY_HEIGHT + GITHUB_BUTTON_SIZE) / 2));
            w = QUOTE(POS_W(GITHUB_BUTTON_SIZE));
            h = QUOTE(POS_H(GITHUB_BUTTON_SIZE));
            colorText[] = {1, 1, 1, 0.5};
            colorBackground[] = {0, 0, 0, 0};
            colorBackgroundActive[] = {0, 0, 0, 0};
            colorFocused[] = {0, 0, 0, 0};
            onMouseEnter = QUOTE((_this select 0) ctrlSetTextColor [ARR_4(1,1,1,1)]);
            onMouseExit = QUOTE((_this select 0) ctrlSetTextColor [ARR_4(1,1,1,0.5)]);
        };
        class PageBackground: SidebarBackground {
            x = QUOTE(POS_X(3 + SIDEBAR_WIDTH));
            w = QUOTE(POS_W(34 - SIDEBAR_WIDTH));
            colorBackground[] = {0.05, 0.05, 0.05, 0.95};
        };
        class Sidebar: EGVAR(common,RscControlsGroup) {
            idc = IDC_SIDEBAR;
            x = QUOTE(POS_X(3));
            y = QUOTE(POS_Y(1.7));
            w = QUOTE(POS_W(SIDEBAR_WIDTH));
            h = QUOTE(POS_H(CONTENT_HEIGHT - ENTRY_HEIGHT));
        };
        class Page: Sidebar {
            idc = IDC_PAGE;
            x = QUOTE(POS_X(3 + SIDEBAR_WIDTH));
            w = QUOTE(POS_W(34 - SIDEBAR_WIDTH));
            h = QUOTE(POS_H(CONTENT_HEIGHT));
        };
    };
};
