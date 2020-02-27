class RscText;
class RscPicture;
class ctrlXSliderH;
class RscButtonMenuOK;
class RscButtonMenuCancel;
class ctrlToolboxPictureKeepAspect;
class RscControlsGroupNoScrollbars;

class EGVAR(common,RscLabel);
class EGVAR(common,RscBackground);
class EGVAR(common,RscEdit);
class EGVAR(common,RscCombo);

class GVAR(icon): RscControlsGroupNoScrollbars {
    idc = IDC_ICON_GROUP;
    x = 0;
    y = 0;
    w = ICON_WIDTH;
    h = ICON_HEIGHT;
    class controls {
        class Icon: RscPicture {
            idc = IDC_ICON_IMAGE;
            text = ICON_CENTER;
            x = 0;
            y = 0;
            w = ICON_WIDTH;
            h = ICON_HEIGHT;
        };
        class Mouse: RscText {
            idc = IDC_ICON_MOUSE;
            style = ST_MULTI;
            onMouseButtonDblClick = QUOTE(call FUNC(onMouseDblClick));
            onMouseButtonDown = QUOTE(call FUNC(onMouseButtonDown));
            onMouseButtonUp = QUOTE(call FUNC(onMouseButtonUp));
            onMouseMoving = QUOTE(call FUNC(onMouseMoving));
            x = 0;
            y = 0;
            w = ICON_WIDTH;
            h = ICON_HEIGHT;
        };
    };
};

class GVAR(configure): RscControlsGroupNoScrollbars {
    idc = IDC_CONFIGURE_GROUP;
    x = safeZoneXAbs;
    y = safeZoneY;
    w = safeZoneWAbs;
    h = safeZoneH;
    class controls {
        class Container: RscControlsGroupNoScrollbars {
            idc = -1;
            x = safeZoneWAbs / 2 - POS_W(13.5);
            y = safeZoneH / 2 - POS_H(6.5);
            w = POS_W(27);
            h = POS_H(13);
            class controls {
                class Title: RscText {
                    text = CSTRING(EditAreaMarker);
                    x = 0;
                    y = 0;
                    w = POS_W(27);
                    h = POS_H(1);
                    colorBackground[] = GUI_THEME_COLOR;
                };
                class Background: RscText {
                    idc = -1;
                    x = 0;
                    y = POS_H(1.1);
                    w = POS_W(27);
                    h = POS_H(10.8);
                    colorBackground[] = {0, 0, 0, 0.7};
                };
                class Transformation: RscControlsGroupNoScrollbars {
                    idc = -1;
                    x = POS_W(0.5);
                    y = POS_H(1.6);
                    w = POS_W(26);
                    h = POS_H(3.3);
                    class controls {
                        class Title: EGVAR(common,RscLabel) {
                            text = "$STR_3DEN_Object_AttributeCategory_Transformation";
                            w = POS_W(26);
                        };
                        class Background: EGVAR(common,RscBackground) {
                            x = 0;
                            y = POS_H(1);
                            w = POS_W(26);
                            h = POS_H(2.3);
                        };
                        class SizeLabel: EGVAR(common,RscLabel) {
                            text = "$STR_3DEN_Trigger_Attribute_Size_displayName";
                            tooltip = "$STR_3DEN_Trigger_Attribute_Size_tooltip";
                            x = POS_W(3);
                            y = POS_H(1.1);
                            w = POS_W(8.9);
                            colorBackground[] = {0, 0, 0, 0.7};
                        };
                        class IconA: RscText {
                            idc = -1;
                            style = ST_CENTER;
                            text = "$STR_3DEN_Axis_A";
                            x = POS_W(12);
                            y = POS_H(1.1);
                            w = POS_W(1);
                            h = POS_H(1);
                            font = "RobotoCondensedLight";
                            colorBackground[] = {0.77, 0.18, 0.1, 1};
                            shadow = 0;
                        };
                        class EditA: EGVAR(common,RscEdit) {
                            idc = IDC_CONFIGURE_SIZE_A;
                            x = POS_W(13.1);
                            y = POS_H(1.1) + pixelH;
                            w = POS_W(4.35);
                            h = POS_H(1) - pixelH;
                            colorBackground[] = {0, 0, 0, 0.4};
                        };
                        class IconB: IconA {
                            text = "$STR_3DEN_Axis_B";
                            x = POS_W(17.55);
                            colorBackground[] = {0.58, 0.82, 0.22, 1};
                        };
                        class EditB: EditA {
                            idc = IDC_CONFIGURE_SIZE_B;
                            x = POS_W(18.65);
                        };
                        class RotationLabel: SizeLabel {
                            text = "$STR_3DEN_Object_Attribute_Rotation_displayName";
                            tooltip = "";
                            y = POS_H(2.2);
                        };
                        class RotationSlider: ctrlXSliderH {
                            idc = IDC_CONFIGURE_ROTATION_SLIDER;
                            x = POS_W(12);
                            y = POS_H(2.2);
                            w = POS_W(8.7);
                            h = POS_H(1);
                        };
                        class RotationEdit: EGVAR(common,RscEdit) {
                            idc = IDC_CONFIGURE_ROTATION_EDIT;
                            x = POS_W(20.8);
                            y = POS_H(2.2) + pixelH;
                            w = POS_W(2.2);
                            colorBackground[] = {0, 0, 0, 0.4};
                        };
                    };
                };
                class Style: RscControlsGroupNoScrollbars {
                    idc = -1;
                    x = POS_W(0.5);
                    y = POS_H(5);
                    w = POS_W(26);
                    h = POS_H(6.5);
                    class controls {
                        class Title: EGVAR(common,RscLabel) {
                            text = "$STR_3DEN_Marker_AttributeCategory_Style";
                            w = POS_W(26);
                        };
                        class Background: EGVAR(common,RscBackground) {
                            x = 0;
                            y = POS_H(1);
                            w = POS_W(26);
                            h = POS_H(5.5);
                        };
                        class ShapeLabel: EGVAR(common,RscLabel) {
                            text = "$STR_3DEN_Trigger_Attribute_Shape_displayName";
                            tooltip = "$STR_3DEN_Trigger_Attribute_Shape_tooltip";
                            x = POS_W(3);
                            y = POS_H(1.1);
                            w = POS_W(8.9);
                            h = POS_H(2);
                            colorBackground[] = {0, 0, 0, 0.7};
                        };
                        class Shape: ctrlToolboxPictureKeepAspect {
                            idc = IDC_CONFIGURE_SHAPE;
                            x = POS_W(12);
                            y = POS_H(1.1);
                            w = POS_W(11);
                            h = POS_H(2);
                            colorBackground[] = {0, 0, 0, 0.7};
                            rows = 1;
                            columns = 2;
                            strings[] = {
                                "\a3\3DEN\Data\Attributes\Shape\rectangle_ca.paa",
                                "\a3\3DEN\Data\Attributes\Shape\ellipse_ca.paa"
                            };
                            tooltips[] = {
                                "$STR_3den_attributes_shapetrigger_rectangle",
                                "$STR_3den_attributes_shapetrigger_ellipse"
                            };
                        };
                        class BrushLabel: ShapeLabel {
                            text = "$STR_3DEN_Marker_Attribute_Brush_displayName";
                            tooltip = "$STR_3DEN_Marker_Attribute_Brush_tooltip";
                            y = POS_H(3.2);
                            h = POS_H(1);
                        };
                        class Brush: EGVAR(common,RscCombo) {
                            idc = IDC_CONFIGURE_BRUSH;
                            x = POS_W(12);
                            y = POS_H(3.2);
                            w = POS_W(11);
                        };
                        class ColorLabel: BrushLabel {
                            text = "$STR_3DEN_Marker_Attribute_Color_displayName";
                            tooltip = "$STR_3DEN_Marker_Attribute_Color_tooltip";
                            y = POS_H(4.3);
                        };
                        class Color: Brush {
                            idc = IDC_CONFIGURE_COLOR;
                            y = POS_H(4.3);
                        };
                        class AlphaLabel: BrushLabel {
                            text = "$STR_3DEN_Marker_Attribute_Alpha_displayName";
                            tooltip = "";
                            y = POS_H(5.4);
                        };
                        class AlphaSlider: ctrlXSliderH {
                            idc = IDC_CONFIGURE_ALPHA_SLIDER;
                            x = POS_W(12);
                            y = POS_H(5.4);
                            w = POS_W(8.7);
                            h = POS_H(1);
                        };
                        class AlphaEdit: EGVAR(common,RscEdit) {
                            idc = IDC_CONFIGURE_ALPHA_EDIT;
                            x = POS_W(20.8);
                            y = POS_H(5.4) + pixelH;
                            w = POS_W(2.2);
                            colorBackground[] = {0, 0, 0, 0.4};
                        };
                    };
                };
                class ButtonOK: RscButtonMenuOK {
                    idc = IDC_CONFIGURE_OK;
                    x = POS_W(22);
                    y = POS_H(12);
                    w = POS_W(5);
                    h = POS_H(1);
                };
                class ButtonCancel: RscButtonMenuCancel {
                    idc = IDC_CONFIGURE_CANCEL;
                    x = 0;
                    y = POS_H(12);
                    w = POS_W(5);
                    h = POS_H(1);
                };
            };
        };
    };
};
