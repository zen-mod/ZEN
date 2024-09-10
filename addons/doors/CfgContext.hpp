class EGVAR(context_menu,actions) {
    class GVAR(state) {
        displayName = CSTRING(DoorState);
        icon = ICON_DOOR;
        insertChildren = QUOTE(call FUNC(getActions));
        priority = 100;
    };
};
