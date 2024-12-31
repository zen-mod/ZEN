class EGVAR(context_menu,actions) {
    class GVAR(createComment) {
        displayName = STR_CREATE_COMMENT;
        icon = COMMENT_ICON;
        condition = QGVAR(enabled);
        statement = QUOTE([_position] call FUNC(createCommentDialog));
        priority = 35;
    };
};
