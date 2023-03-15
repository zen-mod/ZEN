class EGVAR(context_menu,actions) {
    class ADDON {
        displayName = CSTRING(CreateAreaMarker);
        icon = ICON_MARKERS;
        condition = QUOTE(visibleMap);
        statement = QUOTE([ARR_2(QQGVAR(createMarker),[_position])] call CBA_fnc_serverEvent);
        priority = 100;
    };
};
