#define COMPONENT tour
#define COMPONENT_BEAUTIFIED Tour
#include "\x\zen\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_TOUR
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_TOUR
    #define DEBUG_SETTINGS DEBUG_SETTINGS_TOUR
#endif

#include "\x\zen\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineCommonColors.inc"
#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\a3\ui_f_curator\ui\defineResinclDesign.inc"

#define GITHUB_URL "https://github.com/zen-mod/ZEN"

#define POS_X(N) ((N) * GUI_GRID_W + GUI_GRID_CENTER_X)
#define POS_Y(N) ((N) * GUI_GRID_H + GUI_GRID_CENTER_Y)
#define POS_W(N) ((N) * GUI_GRID_W)
#define POS_H(N) ((N) * GUI_GRID_H)

#define IDD_DISPLAY                 87000

#define IDC_TITLE_TEXT              87010
#define IDC_BUTTON_CLOSE            87020
#define IDC_BUTTON_ALL_FEATURES     87030
#define IDC_SIDEBAR                 87040
#define IDC_PAGE                    87050

#define IDC_PICTURE_IMAGE           87100
#define IDC_PICTURE_DIM_TOP         87110
#define IDC_PICTURE_DIM_BOTTOM      87120
#define IDC_PICTURE_DIM_LEFT        87130
#define IDC_PICTURE_DIM_RIGHT       87140

#define IDC_COMPARISON_AFTER        87200
#define IDC_COMPARISON_CLIP         87210
#define IDC_COMPARISON_BEFORE       87220
#define IDC_COMPARISON_DIVIDER      87230
#define IDC_COMPARISON_HANDLE       87240
#define IDC_COMPARISON_LABEL_BEFORE 87250
#define IDC_COMPARISON_LABEL_AFTER  87260
#define IDC_COMPARISON_MOUSE        87270

#define IDC_SLIDESHOW_SLIDES        87300
#define IDC_SLIDESHOW_NEXT          87310
#define IDC_SLIDESHOW_CAPTION       87320

#define IDC_ENTRY_BACKGROUND        87400
#define IDC_ENTRY_ACCENT            87410
#define IDC_ENTRY_TITLE             87420
#define IDC_ENTRY_TAG               87430
#define IDC_ENTRY_MOUSE             87440

// Height of the sidebar and page below the title bar
#define CONTENT_HEIGHT 22.8

// Space above the first sidebar entry and the page's content, so that they line up
#define CONTENT_PADDING 1

// The width of scrollbars (from the common controls group)
#define SCROLLBAR_WIDTH 0.5

// Text controls have a hardcoded margin on each side, which is offset so that text lines up with other content
// Unlike the sizes above, this is in screen units
#define TEXT_MARGIN 0.008

// Rounds control edges to whole pixels, used for structural elements that border each other
// to prevent adjacent controls from leaving gaps at some interface sizes
#define PIXEL_PRECISION 2

// Sidebar and individual feature entries
#define SIDEBAR_WIDTH          9
#define SIDEBAR_INSET          0.6
#define SIDEBAR_GROUP_SPACING  0.8
#define SIDEBAR_HEADING_HEIGHT 1.2

#define ENTRY_HEIGHT           1.5
#define ENTRY_ACCENT_WIDTH     0.15
#define ENTRY_TAG_WIDTH        1.5
#define ENTRY_TAG_INSET        0.3

// Size of the GitHub button at the bottom of the sidebar
#define GITHUB_BUTTON_SIZE 1

// Space between the GitHub logo and the edges of the sidebar, including the clearspace around the logo in its image
#define GITHUB_BUTTON_INSET ((ENTRY_HEIGHT - GITHUB_BUTTON_SIZE) / 2 + GITHUB_BUTTON_SIZE * 0.125)

// Page, made of blocks for its media, header, and sections
#define PAGE_MARGIN          1
#define PAGE_HEADER_SPACING  1.2
#define PAGE_SECTION_SPACING 1.6
#define PAGE_BOTTOM_SPACING  2

// Header, with the feature's title and description (i.e., the lead)
#define HEADER_TITLE_HEIGHT 2.2
#define HEADER_LEAD_Y       2.4

// Sections, with a heading followed by their media and body
#define SECTION_HEADING_Y        0.9
#define SECTION_HEADING_HEIGHT   1.5
#define SECTION_CONTENT_Y        2.9
#define SECTION_MEDIA_SPACING    0.7
#define SECTION_COLUMN_SPACING   1
#define SECTION_SIDE_MEDIA_RATIO 0.45

// Callouts, inset into a box with an accent bar
#define CALLOUT_ACCENT_WIDTH 0.15
#define CALLOUT_PADDING      0.7
#define CALLOUT_LABEL_HEIGHT 0.9
#define CALLOUT_BODY_Y       1.1

// Body, with a section's text and list
#define BODY_PARAGRAPH_SPACING 0.7
#define BODY_ITEM_SPACING      0.5
#define BODY_MARKER_WIDTH      1.3
#define BODY_TERM_WIDTH        7.5

// Picture zoom, with the focus area filling the given fraction of the picture by default
#define ZOOM_FOCUS_SIZE 0.7
#define ZOOM_MAX        2.5

// Comparisons, with their divider split as a fraction of the width once animated
#define COMPARISON_SPLIT        0.5
#define COMPARISON_LABEL_MARGIN 0.5
#define COMPARISON_HANDLE_SIZE  1.3

// Slideshows, with a row of dots beside the caption
#define SLIDESHOW_CAPTION_SPACING 0.7
#define SLIDESHOW_CAPTION_HEIGHT  0.8
#define SLIDESHOW_CAPTION_GAP     1
#define SLIDESHOW_DOT_Y           0.35
#define SLIDESHOW_DOT_WIDTH       0.8
#define SLIDESHOW_DOT_HEIGHT      0.2
#define SLIDESHOW_DOT_SPACING     1.1

// Time to initially fade the display in
#define INITIAL_FADE_TIME 0.2

// Media animates after a delay once scrolled into view, holding between animations while looping
#define MEDIA_ANIMATION_DELAY    0.5
#define MEDIA_ANIMATION_DURATION 1.2
#define MEDIA_LOOP_HOLD          2.5

#define SLIDESHOW_INTERVAL      5
#define SLIDESHOW_FADE_DURATION 0.6

// Fraction of the visible page kept in view when scrolling by a page with the keyboard
#define PAGE_SCROLL_OVERLAP 0.1

// Animation states of media, which follow whether it is scrolled into view
#define MEDIA_STATE_HIDDEN   0
#define MEDIA_STATE_WAITING  1
#define MEDIA_STATE_ANIMATED 2
#define MEDIA_STATE_REVERSED 3
#define MEDIA_STATE_MANUAL   4
