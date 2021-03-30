// - Object -------------------------------------------------------------------

["Object", "", true] call FUNC(addDisplay);

[
    "Object",
    "STR_A3_Arsenal",
    {_entity call EFUNC(common,openArsenal)},
    {alive _entity && {_entity isKindOf "CAManBase"}},
    true
] call FUNC(addButton);

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
    {alive _entity && {_entity isKindOf "CAManBase"}}
] call FUNC(addAttribute);

[
    "Object",
    "STR_3DEN_Object_Attribute_Skill_displayName",
    QGVAR(slider),
    [0.2, 1, 0.1, true],
    {
        {
            [QEGVAR(common,setSkill), [_x, _value], _x] call CBA_fnc_targetEvent;
        } forEach call EFUNC(common,getSelectedUnits);
    },
    {skill _entity},
    {alive _entity && {!isNull group _entity && {side _entity != sideLogic}}}
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
    {alive _entity}
] call FUNC(addAttribute);

[
    "Object",
    "STR_3DEN_Object_Attribute_Fuel_displayName",
    QGVAR(slider),
    [0, 1, 0.1, true],
    {
        {
            [QEGVAR(common,setFuel), [_x, _value], _x] call CBA_fnc_targetEvent;
        } forEach call EFUNC(common,getSelectedVehicles);
    },
    {fuel _entity},
    {alive _entity && {getNumber (configOf _entity >> "fuelCapacity") > 0}}
] call FUNC(addAttribute);

[
    "Object",
    "STR_3DEN_Object_Attribute_Ammo_displayName",
    QGVAR(slider),
    [0, 1, 0.1, true],
    {
        {
            [_x, _value] call EFUNC(common,setVehicleAmmo);
        } forEach call EFUNC(common,getSelectedVehicles);
    },
    {_entity call EFUNC(common,getVehicleAmmo)},
    {alive _entity && {_entity call EFUNC(common,getVehicleAmmo) != -1}}
] call FUNC(addAttribute);

[
    "Object",
    "STR_3DEN_Object_Attribute_Rank_displayName",
    QGVAR(icons),
    [[
        ["PRIVATE",    "\a3\Ui_f\data\GUI\Cfg\Ranks\private_gs.paa",    "STR_Private",    11.25, 0.5, 1.5],
        ["CORPORAL",   "\a3\Ui_f\data\GUI\Cfg\Ranks\corporal_gs.paa",   "STR_Corporal",   13.25, 0.5, 1.5],
        ["SERGEANT",   "\a3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa",   "STR_Sergeant",   15.25, 0.5, 1.5],
        ["LIEUTENANT", "\a3\Ui_f\data\GUI\Cfg\Ranks\lieutenant_gs.paa", "STR_Lieutenant", 17.25, 0.5, 1.5],
        ["CAPTAIN",    "\a3\Ui_f\data\GUI\Cfg\Ranks\captain_gs.paa",    "STR_Captain",    19.25, 0.5, 1.5],
        ["MAJOR",      "\a3\Ui_f\data\GUI\Cfg\Ranks\major_gs.paa",      "STR_Major",      21.25, 0.5, 1.5],
        ["COLONEL",    "\a3\Ui_f\data\GUI\Cfg\Ranks\colonel_gs.paa",    "STR_Colonel",    23.25, 0.5, 1.5]
    ]],
    {
        {
            _x setUnitRank _value;
        } forEach call EFUNC(common,getSelectedUnits);
    },
    {rank _entity},
    {alive _entity && {_entity isKindOf "CAManBase"}}
] call FUNC(addAttribute);

[
    "Object",
    "STR_A3_RscAttributeUnitPos_Title",
    QGVAR(icons),
    [[
        ["DOWN",   "\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_prone_ca.paa",  "STR_A3_RscAttributeUnitPos_Down_tooltip",   13.25, 0, 2.5],
        ["MIDDLE", "\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_crouch_ca.paa", "STR_A3_RscAttributeUnitPos_Crouch_tooltip", 15.75, 0, 2.5],
        ["UP",     "\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_stand_ca.paa",  "STR_A3_RscAttributeUnitPos_Up_tooltip",     18.25, 0, 2.5],
        ["AUTO",   "\a3\ui_f_curator\Data\default_ca.paa",                        "STR_A3_RscAttributeUnitPos_Auto_tooltip",   24,  0.5, 1.5]
    ]],
    {
        {
            [QEGVAR(common,setUnitPos), [_x, _value], _x] call CBA_fnc_targetEvent;
        } forEach call EFUNC(common,getSelectedUnits);
    },
    {toUpper unitPos _entity},
    {alive _entity && {_entity isKindOf "CAManBase"}}
] call FUNC(addAttribute);

[
    "Object",
    "STR_3DEN_Object_Attribute_Lock_displayName",
    QGVAR(combo),
    [[
        [0, ["STR_3DEN_Attributes_Lock_Unlocked_text", "STR_3DEN_Attributes_Lock_Unlocked_tooltip"], "\a3\modules_f\data\iconunlock_ca.paa"],
        [1, ["STR_3DEN_Attributes_Lock_Default_text", "STR_3DEN_Attributes_Lock_Default_tooltip"], "\a3\ui_f_curator\Data\default_ca.paa"],
        [2, ["STR_3DEN_Attributes_Lock_Locked_text", "STR_3DEN_Attributes_Lock_Locked_tooltip"], "\a3\modules_f\data\iconlock_ca.paa"],
        [3, [LSTRING(LockedForPlayers), "STR_3DEN_Attributes_Lock_LockedForPlayer_tooltip"], ["\a3\modules_f\data\iconlock_ca.paa", [0.7, 0.1, 0, 1]]]
    ]],
    {
        {
            [QEGVAR(common,lock), [_x, _value], _x] call CBA_fnc_targetEvent;
        } forEach call EFUNC(common,getSelectedVehicles);
    },
    {locked _entity},
    {alive _entity && {_entity isKindOf "LandVehicle" || {_entity isKindOf "Air"} || {_entity isKindOf "Ship"}}}
] call FUNC(addAttribute);

[
    "Object",
    LSTRING(Engine),
    QGVAR(icons),
    [[
        [false, QPATHTOF(ui\engine_off_ca.paa), ELSTRING(common,Off), 14.5, 0.25, 2],
        [true,  QPATHTOF(ui\engine_on_ca.paa),  ELSTRING(common,On),  19.5, 0.25, 2]
    ]],
    {
        {
            [QEGVAR(common,engineOn), [_x, _value], _x] call CBA_fnc_targetEvent;
        } forEach call EFUNC(common,getSelectedVehicles);
    },
    {isEngineOn _entity},
    {alive _entity && {_entity isKindOf "LandVehicle" || {_entity isKindOf "Air"} || {_entity isKindOf "Ship"}}}
] call FUNC(addAttribute);

[
    "Object",
    LSTRING(Lights),
    QGVAR(icons),
    [[
        [false, QPATHTOF(ui\lights_off_ca.paa), ELSTRING(common,Off), 14.5, 0.25, 2],
        [true,  QPATHTOF(ui\lights_on_ca.paa),  ELSTRING(common,On),  19.5, 0.25, 2]
    ]],
    {
        {
            [QEGVAR(common,setPilotLight), [_x, _value], _x] call CBA_fnc_targetEvent;
            [QEGVAR(common,setCollisionLight), [_x, _value], _x] call CBA_fnc_targetEvent;

            // Prevent AI from switching forced lights state
            private _driver = driver _x;

            if !(isNull _driver || {isPlayer _driver}) then {
                [QEGVAR(common,disableAI), [_x, "LIGHTS"], _x] call CBA_fnc_targetEvent;
            };
        } forEach call EFUNC(common,getSelectedVehicles);
    },
    {isLightOn _entity},
    {alive _entity && {_entity isKindOf "LandVehicle" || {_entity isKindOf "Air"} || {_entity isKindOf "Ship"}}}
] call FUNC(addAttribute);

[
    "Object",
    LSTRING(PlateNumber),
    QGVAR(edit),
    [{_this select [0, MAX_PLATE_CHARACTERS]}],
    {
        [QEGVAR(common,setPlateNumber), [_entity, _value], _entity] call CBA_fnc_targetEvent;
    },
    {getPlateNumber _entity},
    {alive _entity && {isClass (configOf _entity >> "PlateInfos")}}
] call FUNC(addAttribute);

[
    "Object",
    [LSTRING(RespawnPosition), LSTRING(RespawnPosition_Tooltip)],
    QGVAR(icons),
    [[
        [
            west, "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeRespawnPosition\west_ca.paa", "STR_West", 11.5, 0.25, 2, west call BIS_fnc_sideColor,
            {playableSlotsNumber west > 0 && {[west, _entity call BIS_fnc_objectSide] call BIS_fnc_areFriendly}}
        ],
        [
            east, "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeRespawnPosition\east_ca.paa", "STR_East", 14.5, 0.25, 2, east call BIS_fnc_sideColor,
            {playableSlotsNumber east > 0 && {[east, _entity call BIS_fnc_objectSide] call BIS_fnc_areFriendly}}
        ],
        [
            independent, "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeRespawnPosition\guer_ca.paa", "STR_Guerrila", 17.5, 0.25, 2, independent call BIS_fnc_sideColor,
            {playableSlotsNumber independent > 0 && {[independent, _entity call BIS_fnc_objectSide] call BIS_fnc_areFriendly}}
        ],
        [
            civilian, "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeRespawnPosition\civ_ca.paa", "STR_Civilian", 20.5, 0.25, 2, civilian call BIS_fnc_sideColor,
            {playableSlotsNumber civilian > 0 && {[civilian, _entity call BIS_fnc_objectSide] call BIS_fnc_areFriendly}}
        ],
        [
            sideEmpty, "\a3\Ui_F_Curator\Data\default_ca.paa", "STR_sensoractiv_none", 24, 0.5, 1.5
        ]
    ]],
    {
        private _respawnPos = _entity getVariable [QGVAR(respawnPos), []];
        _respawnPos call BIS_fnc_removeRespawnPosition;

        if (_value isEqualTo sideEmpty) then {
            _entity setVariable [QGVAR(respawnPos), nil, true];
        } else {
            _respawnPos = [_value, _entity] call BIS_fnc_addRespawnPosition;
            _entity setVariable [QGVAR(respawnPos), _respawnPos, true];
        };
    },
    {
        _entity getVariable [QGVAR(respawnPos), []] param [0, sideEmpty]
    },
    {alive _entity && {canMove _entity} && {_entity isKindOf "AllVehicles"} && {!(_entity isKindOf "Animal")}}
] call FUNC(addAttribute);

[
    "Object",
    [LSTRING(RespawnVehicle), LSTRING(RespawnVehicle_Tooltip)],
    QGVAR(icons),
    [[
        [
            4, "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeRespawnVehicle\west_ca.paa", "STR_A3_RscAttributeRespawnVehicle_West_tooltip", 11.5, 0.25, 2, west call BIS_fnc_sideColor,
            {playableSlotsNumber west > 0 && {[west, _entity call BIS_fnc_objectSide] call BIS_fnc_areFriendly}}
        ],
        [
            3, "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeRespawnVehicle\east_ca.paa", "STR_A3_RscAttributeRespawnVehicle_East_tooltip", 14, 0.25, 2, east call BIS_fnc_sideColor,
            {playableSlotsNumber east > 0 && {[east, _entity call BIS_fnc_objectSide] call BIS_fnc_areFriendly}}
        ],
        [
            5, "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeRespawnVehicle\guer_ca.paa", "STR_A3_RscAttributeRespawnVehicle_Guer_tooltip", 16.5, 0.25, 2, independent call BIS_fnc_sideColor,
            {playableSlotsNumber independent > 0 && {[independent, _entity call BIS_fnc_objectSide] call BIS_fnc_areFriendly}}
        ],
        [
            6, "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeRespawnVehicle\civ_ca.paa", "STR_A3_RscAttributeRespawnVehicle_Civ_tooltip", 19, 0.25, 2, civilian call BIS_fnc_sideColor,
            {playableSlotsNumber civilian > 0 && {[civilian, _entity call BIS_fnc_objectSide] call BIS_fnc_areFriendly}}
        ],
        [
            0, "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeRespawnVehicle\start_ca.paa", "STR_A3_RscAttributeRespawnVehicle_Start_tooltip", 21.5, 0.25, 2
        ],
        [
            -1, "\a3\Ui_F_Curator\Data\default_ca.paa", "STR_Disabled", 24, 0.5, 1.5
        ]
    ]],
    {
        [QGVAR(setVehicleRespawn), _this] call CBA_fnc_serverEvent;
    },
    {
        private _respawnID = [_entity, false] call BIS_fnc_moduleRespawnVehicle;

        switch (_respawnID) do {
            case 1;
            case 7: {
                _respawnID = 0;
            };
            case 2: {
                _respawnID = [3, 4, 5, 6] param [(_entity call BIS_fnc_objectSide) call BIS_fnc_sideID, -1];
            };
        };

        _respawnID
    },
    {_entity isKindOf "LandVehicle" || {_entity isKindOf "Air"} || {_entity isKindOf "Ship"}}
] call FUNC(addAttribute);

[
    "Object",
    LSTRING(States),
    QGVAR(checkboxes),
    [[
        [10,   0, 5.5, "STR_3DEN_Object_Attribute_AllowDamage_displayName"],
        [15.5, 0, 6.2, "STR_3DEN_Object_Attribute_EnableSimulation_displayName"],
        [21.7, 0, 4.3, "STR_3DEN_Object_Attribute_HideObject_displayName"]
    ]],
    {
        _value params ["_damage", "_simulation", "_hidden"];

        // Invert visibility since UI uses opposite logic
        private _states = [_damage, _simulation, !_hidden];

        {
            [QGVAR(setObjectStates), [_x, _states]] call CBA_fnc_serverEvent;
        } forEach SELECTED_OBJECTS;
    },
    {
        [isDamageAllowed _entity, simulationEnabled _entity, !isObjectHidden _entity]
    }
] call FUNC(addAttribute);

[
    "Object",
    "STR_a3_rscdebugconsole_expressiontext",
    QGVAR(code),
    [QGVAR(objectExecHistory), QGVAR(objectExecMode), LSTRING(ExecObject_Tooltip), 20, 1000],
    {
        _value params ["_code", "_mode"];

        _code = compile _code;

        switch (_mode) do {
            case MODE_LOCAL: {
                _entity call _code;
            };
            case MODE_TARGET: {
                [QEGVAR(common,execute), [_code, _entity], _entity] call CBA_fnc_targetEvent;
            };
            case MODE_GLOBAL: {
                [QEGVAR(common,execute), [_code, _entity]] call CBA_fnc_globalEvent;
            };
        };
    },
    {""},
    {IS_ADMIN || {!GETMVAR(ZEN_disableCodeExecution,false)}}
] call FUNC(addAttribute);

// - Group --------------------------------------------------------------------

["Group", "", true] call FUNC(addDisplay);

[
    "Group",
    "STR_A3_RscAttributeGroupID_Title",
    QGVAR(edit),
    nil,
    {_entity setGroupIdGlobal [_value]},
    {groupID _entity}
] call FUNC(addAttribute);

[
    "Group",
    "STR_3DEN_Object_Attribute_Skill_displayName",
    QGVAR(slider),
    [0.2, 1, 0.1, true],
    {
        {
            {
                [QEGVAR(common,setSkill), [_x, _value], _x] call CBA_fnc_targetEvent;
            } forEach units _x;
        } forEach SELECTED_GROUPS;
    },
    {skill leader _entity}
] call FUNC(addAttribute);

[
    "Group",
    "STR_3DEN_Group_Attribute_Formation_displayName",
    QGVAR(icons),
    [[
        ["WEDGE",       "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\wedge_ca.paa",       "STR_Wedge",     11.75,   0, 2.5],
        ["VEE",         "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\vee_ca.paa",         "STR_Vee",       14.25,   0, 2.5],
        ["LINE",        "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\line_ca.paa",        "STR_Line",      16.75,   0, 2.5],
        ["COLUMN",      "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\column_ca.paa",      "STR_Column",    19.25,   0, 2.5],
        ["FILE",        "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\file_ca.paa",        "STR_File",      21.75,   0, 2.5],
        ["STAG COLUMN", "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\stag_column_ca.paa", "STR_Staggered", 11.75, 2.5, 2.5],
        ["ECH LEFT",    "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\ech_left_ca.paa",    "STR_Echl",      14.25, 2.5, 2.5],
        ["ECH RIGHT",   "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\ech_right_ca.paa",   "STR_Echr",      16.75, 2.5, 2.5],
        ["DIAMOND",     "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\diamond_ca.paa",     "STR_Diamond",   19.25, 2.5, 2.5]
    ], 2],
    {
        {
            [QEGVAR(common,setFormation), [_x, _value], _x] call CBA_fnc_targetEvent;
        } forEach SELECTED_GROUPS;
    },
    {formation _entity}
] call FUNC(addAttribute);

[
    "Group",
    "STR_3DEN_Group_Attribute_Behaviour_displayName",
    QGVAR(icons),
    [[
        ["CARELESS", QPATHTOF(ui\careless_ca.paa), "STR_3DEN_Attributes_Behaviour_Careless_text", 12.25, 0.5, 1.5],
        ["SAFE",     "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeBehaviour\safe_ca.paa",    "STR_Safe",    14.75, 0.5, 1.5, [0, 1, 0]],
        ["AWARE",    "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeBehaviour\aware_ca.paa",   "STR_Aware",   17.25, 0.5, 1.5, [1, 1, 0]],
        ["COMBAT",   "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeBehaviour\combat_ca.paa",  "STR_Combat",  19.75, 0.5, 1.5, [1, 0, 0]],
        ["STEALTH",  "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeBehaviour\stealth_ca.paa", "STR_Stealth", 22.25, 0.5, 1.5, [0, 1, 1]]
    ]],
    {
        {
            [QEGVAR(common,setBehaviour), [_x, _value], _x] call CBA_fnc_targetEvent;
        } forEach SELECTED_GROUPS;
    },
    {behaviour leader _entity}
] call FUNC(addAttribute);

[
    "Group",
    "STR_3DEN_Group_Attribute_CombatMode_displayName",
    QGVAR(icons),
    [[
        ["BLUE",   QPATHTOF(ui\hold_ca.paa),   "STR_3DEN_Attributes_CombatMode_Blue_text",   12.25, 0.5, 1.5, [1, 0, 0]],
        ["GREEN",  QPATHTOF(ui\defend_ca.paa), "STR_3DEN_Attributes_CombatMode_Green_text",  14.75, 0.5, 1.5, [1, 0, 0]],
        ["WHITE",  QPATHTOF(ui\engage_ca.paa), "STR_3DEN_Attributes_CombatMode_White_text",  17.25, 0.5, 1.5, [1, 0, 0]],
        ["YELLOW", QPATHTOF(ui\hold_ca.paa),   "STR_3DEN_Attributes_CombatMode_Yellow_text", 19.75, 0.5, 1.5],
        ["RED",    QPATHTOF(ui\engage_ca.paa), "STR_3DEN_Attributes_CombatMode_Red_text",    22.25, 0.5, 1.5]
    ]],
    {
        {
            [QEGVAR(common,setCombatMode), [_x, _value], _x] call CBA_fnc_targetEvent;
        } forEach SELECTED_GROUPS;
    },
    {combatMode _entity}
] call FUNC(addAttribute);

[
    "Group",
    "STR_HC_Menu_Speed",
    QGVAR(icons),
    [[
        ["LIMITED", "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeSpeedMode\limited_ca.paa", "STR_Speed_Limited", 14.25, 0, 2.5],
        ["NORMAL",  "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeSpeedMode\normal_ca.paa",  "STR_Speed_Normal",  16.75, 0, 2.5],
        ["FULL",    "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeSpeedMode\full_ca.paa",    "STR_Speed_Full",    19.25, 0, 2.5]
    ]],
    {
        {
            [QEGVAR(common,setSpeedMode), [_x, _value], _x] call CBA_fnc_targetEvent;
        } forEach SELECTED_GROUPS;
    },
    {speedMode _entity}
] call FUNC(addAttribute);

[
    "Group",
    "STR_A3_RscAttributeUnitPos_Title",
    QGVAR(icons),
    [[
        ["DOWN",   "\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_prone_ca.paa",  "STR_A3_RscAttributeUnitPos_Down_tooltip",   14.25, 0, 2.5],
        ["MIDDLE", "\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_crouch_ca.paa", "STR_A3_RscAttributeUnitPos_Crouch_tooltip", 16.75, 0, 2.5],
        ["UP",     "\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_stand_ca.paa",  "STR_A3_RscAttributeUnitPos_Up_tooltip",     19.25, 0, 2.5],
        ["AUTO",   "\a3\ui_f_curator\Data\default_ca.paa",                        "STR_A3_RscAttributeUnitPos_Auto_tooltip",   24,  0.5, 1.5]
    ]],
    {
        {
            {
                [QEGVAR(common,setUnitPos), [_x, _value], _x] call CBA_fnc_targetEvent;
            } forEach units _x;
        } forEach SELECTED_GROUPS;
    },
    {toUpper unitPos leader _entity}
] call FUNC(addAttribute);

[
    "Group",
    "STR_a3_rscdebugconsole_expressiontext",
    QGVAR(code),
    [QGVAR(groupExecHistory), QGVAR(groupExecMode), LSTRING(ExecGroup_Tooltip), 20, 1000],
    {
        _value params ["_code", "_mode"];

        _code = compile _code;

        switch (_mode) do {
            case MODE_LOCAL: {
                _entity call _code;
            };
            case MODE_TARGET: {
                [QEGVAR(common,execute), [_code, _entity], _entity] call CBA_fnc_targetEvent;
            };
            case MODE_GLOBAL: {
                [QEGVAR(common,execute), [_code, _entity]] call CBA_fnc_globalEvent;
            };
        };
    },
    {""},
    {IS_ADMIN || {!GETMVAR(ZEN_disableCodeExecution,false)}}
] call FUNC(addAttribute);

// - Waypoint -----------------------------------------------------------------

["Waypoint", "", true] call FUNC(addDisplay);

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
    }
] call FUNC(addAttribute);

[
    "Waypoint",
    "STR_3DEN_Waypoint_Attribute_LoiterDirection_displayname",
    QGVAR(loiter),
    nil,
    {
        {
            if (waypointType _x == "LOITER") then {
                _x setWaypointLoiterType _value;
            };
        } forEach SELECTED_WAYPOINTS;
    },
    {waypointLoiterType _entity},
    {waypointType _entity == "LOITER"}
] call FUNC(addAttribute);

[
    "Waypoint",
    "STR_3DEN_Waypoint_Attribute_LoiterRadius_displayname",
    QGVAR(edit),
    nil,
    {
        private _radius = parseNumber _value;
        {
            if (waypointType _x == "LOITER") then {
                _x setWaypointLoiterRadius _radius;
            };
        } forEach SELECTED_WAYPOINTS;
    },
    {str waypointLoiterRadius _entity},
    {waypointType _entity == "LOITER"}
] call FUNC(addAttribute);

[
    "Waypoint",
    ["STR_3DEN_Waypoint_Attribute_LoiterAltitude_displayname", "STR_3DEN_Waypoint_Attribute_LoiterAltitude_tooltip"],
    QGVAR(edit),
    nil,
    {
        private _altitude = parseNumber _value;
        {
            if (waypointType _x == "LOITER") then {
                _x setWaypointLoiterAltitude _altitude;
            };
        } forEach SELECTED_WAYPOINTS;
    },
    {str waypointLoiterAltitude _entity},
    {waypointType _entity == "LOITER"}
] call FUNC(addAttribute);

[
    "Waypoint",
    [LSTRING(Timeout), LSTRING(Timeout_Tooltip)],
    QGVAR(slider),
    [0, 1800, 15, false, 0],
    {_entity setWaypointTimeout [_value, _value, _value]},
    {random waypointTimeout _entity}
] call FUNC(addAttribute);

[
    "Waypoint",
    "STR_3DEN_Group_Attribute_Formation_displayName",
    QGVAR(icons),
    [[
        ["WEDGE",       "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\wedge_ca.paa",       "STR_Wedge",     11.75,   0, 2.5],
        ["VEE",         "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\vee_ca.paa",         "STR_Vee",       14.25,   0, 2.5],
        ["LINE",        "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\line_ca.paa",        "STR_Line",      16.75,   0, 2.5],
        ["COLUMN",      "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\column_ca.paa",      "STR_Column",    19.25,   0, 2.5],
        ["FILE",        "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\file_ca.paa",        "STR_File",      21.75,   0, 2.5],
        ["STAG COLUMN", "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\stag_column_ca.paa", "STR_Staggered", 11.75, 2.5, 2.5],
        ["ECH LEFT",    "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\ech_left_ca.paa",    "STR_Echl",      14.25, 2.5, 2.5],
        ["ECH RIGHT",   "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\ech_right_ca.paa",   "STR_Echr",      16.75, 2.5, 2.5],
        ["DIAMOND",     "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\diamond_ca.paa",     "STR_Diamond",   19.25, 2.5, 2.5],
        ["NO CHANGE",   "\a3\ui_f_curator\Data\default_ca.paa",                                     "STR_No_Change", 22.25,   3, 1.5]
    ], 2],
    {
        {
            _x params ["_group", "_waypointID"];

            if (currentWaypoint _group == _waypointID && {_value != "NO CHANGE"}) then {
                [QEGVAR(common,setFormation), [_group, _value], _group] call CBA_fnc_targetEvent;
            };

            [QEGVAR(common,setWaypointFormation), [_x, _value]] call CBA_fnc_serverEvent;
        } forEach SELECTED_WAYPOINTS;
    },
    {waypointFormation _entity}
] call FUNC(addAttribute);

[
    "Waypoint",
    "STR_3DEN_Group_Attribute_Behaviour_displayName",
    QGVAR(icons),
    [[
        ["CARELESS",  QPATHTOF(ui\careless_ca.paa), "STR_3DEN_Attributes_Behaviour_Careless_text", 11.25, 0.5, 1.5],
        ["SAFE",      "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeBehaviour\safe_ca.paa",    "STR_Safe",    13.75, 0.5, 1.5, [0, 1, 0]],
        ["AWARE",     "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeBehaviour\aware_ca.paa",   "STR_Aware",   16.25, 0.5, 1.5, [1, 1, 0]],
        ["COMBAT",    "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeBehaviour\combat_ca.paa",  "STR_Combat",  18.75, 0.5, 1.5, [1, 0, 0]],
        ["STEALTH",   "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeBehaviour\stealth_ca.paa", "STR_Stealth", 21.25, 0.5, 1.5, [0, 1, 1]],
        ["UNCHANGED", "\a3\ui_f_curator\Data\default_ca.paa", "STR_Combat_Unchanged", 24, 0.5, 1.5]
    ]],
    {
        {
            _x params ["_group", "_waypointID"];

            if (currentWaypoint _group == _waypointID && {_value != "UNCHANGED"}) then {
                [QEGVAR(common,setBehaviour), [_group, _value], _group] call CBA_fnc_targetEvent;
            };

            [QEGVAR(common,setWaypointBehaviour), [_x, _value]] call CBA_fnc_serverEvent;
        } forEach SELECTED_WAYPOINTS;
    },
    {waypointBehaviour _entity}
] call FUNC(addAttribute);

[
    "Waypoint",
    "STR_3DEN_Group_Attribute_CombatMode_displayName",
    QGVAR(icons),
    [[
        ["BLUE",      QPATHTOF(ui\hold_ca.paa),   "STR_3DEN_Attributes_CombatMode_Blue_text",   11.25, 0.5, 1.5, [1, 0, 0]],
        ["GREEN",     QPATHTOF(ui\defend_ca.paa), "STR_3DEN_Attributes_CombatMode_Green_text",  13.75, 0.5, 1.5, [1, 0, 0]],
        ["WHITE",     QPATHTOF(ui\engage_ca.paa), "STR_3DEN_Attributes_CombatMode_White_text",  16.25, 0.5, 1.5, [1, 0, 0]],
        ["YELLOW",    QPATHTOF(ui\hold_ca.paa),   "STR_3DEN_Attributes_CombatMode_Yellow_text", 18.75, 0.5, 1.5],
        ["RED",       QPATHTOF(ui\engage_ca.paa), "STR_3DEN_Attributes_CombatMode_Red_text",    21.25, 0.5, 1.5],
        ["NO CHANGE", "\a3\ui_f_curator\Data\default_ca.paa", "STR_Combat_Unchanged", 24, 0.5, 1.5]
    ]],
    {
        {
            _x params ["_group", "_waypointID"];

            if (currentWaypoint _group == _waypointID && {_value != "NO CHANGE"}) then {
                [QEGVAR(common,setCombatMode), [_group, _value], _group] call CBA_fnc_targetEvent;
            };

            [QEGVAR(common,setWaypointCombatMode), [_x, _value]] call CBA_fnc_serverEvent;
        } forEach SELECTED_WAYPOINTS;
    },
    {waypointCombatMode _entity}
] call FUNC(addAttribute);

[
    "Waypoint",
    "STR_HC_Menu_Speed",
    QGVAR(icons),
    [[
        ["LIMITED",   "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeSpeedMode\limited_ca.paa", "STR_Speed_Limited", 13.25, 0, 2.5],
        ["NORMAL",    "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeSpeedMode\normal_ca.paa",  "STR_Speed_Normal",  15.75, 0, 2.5],
        ["FULL",      "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeSpeedMode\full_ca.paa",    "STR_Speed_Full",    18.25, 0, 2.5],
        ["UNCHANGED", "\a3\ui_f_curator\Data\default_ca.paa", "STR_Speed_Unchanged", 24, 0.5, 1.5]
    ]],
    {
        {
            _x params ["_group", "_waypointID"];

            if (currentWaypoint _group == _waypointID && {_value != "UNCHANGED"}) then {
                [QEGVAR(common,setSpeedMode), [_group, _value], _group] call CBA_fnc_targetEvent;
            };

            [QEGVAR(common,setWaypointSpeed), [_x, _value]] call CBA_fnc_serverEvent;
        } forEach SELECTED_WAYPOINTS;
    },
    {waypointSpeed _entity}
] call FUNC(addAttribute);

// - Marker -------------------------------------------------------------------

["Marker", "", true] call FUNC(addDisplay);

[
    "Marker",
    "STR_3DEN_Marker_Attribute_Text_displayName",
    QGVAR(edit),
    nil,
    {_entity setMarkerText _value},
    {markerText _entity}
] call FUNC(addAttribute);

[
    "Marker",
    "STR_3DEN_Marker_Attribute_Color_displayName",
    QGVAR(combo),
    [
        configProperties [configFile >> "CfgMarkerColors", "isClass _x && {getNumber (_x >> 'scope') > 0}"] apply {
            [configName _x, getText (_x >> "name"), ["#(argb,8,8,3)color(1,1,1,1)", (_x >> "color") call BIS_fnc_colorConfigToRGBA]]
        }
    ],
    {
        _entity setMarkerColor _value;

        // Set this color to be applied to new markers of this type
        GVAR(previousMarkerColors) setVariable [markerType _entity, _value];
    },
    {markerColor _entity}
] call FUNC(addAttribute);

[
    "Marker",
    "STR_3DEN_Marker_Attribute_Alpha_displayName",
    QGVAR(slider),
    [0, 1, 0.1, true],
    {_entity setMarkerAlpha _value},
    {markerAlpha _entity}
] call FUNC(addAttribute);

// - Skills -------------------------------------------------------------------

["Skills", LSTRING(ChangeSkills), false] call FUNC(addDisplay);

[
    "Object",
    LSTRING(Skills),
    {[_entity, "Skills"] call FUNC(open)},
    {alive _entity && {_entity isKindOf "CAManBase"}}
] call FUNC(addButton);

[
    "Skills",
    "STR_General",
    QGVAR(slider),
    [0, 1, 0.1, true],
    {
        {
            [QEGVAR(common,setSkill), [_x, ["general", _value]], _x] call CBA_fnc_targetEvent;
        } forEach call EFUNC(common,getSelectedUnits);
    },
    {_entity skill "general"}
] call FUNC(addAttribute);

[
    "Skills",
    ELSTRING(ai,AimingAccuracy),
    QGVAR(slider),
    [0, 1, 0.1, true],
    {
        {
            [QEGVAR(common,setSkill), [_x, ["aimingAccuracy", _value]], _x] call CBA_fnc_targetEvent;
        } forEach call EFUNC(common,getSelectedUnits);
    },
    {_entity skill "aimingAccuracy"}
] call FUNC(addAttribute);

[
    "Skills",
    ELSTRING(ai,AimingSpeed),
    QGVAR(slider),
    [0, 1, 0.1, true],
    {
        {
            [QEGVAR(common,setSkill), [_x, ["aimingSpeed", _value]], _x] call CBA_fnc_targetEvent;
        } forEach call EFUNC(common,getSelectedUnits);
    },
    {_entity skill "aimingSpeed"}
] call FUNC(addAttribute);

[
    "Skills",
    ELSTRING(ai,AimingShake),
    QGVAR(slider),
    [0, 1, 0.1, true],
    {
        {
            [QEGVAR(common,setSkill), [_x, ["aimingShake", _value]], _x] call CBA_fnc_targetEvent;
        } forEach call EFUNC(common,getSelectedUnits);
    },
    {_entity skill "aimingShake"}
] call FUNC(addAttribute);

[
    "Skills",
    ELSTRING(ai,Commanding),
    QGVAR(slider),
    [0, 1, 0.1, true],
    {
        {
            [QEGVAR(common,setSkill), [_x, ["commanding", _value]], _x] call CBA_fnc_targetEvent;
        } forEach call EFUNC(common,getSelectedUnits);
    },
    {_entity skill "commanding"}
] call FUNC(addAttribute);

[
    "Skills",
    ELSTRING(ai,Courage),
    QGVAR(slider),
    [0, 1, 0.1, true],
    {
        {
            [QEGVAR(common,setSkill), [_x, ["courage", _value]], _x] call CBA_fnc_targetEvent;
        } forEach call EFUNC(common,getSelectedUnits);
    },
    {_entity skill "courage"}
] call FUNC(addAttribute);

[
    "Skills",
    ELSTRING(ai,SpotDistance),
    QGVAR(slider),
    [0, 1, 0.1, true],
    {
        {
            [QEGVAR(common,setSkill), [_x, ["spotDistance", _value]], _x] call CBA_fnc_targetEvent;
        } forEach call EFUNC(common,getSelectedUnits);
    },
    {_entity skill "spotDistance"}
] call FUNC(addAttribute);

[
    "Skills",
    ELSTRING(ai,SpotTime),
    QGVAR(slider),
    [0, 1, 0.1, true],
    {
        {
            [QEGVAR(common,setSkill), [_x, ["spotTime", _value]], _x] call CBA_fnc_targetEvent;
        } forEach call EFUNC(common,getSelectedUnits);
    },
    {_entity skill "spotTime"}
] call FUNC(addAttribute);

[
    "Skills",
    ELSTRING(ai,ReloadSpeed),
    QGVAR(slider),
    [0, 1, 0.1, true],
    {
        {
            [QEGVAR(common,setSkill), [_x, ["reloadSpeed", _value]], _x] call CBA_fnc_targetEvent;
        } forEach call EFUNC(common,getSelectedUnits);
    },
    {_entity skill "reloadSpeed"}
] call FUNC(addAttribute);

// - Abilities ----------------------------------------------------------------

["Abilities", LSTRING(ChangeAbilities), false] call FUNC(addDisplay);

[
    "Object",
    LSTRING(Abilities),
    {[_entity, "Abilities"] call FUNC(open)},
    {alive _entity && {_entity isKindOf "CAManBase"}}
] call FUNC(addButton);

[
    "Abilities",
    "",
    QGVAR(checkboxes),
    [[
        [0,    0, 6.5, ELSTRING(ai,AimingError)],
        [6.5,  0, 6.5, ELSTRING(ai,AnimChange)],
        [13,   0, 6.5, ELSTRING(ai,AutoCombat)],
        [19.5, 0, 6.5, ELSTRING(ai,AutoTarget)],
        [0,    1, 6.5, ELSTRING(ai,CheckVisible)],
        [6.5,  1, 6.5, ELSTRING(ai,Cover)],
        [13,   1, 6.5, ELSTRING(ai,FSM)],
        [19.5, 1, 6.5, ELSTRING(ai,LightsVehicle)],
        [0,    2, 6.5, ELSTRING(ai,MineDetection)],
        [6.5,  2, 6.5, ELSTRING(ai,Move)],
        [13,   2, 6.5, ELSTRING(ai,Nightvision)],
        [19.5, 2, 6.5, ELSTRING(ai,Path)],
        [0,    3, 6.5, ELSTRING(ai,RadioProtocol)],
        [6.5,  3, 6.5, ELSTRING(ai,Suppression)],
        [13,   3, 6.5, ELSTRING(ai,Target)],
        [19.5, 3, 6.5, ELSTRING(ai,TeamSwitch)],
        [0,    4, 6.5, ELSTRING(ai,WeaponAim)]
    ], 5, true],
    {
        {
            [QGVAR(setAbilities), [_x, _value], _x] call CBA_fnc_targetEvent;
        } forEach call EFUNC(common,getSelectedUnits);
    },
    {AI_ABILITIES apply {_entity checkAIFeature _x}}
] call FUNC(addAttribute);

// - Traits -------------------------------------------------------------------

["Traits", LSTRING(ChangeTraits), false] call FUNC(addDisplay);

[
    "Object",
    LSTRING(Traits),
    {[_entity, "Traits"] call FUNC(open)},
    {alive _entity && {_entity isKindOf "CAManBase"}}
] call FUNC(addButton);

if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then {
    [
        "Traits",
        LSTRING(MedicalTraining),
        QGVAR(toolbox),
        [1, 3, ["STR_A3_None", "STR_support_medic", LSTRING(Doctor)]],
        {
            {
                _x setVariable ["ace_medical_medicClass", _value, true];
            } forEach call EFUNC(common,getSelectedUnits);
        },
        {_entity getVariable ["ace_medical_medicClass", parseNumber (_entity getUnitTrait "medic")]}
    ] call FUNC(addAttribute);
} else {
    [
        "Traits",
        "STR_Support_Medic",
        QGVAR(toolbox),
        [1, 2, [ELSTRING(common,No), ELSTRING(common,Yes)]],
        {
            {
                [QEGVAR(common,setUnitTrait), [_x, "medic", _value], _x] call CBA_fnc_targetEvent;
            } forEach call EFUNC(common,getSelectedUnits);
        },
        {_entity getUnitTrait "medic"}
    ] call FUNC(addAttribute);
};

if (isClass (configFile >> "CfgPatches" >> "ace_repair")) then {
    [
        "Traits",
        LSTRING(EngineeringSkill),
        QGVAR(toolbox),
        [1, 3, ["STR_A3_None", "str_b_engineer_f0", LSTRING(AdvEngineer)]],
        {
            {
                _x setVariable ["ACE_isEngineer", _value, true];
            } forEach call EFUNC(common,getSelectedUnits);
        },
        {[0, 1, 2] select (_entity getVariable ["ACE_isEngineer", _entity getUnitTrait "engineer"])}
    ] call FUNC(addAttribute);
} else {
    [
        "Traits",
        "str_b_engineer_f0",
        QGVAR(toolbox),
        [1, 2, [ELSTRING(common,No), ELSTRING(common,Yes)]],
        {
            {
                [QEGVAR(common,setUnitTrait), [_x, "engineer", _value], _x] call CBA_fnc_targetEvent;
            } forEach call EFUNC(common,getSelectedUnits);
        },
        {_entity getUnitTrait "engineer"}
    ] call FUNC(addAttribute);
};

if (isClass (configFile >> "CfgPatches" >> "ace_explosives")) then {
    [
        "Traits",
        "str_b_soldier_exp_f0",
        QGVAR(toolbox),
        [1, 2, [ELSTRING(common,No), ELSTRING(common,Yes)]],
        {
            {
                _x setVariable ["ACE_isEOD", _value, true];
            } forEach call EFUNC(common,getSelectedUnits);
        },
        {_entity call ace_common_fnc_isEOD}
    ] call FUNC(addAttribute);
} else {
    [
        "Traits",
        LSTRING(EOD),
        QGVAR(toolbox),
        [1, 2, [ELSTRING(common,No), ELSTRING(common,Yes)]],
        {
            {
                [QEGVAR(common,setUnitTrait), [_x, "explosiveSpecialist", _value], _x] call CBA_fnc_targetEvent;
            } forEach call EFUNC(common,getSelectedUnits);
        },
        {_entity getUnitTrait "explosiveSpecialist"}
    ] call FUNC(addAttribute);
};

// - Sensors ------------------------------------------------------------------

["Sensors", "STR_3DEN_Object_AttributeCategory_VehicleSystems", false] call FUNC(addDisplay);

[
    "Object",
    LSTRING(Sensors),
    {[_entity, "Sensors"] call FUNC(open)},
    {alive _entity && {_entity isKindOf "LandVehicle" || {_entity isKindOf "Air"} || {_entity isKindOf "Ship"}}}
] call FUNC(addButton);

[
    "Sensors",
    ["STR_3DEN_Object_Attribute_Radar_displayName", "STR_3DEN_Object_Attribute_Radar_tooltip"],
    QGVAR(combo),
    [[
        [0, ["STR_3DEN_Attributes_Radar_Default_text",  "STR_3DEN_Attributes_Radar_Default_tooltip"]],
        [1, ["STR_3DEN_Attributes_Radar_RadarOn_text",  "STR_3DEN_Attributes_Radar_RadarOn_tooltip"]],
        [2, ["STR_3DEN_Attributes_Radar_RadarOff_text", "STR_3DEN_Attributes_Radar_RadarOff_tooltip"]]
    ]],
    {
        {
            [QEGVAR(common,setVehicleRadar), [_x, _value], _x] call CBA_fnc_targetEvent;
        } forEach call EFUNC(common,getSelectedVehicles);
    },
    {[2, 1] select isVehicleRadarOn _entity}
] call FUNC(addAttribute);

[
    "Sensors",
    ["STR_3DEN_Object_Attribute_ReportRemoteTargets_displayName", "STR_3DEN_Object_Attribute_ReportRemoteTargets_tooltip"],
    QGVAR(toolbox),
    [1, 2, [ELSTRING(common,Disabled), ELSTRING(common,Enabled)]],
    {
        {
            [QEGVAR(common,setVehicleReportRemoteTargets), [_x, _value], _x] call CBA_fnc_targetEvent;
        } forEach call EFUNC(common,getSelectedVehicles);
    },
    {vehicleReportRemoteTargets _entity}
] call FUNC(addAttribute);

[
    "Sensors",
    ["STR_3DEN_Object_Attribute_ReceiveRemoteTargets_displayName", "STR_3DEN_Object_Attribute_ReceiveRemoteTargets_tooltip"],
    QGVAR(toolbox),
    [1, 2, [ELSTRING(common,Disabled), ELSTRING(common,Enabled)]],
    {
        {
            [QEGVAR(common,setVehicleReceiveRemoteTargets), [_x, _value], _x] call CBA_fnc_targetEvent;
        } forEach call EFUNC(common,getSelectedVehicles);
    },
    {vehicleReceiveRemoteTargets _entity}
] call FUNC(addAttribute);

[
    "Sensors",
    ["STR_3DEN_Object_Attribute_ReportOwnPosition_displayName", "STR_3DEN_Object_Attribute_ReportOwnPosition_tooltip"],
    QGVAR(toolbox),
    [1, 2, [ELSTRING(common,Disabled), ELSTRING(common,Enabled)]],
    {
        {
            [QEGVAR(common,setVehicleReportOwnPosition), [_x, _value], _x] call CBA_fnc_targetEvent;
        } forEach call EFUNC(common,getSelectedVehicles);
    },
    {vehicleReportOwnPosition _entity}
] call FUNC(addAttribute);

// - Side ---------------------------------------------------------------------

["Side", LSTRING(ChangeSide), false] call FUNC(addDisplay);

[
    "Group",
    "STR_Eval_TypeSide",
    {[_entity, "Side"] call FUNC(open)}
] call FUNC(addButton);

[
    "Side",
    "STR_Eval_TypeSide",
    QGVAR(icons),
    [[
        [west,        "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_west_ca.paa", "STR_West",     12.5, 0.25, 2, west call BIS_fnc_sideColor],
        [east,        "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_east_ca.paa", "STR_East",     15.5, 0.25, 2, east call BIS_fnc_sideColor],
        [independent, "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_guer_ca.paa", "STR_Guerrila", 18.5, 0.25, 2, independent call BIS_fnc_sideColor],
        [civilian,    "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_civ_ca.paa",  "STR_Civilian", 21.5, 0.25, 2, civilian call BIS_fnc_sideColor]
    ]],
    {
        {
            [_x, _value] call EFUNC(common,changeGroupSide);
        } forEach SELECTED_GROUPS;
    },
    {side _entity}
] call FUNC(addAttribute);
