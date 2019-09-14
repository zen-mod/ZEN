[
    "Object",
    "STR_A3_Arsenal",
    {_entity call EFUNC(common,openArsenal)},
    {alive _entity && {_entity isKindOf "CAManBase"}},
    true
] call FUNC(addButton);

[
    "Object",
    LSTRING(Skills),
    {[_entity, "Skills"] call FUNC(open)},
    {alive _entity && {_entity isKindOf "CAManBase"}}
] call FUNC(addButton);

[
    "Object",
    LSTRING(Traits),
    {[_entity, "Traits"] call FUNC(open)},
    {alive _entity && {_entity isKindOf "CAManBase"}}
] call FUNC(addButton);

[
    "Object",
    LSTRING(Sensors),
    {[_entity, "Sensors"] call FUNC(open)},
    {alive _entity && {_entity isKindOf "LandVehicle" || {_entity isKindOf "Air"} || {_entity isKindOf "Ship"}}}
] call FUNC(addButton);

[
    "Group",
    ELSTRING(common,Side),
    {[_entity, "Side"] call FUNC(open)}
] call FUNC(addButton);
