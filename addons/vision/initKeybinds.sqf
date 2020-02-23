[ELSTRING(main,DisplayName), QGVAR(increaseNVGBrightness), LSTRING(IncreaseNVGBrightness), {
    if (isNull curatorCamera || {!ppEffectEnabled GVAR(ppBrightness)}) exitWith {false};

    [1] call FUNC(changeBrightness);
    true
}, {}, [DIK_PGUP, [false, false, true]]] call CBA_fnc_addKeybind; // Default: ALT + Page Up

[ELSTRING(main,DisplayName), QGVAR(decreaseNVGBrightness), LSTRING(DecreaseNVGBrightness), {
    if (isNull curatorCamera || {!ppEffectEnabled GVAR(ppBrightness)}) exitWith {false};

    [-1] call FUNC(changeBrightness);
    true
}, {}, [DIK_PGDN, [false, false, true]]] call CBA_fnc_addKeybind; // Default: ALT + Page Down
