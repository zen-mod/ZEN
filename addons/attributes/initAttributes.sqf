// - Object -------------------------------------------------------------------

[
    "Object",
    "STR_3DEN_Object_Attribute_UnitName_displayName",
    QGVAR(edit),
    nil,
    {
        [QEGVAR(common,setName), [_entity, _value]] call CBA_fnc_globalEvent;

        if (isClass (configFile >> "CfgPatches" >> "ace_common")) then {
            [_entity] call ace_common_fnc_setName;
        };
    },
    {name _entity},
    {alive _entity && {_entity isKindOf "CAManBase"}},
    -89
] call FUNC(addAttribute);

[
    "Object",
    "STR_3DEN_Object_Attribute_Skill_displayName",
    QGVAR(slider),
    [0.2, 1, 0.1, true],
    {
        {
            [QEGVAR(common,setSkill), [_x, _value], _x] call CBA_fnc_targetEvent;
        } forEach (_entity call FUNC(getEntities));
    },
    {skill _entity},
    {alive _entity && {!isNull group _entity && {side _entity != sideLogic}}},
    -90
] call FUNC(addAttribute);

[
    "Object",
    "STR_3DEN_Object_Attribute_Health_displayName",
    QGVAR(slider),
    [0, 1, 0.1, true],
    {
        private _damage = 1 - _value;
        {
            _x setDamage _damage;
        } forEach SELECTED_OBJECTS;
    },
    {1 - damage _entity},
    {alive _entity},
    -91
] call FUNC(addAttribute);

[
    "Object",
    "STR_3DEN_Object_Attribute_Fuel_displayName",
    QGVAR(slider),
    [0, 1, 0.1, true],
    {
        {
            [QEGVAR(common,setFuel), [_x, _value], _x] call CBA_fnc_targetEvent;
        } forEach (_entity call FUNC(getEntities));
    },
    {fuel _entity},
    {alive _entity && {getNumber (configFile >> "CfgVehicles" >> typeOf _entity >> "fuelCapacity") > 0}},
    -92
] call FUNC(addAttribute);

[
    "Object",
    "STR_3DEN_Object_Attribute_Ammo_displayName",
    QGVAR(slider),
    [0, 1, 0.1, true],
    {
        {
            [_x, _value] call EFUNC(common,setVehicleAmmo);
        } forEach (_entity call FUNC(getEntities));
    },
    {_entity call EFUNC(common,getVehicleAmmo)},
    {alive _entity && {!(_entity isKindOf "CAManBase")} && {_entity call EFUNC(common,getVehicleAmmo) != -1}},
    -93
] call FUNC(addAttribute);

[
    "Object",
    "STR_3DEN_Object_Attribute_Rank_displayName",
    QGVAR(icons),
    [[
        ["\a3\Ui_f\data\GUI\Cfg\Ranks\private_gs.paa",    "STR_Private",    11.25, 0.5, 1.5],
        ["\a3\Ui_f\data\GUI\Cfg\Ranks\corporal_gs.paa",   "STR_Corporal",   13.25, 0.5, 1.5],
        ["\a3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa",   "STR_Sergeant",   15.25, 0.5, 1.5],
        ["\a3\Ui_f\data\GUI\Cfg\Ranks\lieutenant_gs.paa", "STR_Lieutenant", 17.25, 0.5, 1.5],
        ["\a3\Ui_f\data\GUI\Cfg\Ranks\captain_gs.paa",    "STR_Captain",    19.25, 0.5, 1.5],
        ["\a3\Ui_f\data\GUI\Cfg\Ranks\major_gs.paa",      "STR_Major",      21.25, 0.5, 1.5],
        ["\a3\Ui_f\data\GUI\Cfg\Ranks\colonel_gs.paa",    "STR_Colonel",    23.25, 0.5, 1.5]
    ]],
    {
        private _rank = RANKS select _value;
        {
            _x setUnitRank _rank;
        } forEach ([_entity, false] call FUNC(getEntities));
    },
    {RANKS find toUpper rank _entity},
    {alive _entity && {_entity isKindOf "CAManBase"}},
    -94
] call FUNC(addAttribute);

[
    "Object",
    "STR_A3_RscAttributeUnitPos_Title",
    QGVAR(icons),
    [[
        ["\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_prone_ca.paa",  "STR_A3_RscAttributeUnitPos_Down_tooltip",   13.25, 0, 2.5],
        ["\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_crouch_ca.paa", "STR_A3_RscAttributeUnitPos_Crouch_tooltip", 15.75, 0, 2.5],
        ["\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_stand_ca.paa",  "STR_A3_RscAttributeUnitPos_Up_tooltip",     18.25, 0, 2.5],
        ["\a3\ui_f_curator\Data\default_ca.paa",                        "STR_A3_RscAttributeUnitPos_Auto_tooltip",   24,  0.5, 1.5]
    ]],
    {
        private _stance = STANCES select _value;
        {
            [QEGVAR(common,setUnitPos), [_x, _stance], _x] call CBA_fnc_targetEvent;
        } forEach (_entity call FUNC(getEntities));
    },
    {STANCES find toUpper unitPos _entity},
    {alive _entity && {_entity isKindOf "CAManBase"}},
    -95
] call FUNC(addAttribute);

[
    "Object",
    "STR_3DEN_Object_Attribute_Lock_displayName",
    QGVAR(combo),
    [
        [0, "STR_3DEN_Attributes_Lock_Unlocked_text",        "STR_3DEN_Attributes_Lock_Unlocked_tooltip"],
        [1, "STR_3DEN_Attributes_Lock_Default_text",         "STR_3DEN_Attributes_Lock_Default_tooltip"],
        [2, "STR_3DEN_Attributes_Lock_Locked_text",          "STR_3DEN_Attributes_Lock_Locked_tooltip"],
        [3, "STR_3DEN_Attributes_Lock_LockedForPlayer_text", "STR_3DEN_Attributes_Lock_LockedForPlayer_tooltip"]
    ],
    {
        {
            [QEGVAR(common,lock), [_x, _value], _x] call CBA_fnc_targetEvent;
        } forEach (_entity call FUNC(getEntities));
    },
    {locked _entity},
    {alive _entity && {_entity isKindOf "LandVehicle" || {_entity isKindOf "Air"} || {_entity isKindOf "Ship"}}},
    -96
] call FUNC(addAttribute);

[
    "Object",
    LSTRING(Engine),
    QGVAR(icons),
    [[
        [QPATHTOF(ui\engine_on_ca.paa),  LSTRING(TurnOn),  14.5, 0.25, 2],
        [QPATHTOF(ui\engine_off_ca.paa), LSTRING(TurnOff), 19.5, 0.25, 2]
    ]],
    {
        private _state = _value == 0;
        {
            [QEGVAR(common,engineOn), [_x, _state], _x] call CBA_fnc_targetEvent;
        } forEach (_entity call FUNC(getEntities));
    },
    {parseNumber !isEngineOn _entity},
    {alive _entity && {_entity isKindOf "LandVehicle" || {_entity isKindOf "Air"} || {_entity isKindOf "Ship"}}},
    -97
] call FUNC(addAttribute);

[
    "Object",
    LSTRING(Lights),
    QGVAR(icons),
    [[
        [QPATHTOF(ui\lights_on_ca.paa),  LSTRING(TurnOn),  14.5, 0.25, 2],
        [QPATHTOF(ui\lights_off_ca.paa), LSTRING(TurnOff), 19.5, 0.25, 2]
    ]],
    {
        private _state = _value == 0;
        {
            [QEGVAR(common,setPilotLight), [_x, _state], _x] call CBA_fnc_targetEvent;
            [QEGVAR(common,setCollisionLight), [_x, _state], _x] call CBA_fnc_targetEvent;

            // Prevent AI from switching forced lights state
            private _driver = driver _x;

            if !(isNull _driver || {isPlayer _driver}) then {
                [QEGVAR(common,disableAI), [_x, "LIGHTS"], _x] call CBA_fnc_targetEvent;
            };
        } forEach (_entity call FUNC(getEntities));
    },
    {parseNumber !isLightOn _entity},
    {alive _entity && {_entity isKindOf "LandVehicle" || {_entity isKindOf "Air"} || {_entity isKindOf "Ship"}}},
    -98
] call FUNC(addAttribute);

[
    "Object",
    LSTRING(PlateNumber),
    QGVAR(edit),
    {_this select [0, MAX_PLATE_CHARACTERS]},
    {
        [QEGVAR(common,setPlateNumber), [_entity, _value], _entity] call CBA_fnc_targetEvent;
    },
    {getPlateNumber _entity},
    {alive _entity && {isClass (configFile >> "CfgVehicles" >> typeOf _entity >> "PlateInfos")}},
    -99
] call FUNC(addAttribute);

[
    "Object",
    "STR_a3_rscdebugconsole_expressiontext",
    QGVAR(code),
    [QGVAR(objectExecHistory), 20, LSTRING(Exec_TooltipObject)],
    {
        [QEGVAR(common,execute), [compile _value, _entity], _entity] call CBA_fnc_targetEvent;
    },
    {},
    {IS_ADMIN || {!GETMVAR(ZEN_disableCodeExecution,false)}},
    -100
] call FUNC(addAttribute);

// - Group --------------------------------------------------------------------

[
    "Group",
    "STR_A3_RscAttributeGroupID_Title",
    QGVAR(edit),
    nil,
    {_entity setGroupIdGlobal [_value]},
    {groupID _entity},
    {true},
    -92
] call FUNC(addAttribute);

[
    "Group",
    "STR_3DEN_Object_Attribute_Skill_displayName",
    QGVAR(slider),
    [0.2, 1, 0.1, true],
    {
        {
            [QEGVAR(common,setSkill), [_x, _value], _x] call CBA_fnc_targetEvent;
        } forEach (_entity call FUNC(getEntities));
    },
    {skill leader _entity},
    {true},
    -94
] call FUNC(addAttribute);

[
    "Group",
    "STR_3DEN_Group_Attribute_Formation_displayName",
    QGVAR(icons),
    [[
        ["\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\wedge_ca.paa",       "STR_Wedge",     11.75,   0, 2.5],
        ["\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\vee_ca.paa",         "STR_Vee",       14.25,   0, 2.5],
        ["\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\line_ca.paa",        "STR_Line",      16.75,   0, 2.5],
        ["\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\column_ca.paa",      "STR_Column",    19.25,   0, 2.5],
        ["\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\file_ca.paa",        "STR_File",      21.75,   0, 2.5],
        ["\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\stag_column_ca.paa", "STR_Staggered", 11.75, 2.5, 2.5],
        ["\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\ech_left_ca.paa",    "STR_Echl",      14.25, 2.5, 2.5],
        ["\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\ech_right_ca.paa",   "STR_Echr",      16.75, 2.5, 2.5],
        ["\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\diamond_ca.paa",     "STR_Diamond",   19.25, 2.5, 2.5]
    ], 2],
    {
        private _formation = FORMATIONS select _value;
        {
            [QEGVAR(common,setFormation), [_x, _formation], _x] call CBA_fnc_targetEvent;
        } forEach SELECTED_GROUPS;
    },
    {FORMATIONS find toUpper formation _entity},
    {true},
    -95
] call FUNC(addAttribute);

[
    "Group",
    "STR_3DEN_Group_Attribute_Behaviour_displayName",
    QGVAR(icons),
    [[
        [QPATHTOF(ui\careless_ca.paa), "STR_3DEN_Attributes_Behaviour_Careless_text", 12.25, 0.5, 1.5],
        ["\a3\Ui_F_Curator\Data\RscCommon\RscAttributeBehaviour\safe_ca.paa",    "STR_Safe",    14.75, 0.5, 1.5, [0, 1, 0]],
        ["\a3\Ui_F_Curator\Data\RscCommon\RscAttributeBehaviour\aware_ca.paa",   "STR_Aware",   17.25, 0.5, 1.5, [1, 1, 0]],
        ["\a3\Ui_F_Curator\Data\RscCommon\RscAttributeBehaviour\combat_ca.paa",  "STR_Combat",  19.75, 0.5, 1.5, [1, 0, 0]],
        ["\a3\Ui_F_Curator\Data\RscCommon\RscAttributeBehaviour\stealth_ca.paa", "STR_Stealth", 22.25, 0.5, 1.5, [0, 1, 1]]
    ]],
    {
        private _behaviour = BEHAVIOURS select _value;
        {
            [QEGVAR(common,setBehaviour), [_x, _behaviour], _x] call CBA_fnc_targetEvent;
        } forEach SELECTED_GROUPS;
    },
    {BEHAVIOURS find toUpper behaviour leader _entity},
    {true},
    -96
] call FUNC(addAttribute);

[
    "Group",
    "STR_3DEN_Group_Attribute_CombatMode_displayName",
    QGVAR(icons),
    [[
        [QPATHTOF(ui\hold_ca.paa),   "STR_3DEN_Attributes_CombatMode_Blue_text",   12.25, 0.5, 1.5, [1, 0, 0]],
        [QPATHTOF(ui\defend_ca.paa), "STR_3DEN_Attributes_CombatMode_Green_text",  14.75, 0.5, 1.5, [1, 0, 0]],
        [QPATHTOF(ui\engage_ca.paa), "STR_3DEN_Attributes_CombatMode_White_text",  17.25, 0.5, 1.5, [1, 0, 0]],
        [QPATHTOF(ui\hold_ca.paa),   "STR_3DEN_Attributes_CombatMode_Yellow_text", 19.75, 0.5, 1.5],
        [QPATHTOF(ui\engage_ca.paa), "STR_3DEN_Attributes_CombatMode_Red_text",    22.25, 0.5, 1.5]
    ]],
    {
        private _combatMode = COMBATMODES select _value;
        {
            [QEGVAR(common,setCombatMode), [_x, _combatMode], _x] call CBA_fnc_targetEvent;
        } forEach SELECTED_GROUPS;
    },
    {COMBATMODES find toUpper combatMode _entity},
    {true},
    -97
] call FUNC(addAttribute);

[
    "Group",
    "STR_HC_Menu_Speed",
    QGVAR(icons),
    [[
        ["\a3\Ui_F_Curator\Data\RscCommon\RscAttributeSpeedMode\limited_ca.paa", "STR_Speed_Limited", 14.25, 0, 2.5],
        ["\a3\Ui_F_Curator\Data\RscCommon\RscAttributeSpeedMode\normal_ca.paa",  "STR_Speed_Normal",  16.75, 0, 2.5],
        ["\a3\Ui_F_Curator\Data\RscCommon\RscAttributeSpeedMode\full_ca.paa",    "STR_Speed_Full",    19.25, 0, 2.5]
    ]],
    {
        private _speedMode = SPEEDMODES select _value;
        {
            [QEGVAR(common,setSpeedMode), [_x, _speedMode], _x] call CBA_fnc_targetEvent;
        } forEach SELECTED_GROUPS;
    },
    {SPEEDMODES find toUpper speedMode _entity},
    {true},
    -98
] call FUNC(addAttribute);

[
    "Group",
    "STR_A3_RscAttributeUnitPos_Title",
    QGVAR(icons),
    [[
        ["\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_prone_ca.paa",  "STR_A3_RscAttributeUnitPos_Down_tooltip",   14.25, 0, 2.5],
        ["\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_crouch_ca.paa", "STR_A3_RscAttributeUnitPos_Crouch_tooltip", 16.75, 0, 2.5],
        ["\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_stand_ca.paa",  "STR_A3_RscAttributeUnitPos_Up_tooltip",     19.25, 0, 2.5],
        ["\a3\ui_f_curator\Data\default_ca.paa",                        "STR_A3_RscAttributeUnitPos_Auto_tooltip",   24,  0.5, 1.5]
    ]],
    {
        private _stance = STANCES select _value;
        {
            [QEGVAR(common,setUnitPos), [_x, _stance], _x] call CBA_fnc_targetEvent;
        } forEach (_entity call FUNC(getEntities));
    },
    {STANCES find toUpper unitPos leader _entity},
    {true},
    -99
] call FUNC(addAttribute);

[
    "Group",
    "STR_a3_rscdebugconsole_expressiontext",
    QGVAR(code),
    [QGVAR(groupExecHistory), 20, LSTRING(Exec_TooltipGroup)],
    {
        [QEGVAR(common,execute), [compile _value, _entity], _entity] call CBA_fnc_targetEvent;
    },
    {},
    {IS_ADMIN || {!GETMVAR(ZEN_disableCodeExecution,false)}},
    -100
] call FUNC(addAttribute);

// - Waypoint -----------------------------------------------------------------

[
    "Waypoint",
    "STR_3DEN_Object_Attribute_Type_displayName",
    QGVAR(waypoint),
    nil,
    {
        _value params ["_type", ["_script", ""]];
        {
            _x setWaypointType _type;
            if (_type == "SCRIPTED") then {_x setWaypointScript _script};
        } forEach SELECTED_WAYPOINTS;
    },
    {},
    {true},
    -95
] call FUNC(addAttribute);

[
    "Waypoint",
    [LSTRING(Timeout), LSTRING(Timeout_Tooltip)],
    QGVAR(slider),
    [0, 1800, 15],
    {_entity setWaypointTimeout [_value, _value, _value]},
    {random waypointTimeout _entity},
    {true},
    -96
] call FUNC(addAttribute);

[
    "Waypoint",
    "STR_3DEN_Group_Attribute_Formation_displayName",
    QGVAR(icons),
    [[
        ["\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\wedge_ca.paa",       "STR_Wedge",     11.75,   0, 2.5],
        ["\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\vee_ca.paa",         "STR_Vee",       14.25,   0, 2.5],
        ["\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\line_ca.paa",        "STR_Line",      16.75,   0, 2.5],
        ["\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\column_ca.paa",      "STR_Column",    19.25,   0, 2.5],
        ["\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\file_ca.paa",        "STR_File",      21.75,   0, 2.5],
        ["\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\stag_column_ca.paa", "STR_Staggered", 11.75, 2.5, 2.5],
        ["\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\ech_left_ca.paa",    "STR_Echl",      14.25, 2.5, 2.5],
        ["\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\ech_right_ca.paa",   "STR_Echr",      16.75, 2.5, 2.5],
        ["\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\diamond_ca.paa",     "STR_Diamond",   19.25, 2.5, 2.5],
        ["\a3\ui_f_curator\Data\default_ca.paa",                                     "STR_No_Change", 22.25,   3, 1.5]
    ], 2],
    {
        private _formation = FORMATIONS select _value;
        {
            _x params ["_group", "_waypointID"];

            if (currentWaypoint _group == _waypointID && {_formation != "NO CHANGE"}) then {
                [QEGVAR(common,setFormation), [_group, _formation], _group] call CBA_fnc_targetEvent;
            };

            [QEGVAR(common,setWaypointFormation), [_x, _formation]] call CBA_fnc_serverEvent;
        } forEach SELECTED_WAYPOINTS;
    },
    {FORMATIONS find toUpper waypointFormation _entity},
    {true},
    -97
] call FUNC(addAttribute);

[
    "Waypoint",
    "STR_3DEN_Group_Attribute_Behaviour_displayName",
    QGVAR(icons),
    [[
        [QPATHTOF(ui\careless_ca.paa), "STR_3DEN_Attributes_Behaviour_Careless_text", 11.25, 0.5, 1.5],
        ["\a3\Ui_F_Curator\Data\RscCommon\RscAttributeBehaviour\safe_ca.paa",    "STR_Safe",    13.75, 0.5, 1.5, [0, 1, 0]],
        ["\a3\Ui_F_Curator\Data\RscCommon\RscAttributeBehaviour\aware_ca.paa",   "STR_Aware",   16.25, 0.5, 1.5, [1, 1, 0]],
        ["\a3\Ui_F_Curator\Data\RscCommon\RscAttributeBehaviour\combat_ca.paa",  "STR_Combat",  18.75, 0.5, 1.5, [1, 0, 0]],
        ["\a3\Ui_F_Curator\Data\RscCommon\RscAttributeBehaviour\stealth_ca.paa", "STR_Stealth", 21.25, 0.5, 1.5, [0, 1, 1]],
        ["\a3\ui_f_curator\Data\default_ca.paa", "STR_Combat_Unchanged", 24, 0.5, 1.5]
    ]],
    {
        private _behaviour = BEHAVIOURS select _value;
        {
            _x params ["_group", "_waypointID"];

            if (currentWaypoint _group == _waypointID && {_behaviour != "UNCHANGED"}) then {
                [QEGVAR(common,setBehaviour), [_group, _behaviour], _group] call CBA_fnc_targetEvent;
            };

            [QEGVAR(common,setWaypointBehaviour), [_x, _behaviour]] call CBA_fnc_serverEvent;
        } forEach SELECTED_WAYPOINTS;
    },
    {BEHAVIOURS find toUpper waypointBehaviour _entity},
    {true},
    -98
] call FUNC(addAttribute);

[
    "Waypoint",
    "STR_3DEN_Group_Attribute_CombatMode_displayName",
    QGVAR(icons),
    [[
        [QPATHTOF(ui\hold_ca.paa),   "STR_3DEN_Attributes_CombatMode_Blue_text",   11.25, 0.5, 1.5, [1, 0, 0]],
        [QPATHTOF(ui\defend_ca.paa), "STR_3DEN_Attributes_CombatMode_Green_text",  13.75, 0.5, 1.5, [1, 0, 0]],
        [QPATHTOF(ui\engage_ca.paa), "STR_3DEN_Attributes_CombatMode_White_text",  16.25, 0.5, 1.5, [1, 0, 0]],
        [QPATHTOF(ui\hold_ca.paa),   "STR_3DEN_Attributes_CombatMode_Yellow_text", 18.75, 0.5, 1.5],
        [QPATHTOF(ui\engage_ca.paa), "STR_3DEN_Attributes_CombatMode_Red_text",    21.25, 0.5, 1.5],
        ["\a3\ui_f_curator\Data\default_ca.paa", "STR_Combat_Unchanged", 24, 0.5, 1.5]
    ]],
    {
        private _combatMode = COMBATMODES select _value;
        {
            _x params ["_group", "_waypointID"];

            if (currentWaypoint _group == _waypointID && {_combatMode != "NO CHANGE"}) then {
                [QEGVAR(common,setCombatMode), [_group, _combatMode], _group] call CBA_fnc_targetEvent;
            };

            [QEGVAR(common,setWaypointCombatMode), [_x, _combatMode]] call CBA_fnc_serverEvent;
        } forEach SELECTED_WAYPOINTS;
    },
    {COMBATMODES find toUpper waypointCombatMode _entity},
    {true},
    -99
] call FUNC(addAttribute);

[
    "Waypoint",
    "STR_HC_Menu_Speed",
    QGVAR(icons),
    [[
        ["\a3\Ui_F_Curator\Data\RscCommon\RscAttributeSpeedMode\limited_ca.paa", "STR_Speed_Limited", 13.25, 0, 2.5],
        ["\a3\Ui_F_Curator\Data\RscCommon\RscAttributeSpeedMode\normal_ca.paa",  "STR_Speed_Normal",  15.75, 0, 2.5],
        ["\a3\Ui_F_Curator\Data\RscCommon\RscAttributeSpeedMode\full_ca.paa",    "STR_Speed_Full",    18.25, 0, 2.5],
        ["\a3\ui_f_curator\Data\default_ca.paa", "STR_Speed_Unchanged", 24, 0.5, 1.5]
    ]],
    {
        private _speedMode = SPEEDMODES select _value;
        {
            _x params ["_group", "_waypointID"];

            if (currentWaypoint _group == _waypointID && {_speedMode != "UNCHANGED"}) then {
                [QEGVAR(common,setSpeedMode), [_group, _speedMode], _group] call CBA_fnc_targetEvent;
            };

            [QEGVAR(common,setWaypointSpeed), [_x, _speedMode]] call CBA_fnc_serverEvent;
        } forEach SELECTED_WAYPOINTS;
    },
    {SPEEDMODES find toUpper waypointSpeed _entity},
    {true},
    -100
] call FUNC(addAttribute);

// - Marker -------------------------------------------------------------------

[
    "Marker",
    "STR_3DEN_Marker_Attribute_Text_displayName",
    QGVAR(edit),
    nil,
    {_entity setMarkerText _value},
    {markerText _entity},
    {true},
    -98
] call FUNC(addAttribute);

[
    "Marker",
    "STR_3DEN_Marker_Attribute_Alpha_displayName",
    QGVAR(slider),
    [0, 1, 0.1, true],
    {_entity setMarkerAlpha _value},
    {markerAlpha _entity},
    {true},
    -99
] call FUNC(addAttribute);

private _markerColors = [];

{
    if (getNumber (_x >> "scope") > 0) then {
        _markerColors pushBack [
            configName _x,
            getText (_x >> "name"),
            "",
            ["#(argb,8,8,3)color(1,1,1,1)", (_x >> "color") call BIS_fnc_colorConfigToRGBA]
        ];
    };
} forEach configProperties [configFile >> "CfgMarkerColors", "isClass _x"];

[
    "Marker",
    "STR_3DEN_Marker_Attribute_Color_displayName",
    QGVAR(combo),
    _markerColors,
    {
        _entity setMarkerColor _value;

        // Apply this color to new markers of this type
        GVAR(markerColors) setVariable [markerType _entity, _color];
    },
    {markerColor _entity},
    {true},
    -100
] call FUNC(addAttribute);

// - Skills -------------------------------------------------------------------

/* {
    _x params ["_skill", "_displayName"];

    [
        "Skills",
        LSTRING(AimingAccuracy),
        QGVAR(slider),
        [0, 1, 0.1, true],
        {},
        {
            if (_entity isEqualType grpNull) then {
                _entity = leader _entity;
            };
        }
    ] call FUNC(addAttribute);
} forEach [
    ["aimingAccuracy", LSTRING(AimingAccuracy)]
    ["aimingSpeed",    LSTRING(AimingSpeed)]
    ["aimingShake",    LSTRING(AimingShake)]
    ["commanding",     LSTRING(Commanding)]
    ["courage",        LSTRING(Courage)]
    ["spotDistance",   LSTRING(SpotDistance)]
    ["spotTime",       LSTRING(SpotTime)]
    ["reloadSpeed",    LSTRING(ReloadSpeed)]
];

[
    "Skills",
    LSTRING(AimingAccuracy),
    QGVAR(slider),
    [0, 1, 0.1, true],
    {},
    {
        if (_entity isEqualType grpNull) then {
            _entity = leader _entity;
        };
    }
] call FUNC(addAttribute); */
