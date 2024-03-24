[
    QGVAR(editableMarkers),
    "LIST",
    [LSTRING(EditableMarkers), LSTRING(EditableMarkers_Description)],
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    [
        [
            EDITABLE_MARKERS_ALL,
            EDITABLE_MARKERS_ONLY_ZEUS_CREATED
        ],
        [
            [LSTRING(AllMarkers), LSTRING(AllMarkers_Description)],
            [LSTRING(OnlyZeusCreated), LSTRING(OnlyZeusCreated_Description)]
        ],
        0
    ],
    true,
    {
        // Manually trigger event to update editability of all markers based on the setting
        // Also handles 3DEN placed and already existent (JIP) markers
        {
            _x call FUNC(onMarkerUpdated);
        } forEach allMapMarkers;
    }
] call CBA_fnc_addSetting;
