class EGVAR(context_menu,actions) {
    class FireArtillery {
        displayName = CSTRING(FireArtillery);
        icon = "\a3\ui_f\data\gui\cfg\communicationmenu\artillery_ca.paa";
        insertChildren = QUOTE(_objects call FUNC(getArtilleryActions));
        priority = 70;
    };
    class Formation {
        displayName = "$STR_3DEN_Group_Attribute_Formation_displayName";
        condition = QUOTE(_groups findIf {units _x findIf {!isPlayer _x} != -1} != -1);
        icon = "\a3\3den\data\displays\display3den\entitymenu\movetoformation_ca.paa";
        priority = 60;
        class Wedge {
            displayName = "$STR_wedge";
            statement = QUOTE([ARR_2(_groups,_args)] call FUNC(setFormation));
            icon = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\wedge_ca.paa";
            args = "WEDGE";
        };
        class Vee: Wedge {
            displayName = "$STR_vee";
            icon = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\vee_ca.paa";
            args = "VEE";
        };
        class Line: Wedge {
            displayName = "$STR_line";
            icon = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\line_ca.paa";
            args = "LINE";
        };
        class Column: Wedge {
            displayName = "$STR_column";
            icon = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\column_ca.paa";
            args = "COLUMN";
        };
        class File: Wedge {
            displayName = "$STR_file";
            icon = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\file_ca.paa";
            args = "FILE";
        };
        class StagColumn: Wedge {
            displayName = "$STR_staggered";
            icon = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\stag_column_ca.paa";
            args = "STAG COLUMN";
        };
        class EchLeft: Wedge {
            displayName = "$STR_echl";
            icon = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\ech_left_ca.paa";
            args = "ECH LEFT";
        };
        class EchRight: Wedge {
            displayName = "$STR_echr";
            icon = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\ech_right_ca.paa";
            args = "ECH RIGHT";
        };
        class Diamond: Wedge {
            displayName = "$STR_diamond";
            icon = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\diamond_ca.paa";
            args = "DIAMOND";
        };
    };
    class Behaviour {
        displayName = "$STR_3DEN_Group_Attribute_Behaviour_displayName";
        condition = QUOTE(_groups findIf {units _x findIf {!isPlayer _x} != -1} != -1);
        icon = QPATHTOF(ui\careless_ca.paa);
        priority = 59;
        class Safe {
            displayName = "$STR_safe";
            statement = QUOTE([ARR_2(_groups,_args)] call FUNC(setBehaviour));
            icon = QPATHTOF(ui\safe_ca.paa);
            iconColor[] = {0, 1, 0, 1};
            args = "SAFE";
        };
        class Aware: Safe {
            displayName = "$STR_aware";
            icon = QPATHTOF(ui\aware_ca.paa);
            iconColor[] = {1, 1, 0, 1};
            args = "AWARE";
        };
        class Combat: Safe {
            displayName = "$STR_combat";
            icon = QPATHTOF(ui\combat_ca.paa);
            iconColor[] = {1, 0, 0, 1};
            args = "COMBAT";
        };
        class Stealth: Safe {
            displayName = "$STR_stealth";
            icon = QPATHTOF(ui\stealth_ca.paa);
            iconColor[] = {0, 1, 1, 1};
            args = "STEALTH";
        };
        class Careless: Safe {
            displayName = "$STR_3DEN_Attributes_Behaviour_Careless_text";
            icon = QPATHTOF(ui\careless_ca.paa);
            iconColor[] = {1, 1, 1, 1};
            args = "CARELESS";
        };
    };
    class CombatMode {
        displayName = "$STR_3DEN_Group_Attribute_CombatMode_displayName";
        condition = QUOTE(_groups findIf {units _x findIf {!isPlayer _x} != -1} != -1);
        icon = QPATHTOF(ui\attack_ca.paa);
        priority = 58;
        class Blue {
            displayName = CSTRING(HoldFire);
            statement = QUOTE([ARR_2(_groups,_args)] call FUNC(setCombatMode));
            icon = QPATHTOF(ui\hold_ca.paa);
            iconColor[] = {1, 0, 0, 1};
            args = "BLUE";
        };
        class Green: Blue {
            displayName = CSTRING(HoldFireDefend);
            icon = QPATHTOF(ui\defend_ca.paa);
            args = "GREEN";
        };
        class White: Blue {
            displayName = CSTRING(HoldFireEngage);
            icon = QPATHTOF(ui\engage_ca.paa);
            args = "WHITE";
        };
        class Yellow: Blue {
            displayName = CSTRING(FireAtWill);
            icon = QPATHTOF(ui\hold_ca.paa);
            iconColor[] = {1, 1, 1, 1};
            args = "YELLOW";
        };
        class Red: Blue {
            displayName = CSTRING(FireAtWillEngage);
            icon = QPATHTOF(ui\engage_ca.paa);
            iconColor[] = {1, 1, 1, 1};
            args = "RED";
        };
    };
    class SpeedMode {
        displayName = "$STR_HC_Menu_Speed";
        condition = QUOTE(_groups findIf {units _x findIf {!isPlayer _x} != -1} != -1);
        icon = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeSpeedMode\normal_ca.paa";
        priority = 57;
        class Limited {
            displayName = "$STR_speed_limited";
            statement = QUOTE([ARR_2(_groups,_args)] call FUNC(setSpeedMode));
            icon = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeSpeedMode\limited_ca.paa";
            args = "LIMITED";
        };
        class Normal: Limited {
            displayName = "$STR_speed_normal";
            icon = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeSpeedMode\normal_ca.paa";
            args = "NORMAL";
        };
        class Full: Limited {
            displayName = "$STR_speed_full";
            icon = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeSpeedMode\full_ca.paa";
            args = "FULL";
        };
    };
    class Stance {
        displayName = "$STR_A3_RscAttributeUnitPos_Title";
        condition = QUOTE(_objects findIf {alive _x && {_x isKindOf 'CAManBase'} && {!isPlayer _x}} != -1);
        icon = "\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_stand_ca.paa";
        priority = 56;
        class Up {
            displayName = "$STR_A3_RscAttributeUnitPos_Up_tooltip";
            statement = QUOTE([ARR_2(_objects,_args)] call FUNC(setStance));
            icon = "\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_stand_ca.paa";
            args = "UP";
        };
        class Middle: Up {
            displayName = "$STR_A3_RscAttributeUnitPos_Crouch_tooltip";
            icon = "\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_crouch_ca.paa";
            args = "MIDDLE";
        };
        class Down: Up {
            displayName = "$STR_A3_RscAttributeUnitPos_Down_tooltip";
            icon = "\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_prone_ca.paa";
            args = "DOWN";
        };
        class Auto: Up {
            displayName = "$STR_A3_RscAttributeUnitPos_Auto_tooltip";
            icon = QPATHTOF(ui\default_ca.paa);
            args = "AUTO";
        };
    };
    class HealUnits {
        displayName = "$STR_State_Heal";
        icon = QPATHTOF(ui\medical_cross_ca.paa);
        priority = 50;
        class All {
            displayName = ECSTRING(common,All);
            condition = QUOTE([ARR_2(_objects,_args)] call FUNC(canHealUnits));
            statement = QUOTE([ARR_2(_objects,_args)] call FUNC(healUnits));
            icon = QPATHTOF(ui\medical_cross_ca.paa);
            args = HEAL_MODE_ALL;
        };
        class Players: All {
            displayName = ECSTRING(modules,Players);
            args = HEAL_MODE_PLAYERS;
        };
        class AI: All {
            displayName = "$STR_Team_Switch_AI";
            args = HEAL_MODE_AI;
        };
    };
    class Captives {
        displayName = CSTRING(Captives);
        condition = QUOTE(isClass (configFile >> 'CfgPatches' >> 'ace_captives'));
        icon = "\z\ace\addons\captives\UI\handcuff_ca.paa";
        priority = 50;
        class ToggleCaptive {
            displayName = CSTRING(ToggleCaptive);
            condition = QUOTE(_objects findIf {alive _x && {_x isKindOf 'CAManBase'}} != -1);
            statement = QUOTE(_objects call FUNC(toggleCaptive));
            icon = "\z\ace\addons\captives\UI\handcuff_ca.paa";
        };
        class ToggleSurrender {
            displayName = CSTRING(ToggleSurrender);
            condition = QUOTE(_objects call FUNC(canToggleSurrender));
            statement = QUOTE(_objects call FUNC(toggleSurrender));
            icon = "\z\ace\addons\captives\UI\Surrender_ca.paa";
        };
    };
    class Loadout {
        displayName = "$STR_A3_VR_Stamina_01_Loadout";
        condition = QUOTE(_hoveredEntity call FUNC(canEditLoadout));
        statement = QUOTE(_hoveredEntity call EFUNC(common,openArsenal));
        icon = "\a3\3den\data\displays\display3den\entitymenu\arsenal_ca.paa";
        priority = 40;
        class Edit {
            displayName = "$STR_3DEN_Display3DEN_MenUBar_Edit_text";
            condition = QUOTE(_hoveredEntity call FUNC(canEditLoadout));
            statement = QUOTE(_hoveredEntity call EFUNC(common,openArsenal));
            icon = "\a3\3DEN\Data\Displays\Display3DEN\PanelRight\customcomposition_edit_ca.paa";
        };
        class Copy {
            displayName = "$STR_3DEN_Display3DEN_MenuBar_EntityCopy_text";
            statement = QUOTE(GVAR(loadout) = getUnitLoadout _hoveredEntity);
            icon = QPATHTOF(ui\copy_ca.paa);
        };
        class Paste {
            displayName = "$STR_3DEN_Display3DEN_MenuBar_EntityPaste_text";
            condition = QUOTE(!isNil QQGVAR(loadout));
            statement = QUOTE(_hoveredEntity setUnitLoadout GVAR(loadout));
            icon = QPATHTOF(ui\paste_ca.paa);
        };
        class Reset {
            displayName = "$STR_A3_RscDisplayCampaignLobby_Reset";
            statement = QUOTE(_hoveredEntity setUnitLoadout configOf _hoveredEntity);
            icon = "\a3\3den\Data\Displays\Display3DEN\ToolBar\undo_ca.paa";
        };
    };
    class VehicleLoadout {
        displayName = "$STR_A3_VR_Stamina_01_Loadout";
        icon = QPATHTOF(ui\ammo_ca.paa);
        priority = 39;
        class Magazines {
            displayName = "$STR_GEAR_MAGAZINES";
            condition = QUOTE(_hoveredEntity call FUNC(canEditMagazines));
            statement = QUOTE(_hoveredEntity call EFUNC(loadout,configure));
            icon = "\a3\ui_f\data\igui\cfg\weaponicons\mg_ca.paa";
        };
        class Pylons {
            displayName = ECSTRING(pylons,DisplayName);
            condition = QUOTE(_hoveredEntity call FUNC(canEditPylons));
            statement = QUOTE(_hoveredEntity call EFUNC(pylons,configure));
            icon = "\a3\ui_f\data\igui\cfg\weaponicons\aa_ca.paa";
        };
    };
    class Inventory {
        displayName = "$STR_A3_Gear1";
        condition = QUOTE(_hoveredEntity call FUNC(canEditInventory));
        statement = QUOTE(_hoveredEntity call EFUNC(inventory,configure));
        icon = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeInventory\filter_0_ca.paa";
        priority = 38;
        class Edit {
            displayName = "$STR_3DEN_Display3DEN_MenUBar_Edit_text";
            condition = QUOTE(_hoveredEntity call FUNC(canEditInventory));
            statement = QUOTE(_hoveredEntity call EFUNC(inventory,configure));
            icon = "\a3\3DEN\Data\Displays\Display3DEN\PanelRight\customcomposition_edit_ca.paa";
        };
        class Copy {
            displayName = "$STR_3DEN_Display3DEN_MenuBar_EntityCopy_text";
            statement = QUOTE(GVAR(inventory) = _hoveredEntity call EFUNC(common,serializeInventory));
            icon = QPATHTOF(ui\copy_ca.paa);
        };
        class Paste {
            displayName = "$STR_3DEN_Display3DEN_MenuBar_EntityPaste_text";
            condition = QUOTE(!isNil QQGVAR(inventory));
            statement = QUOTE([ARR_2(_hoveredEntity,GVAR(inventory))] call EFUNC(common,deserializeInventory));
            icon = QPATHTOF(ui\paste_ca.paa);
        };
    };
    class VehicleAppearance {
        displayName = CSTRING(VehicleAppearance);
        condition = QUOTE(_hoveredEntity call FUNC(canEditVehicleAppearance));
        statement = QUOTE(_hoveredEntity call EFUNC(garage,openGarage));
        icon = "\a3\3den\data\displays\display3den\entitymenu\garage_ca.paa";
        priority = 37;
        class Edit {
            displayName = "$STR_3DEN_Display3DEN_MenUBar_Edit_text";
            condition = QUOTE(_hoveredEntity call FUNC(canEditVehicleAppearance));
            statement = QUOTE(_hoveredEntity call EFUNC(garage,openGarage));
            icon = "\a3\3DEN\Data\Displays\Display3DEN\PanelRight\customcomposition_edit_ca.paa";
        };
        class Copy {
            displayName = "$STR_3DEN_Display3DEN_MenuBar_EntityCopy_text";
            statement = QUOTE(_hoveredEntity call FUNC(copyVehicleAppearance));
            icon = QPATHTOF(ui\copy_ca.paa);
        };
        class Paste {
            displayName = "$STR_3DEN_Display3DEN_MenuBar_EntityPaste_text";
            condition = QUOTE(_hoveredEntity call FUNC(canPasteVehicleAppearance));
            statement = QUOTE(_hoveredEntity call FUNC(pasteVehicleAppearance));
            icon = QPATHTOF(ui\paste_ca.paa);
        };
    };
    class VehicleLogistics {
        displayName = CSTRING(VehicleLogistics);
        icon = "\a3\ui_f\data\igui\cfg\simpleTasks\types\truck_ca.paa";
        priority = 36;
        class Repair {
            displayName = "$STR_Repair";
            condition = QUOTE(_objects call FUNC(canRepairVehicles));
            statement = QUOTE(_objects call FUNC(repairVehicles));
            icon = "\a3\ui_f\data\igui\cfg\simpleTasks\types\repair_ca.paa";
        };
        class Rearm {
            displayName = "$STR_Rearm";
            condition = QUOTE(_objects call FUNC(canRearmVehicles));
            statement = QUOTE(_objects call FUNC(rearmVehicles));
            icon = "\a3\ui_f\data\igui\cfg\simpleTasks\types\rearm_ca.paa";
        };
        class Refuel {
            displayName = "$STR_Refuel";
            condition = QUOTE(_objects call FUNC(canRefuelVehicles));
            statement = QUOTE(_objects call FUNC(refuelVehicles));
            icon = "\a3\ui_f\data\igui\cfg\simpleTasks\types\refuel_ca.paa";
        };
        class UnloadViV {
            displayName = "$STR_A3_ModuleDepot_Unload";
            condition = QUOTE(_objects call FUNC(canUnloadViV));
            statement = QUOTE(_objects call FUNC(unloadViV));
            icon = "\a3\ui_f\data\IGUI\Cfg\Actions\unloadVehicle_ca.paa";
        };
    };
    class EditableObjects {
        displayName = CSTRING(EditableObjects);
        statement = QUOTE(call FUNC(openEditableObjectsDialog));
        icon = QPATHTOEF(modules,ui\edit_obj_ca.paa);
        priority = 30;
        class Add {
            displayName = ECSTRING(common,Add);
            icon = QPATHTOF(ui\add_ca.paa);
            class 10m {
                displayName = CSTRING(10m);
                statement = QUOTE([ARR_3(true,_position,_args)] call FUNC(updateEditableObjects));
                icon = QPATHTOF(ui\add_ca.paa);
                args = 10;
            };
            class 50m: 10m {
                displayName = CSTRING(50m);
                args = 50;
            };
            class 100m: 10m {
                displayName = CSTRING(100m);
                args = 100;
            };
            class 250m: 10m {
                displayName = CSTRING(250m);
                args = 250;
            };
        };
        class Remove {
            displayName = ECSTRING(common,Remove);
            icon = QPATHTOF(ui\remove_ca.paa);
            class 10m {
                displayName = CSTRING(10m);
                statement = QUOTE([ARR_3(false,_position,_args)] call FUNC(updateEditableObjects));
                icon = QPATHTOF(ui\remove_ca.paa);
                args = 10;
            };
            class 50m: 10m {
                displayName = CSTRING(50m);
                args = 50;
            };
            class 100m: 10m {
                displayName = CSTRING(100m);
                args = 100;
            };
            class 250m: 10m {
                displayName = CSTRING(250m);
                args = 250;
            };
        };
    };
    class RemoteControl {
        displayName = "$STR_A3_CfgVehicles_ModuleRemoteControl_F";
        condition = QUOTE(_hoveredEntity call EFUNC(remote_control,canControl));
        statement = QUOTE(_hoveredEntity call EFUNC(remote_control,start));
        icon = "\a3\modules_f_curator\data\portraitremotecontrol_ca.paa";
        priority = 20;
    };
    class TeleportPlayers {
        displayName = CSTRING(TeleportPlayers);
        condition = QUOTE(_objects findIf {isPlayer _x} != -1);
        statement = QUOTE(_objects call FUNC(teleportPlayers));
        icon = QPATHTOF(ui\marker_ca.paa);
        priority = 10;
    };
    class TeleportZeus {
        displayName = CSTRING(TeleportZeus);
        statement = QUOTE(call FUNC(teleportZeus));
        icon = "\a3\Ui_F_Curator\Data\Logos\arma3_curator_eye_256_ca.paa";
        priority = 10;
    };
};
