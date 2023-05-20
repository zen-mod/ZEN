
[
    QGVAR(enableExecute),
    "CHECKBOX",
    "STR_a3_rscdebugconsole_expressiontext",
    LSTRING(DisplayName),
    true,
    false
] call CBA_fnc_addSetting;

// - Object -------------------------------------------------------------------

[
    QGVAR(enableArsenal),
    "CHECKBOX",
    "STR_A3_Arsenal",
    [LSTRING(DisplayName), "STR_3DEN_Object_textPlural"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableName),
    "CHECKBOX",
    "STR_3DEN_Object_Attribute_UnitName_displayName",
    [LSTRING(DisplayName), "STR_3DEN_Object_textPlural"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableSkill),
    "CHECKBOX",
    "STR_3DEN_Object_Attribute_Skill_displayName",
    [LSTRING(DisplayName), "STR_3DEN_Object_textPlural"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableHealth),
    "CHECKBOX",
    "STR_3DEN_Object_Attribute_Health_displayName",
    [LSTRING(DisplayName), "STR_3DEN_Object_textPlural"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableFuel),
    "CHECKBOX",
    "STR_3DEN_Object_Attribute_Fuel_displayName",
    [LSTRING(DisplayName), "STR_3DEN_Object_textPlural"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableAmmo),
    "CHECKBOX",
    "STR_3DEN_Object_Attribute_Ammo_displayName",
    [LSTRING(DisplayName), "STR_3DEN_Object_textPlural"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableRank),
    "CHECKBOX",
    "STR_3DEN_Object_Attribute_Rank_displayName",
    [LSTRING(DisplayName), "STR_3DEN_Object_textPlural"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableStance),
    "CHECKBOX",
    "STR_A3_RscAttributeUnitPos_Title",
    [LSTRING(DisplayName), "STR_3DEN_Object_textPlural"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableVehicleLock),
    "CHECKBOX",
    "STR_3den_object_attribute_lock_displayname",
    [LSTRING(DisplayName), "STR_3DEN_Object_textPlural"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableEngine),
    "CHECKBOX",
    LSTRING(Engine),
    [LSTRING(DisplayName), "STR_3DEN_Object_textPlural"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableLights),
    "CHECKBOX",
    LSTRING(Lights),
    [LSTRING(DisplayName), "STR_3DEN_Object_textPlural"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableBuildingMarker),
    "CHECKBOX",
    ELSTRING(building_markers,BuildingMarker),
    [LSTRING(DisplayName), "STR_3DEN_Object_textPlural"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enablePlateNumber),
    "CHECKBOX",
    LSTRING(PlateNumber),
    [LSTRING(DisplayName), "STR_3DEN_Object_textPlural"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableRespawn),
    "CHECKBOX",
    "STR_3den_multiplayer_attributecategory_respawn_displayname",
    [LSTRING(DisplayName), "STR_3DEN_Object_textPlural"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableStates),
    "CHECKBOX",
    LSTRING(States),
    [LSTRING(DisplayName), "STR_3DEN_Object_textPlural"],
    true,
    false
] call CBA_fnc_addSetting;

// - Group --------------------------------------------------------------------

[
    QGVAR(enableGroupID),
    "CHECKBOX",
    "STR_A3_RscAttributeGroupID_Title",
    [LSTRING(DisplayName), "str_a3_rscdisplaycurator_modegroups_tooltip"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableGroupSkill),
    "CHECKBOX",
    "STR_3DEN_Object_Attribute_Skill_displayName",
    [LSTRING(DisplayName), "str_a3_rscdisplaycurator_modegroups_tooltip"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableGroupFormation),
    "CHECKBOX",
    "STR_3DEN_Group_Attribute_Formation_displayName",
    [LSTRING(DisplayName), "str_a3_rscdisplaycurator_modegroups_tooltip"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableGroupBehaviour),
    "CHECKBOX",
    "STR_3DEN_Group_Attribute_Behaviour_displayName",
    [LSTRING(DisplayName), "str_a3_rscdisplaycurator_modegroups_tooltip"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableGroupCombatMode),
    "CHECKBOX",
    "STR_3DEN_Group_Attribute_CombatMode_displayName",
    [LSTRING(DisplayName), "str_a3_rscdisplaycurator_modegroups_tooltip"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableGroupSpeed),
    "CHECKBOX",
    "STR_HC_Menu_Speed",
    [LSTRING(DisplayName), "str_a3_rscdisplaycurator_modegroups_tooltip"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableGroupStance),
    "CHECKBOX",
    "STR_A3_RscAttributeUnitPos_Title",
    [LSTRING(DisplayName), "str_a3_rscdisplaycurator_modegroups_tooltip"],
    true,
    false
] call CBA_fnc_addSetting;
