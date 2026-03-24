class RscActivePicture;
class GVAR(RscActiveCommentIcon): RscActivePicture {
    onMouseEnter = QUOTE((_this select 0) setVariable [ARR_2(QQGVAR(isActive),true)]; ctrlSetFocus (_this select 0)); // Set focus for KeyDown to register
    onMouseExit = QUOTE((_this select 0) setVariable [ARR_2(QQGVAR(isActive),false)]);

    // For deleting comments
    onKeyDown = QUOTE(call FUNC(onKeyDown));

    // For editing comments
    onMouseButtonDblClick = QUOTE(call FUNC(onMouseDblClick));

    // For moving comments
    onMouseButtonDown = QUOTE(call FUNC(onMouseButtonDown));
    onMouseButtonUp = QUOTE(call FUNC(onMouseButtonUp));
    onMouseMoving = QUOTE(call FUNC(onMouseMoving));

    shadow = 1;
    text = COMMENT_ICON;
    tooltipMaxWidth = QUOTE(POS_W(15));
};
