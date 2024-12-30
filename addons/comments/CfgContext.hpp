class EGVAR(context_menu,actions) {
    class GVAR(createComment) {
        displayName = STR_CREATE_COMMENT;
        icon = COMMENT_ICON;
        statement = QUOTE([_position] call FUNC(createCommentDialog));
        priority = 35;
    };
};
