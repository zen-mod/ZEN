class EGVAR(context_menu,actions) {
    class GVAR(create) {
        displayName = "$STR_3DEN_Display3DEN_EntityMenu_CreateComment_text";
        icon = COMMENT_ICON;
        condition = QGVAR(enabled);
        statement = QUOTE([_position] call FUNC(openDialog));
        priority = 20;
    };
};
