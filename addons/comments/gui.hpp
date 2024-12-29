class RscActivePicture;
class GVAR(RscActiveCommentIcon): RscActivePicture {
    onMouseEnter = QUOTE((_this select 0) setVariable [ARR_2(QQGVAR(isActive),true)]);
    onMouseExit = QUOTE((_this select 0) setVariable [ARR_2(QQGVAR(isActive),false)]);
    shadow = 1;
    text = COMMENT_ICON;
    tooltipMaxWidth = QUOTE(POS_W(15));
};
