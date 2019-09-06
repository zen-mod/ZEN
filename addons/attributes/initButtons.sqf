// - Object -------------------------------------------------------------------

[
    "Object",
    "STR_A3_Arsenal",
    {_entity call EFUNC(common,openArsenal)},
    {alive _entity && {_entity isKindOf "CAManBase"}},
    true
] call FUNC(addButton);

[
    "Object",
    LSTRING(Traits),
    {[_entity, "Traits"] call FUNC(open)},
    {alive _entity && {_entity isKindOf "CAManBase"}}
] call FUNC(addButton);
