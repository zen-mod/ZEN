[ELSTRING(main,DisplayName), QGVAR(open), [LSTRING(OpenAttributesDisplay), LSTRING(OpenAttributesDisplay_Description)], {
    if (!isNull curatorCamera && {!dialog && {!GETMVAR(RscDisplayCurator_search,false)}}) then {
        [] call EFUNC(attributes,openForSelection);
    };
}, {}, [DIK_GRAVE, [false, false, false]]] call CBA_fnc_addKeybind; // Default: GRAVE
