class EGVAR(context_menu,actions) {
    class ADDON {
        displayName = CSTRING(CreateAreaMarker);
        icon = ICON_MARKERS;
        condition = QUOTE(visibleMap);
        statement = QUOTE([ARR_2(QQGVAR(create),[_contextPosASL])] call CBA_fnc_serverEvent);
        priority = -98;
    };
};
