#define COMPONENT area_markers
#define COMPONENT_BEAUTIFIED Area Markers
#include "\x\zen\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_AREA_MARKERS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_AREA_MARKERS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_AREA_MARKERS
#endif

#include "\x\zen\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\x\zen\addons\common\defineResinclDesign.inc"

#define POS_X(N) ((N) * GUI_GRID_W + GUI_GRID_CENTER_X)
#define POS_Y(N) ((N) * GUI_GRID_H + GUI_GRID_CENTER_Y)
#define POS_W(N) ((N) * GUI_GRID_W)
#define POS_H(N) ((N) * GUI_GRID_H)

#define ICON_SIZE 0.6

#define ICON_WIDTH  POS_W(ICON_SIZE)
#define ICON_HEIGHT POS_H(ICON_SIZE)

#define OFFSET_X POS_W(ICON_SIZE / 2)
#define OFFSET_Y POS_H(ICON_SIZE / 2)

#define ICON_CENTER "\a3\3den\data\cfg3den\marker\texturecenter_ca.paa"
#define ICON_MARKERS "\a3\3den\data\displays\display3den\panelright\submode_marker_area_ca.paa"
#define ICON_ELLIPSE "\a3\3DEN\Data\Attributes\Shape\ellipse_ca.paa"
#define ICON_RECTANGLE "\a3\3DEN\Data\Attributes\Shape\rectangle_ca.paa"

#define IDC_ICON_GROUP 85800
#define IDC_ICON_IMAGE 85810
#define IDC_ICON_MOUSE 85820

#define IDC_CONFIGURE_GROUP 42870
#define IDC_CONFIGURE_SIZE_A 42871
#define IDC_CONFIGURE_SIZE_B 42872
#define IDC_CONFIGURE_ROTATION_SLIDER 42873
#define IDC_CONFIGURE_ROTATION_EDIT 42874
#define IDC_CONFIGURE_SHAPE 42875
#define IDC_CONFIGURE_BRUSH 42876
#define IDC_CONFIGURE_COLOR 42877
#define IDC_CONFIGURE_ALPHA_SLIDER 42878
#define IDC_CONFIGURE_ALPHA_EDIT 42879
#define IDC_CONFIGURE_OK 42880
#define IDC_CONFIGURE_CANCEL 42881

#define IDCS_CONFIGURE_EDIT_BOXES [IDC_CONFIGURE_SIZE_A, IDC_CONFIGURE_SIZE_B, IDC_CONFIGURE_ROTATION_EDIT, IDC_CONFIGURE_ALPHA_EDIT]
