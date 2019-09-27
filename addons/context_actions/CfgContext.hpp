class EGVAR(context_menu,actions) {
    class Formation {
        displayName = "$STR_3DEN_Group_Attribute_Formation_displayName";
        icon = "\a3\3den\data\displays\display3den\entitymenu\movetoformation_ca.paa";
        condition = QUOTE(!(_selectedGroups isEqualTo []));
        class Wedge {
            displayName = "$STR_wedge";
            icon = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\wedge_ca.paa";
            statement = QUOTE([ARR_2(_selectedGroups,'WEDGE')] call FUNC(setFormation));
            priority = 9;
        };
        class Vee {
            displayName = "$STR_vee";
            icon = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\vee_ca.paa";
            statement = QUOTE([ARR_2(_selectedGroups,'VEE')] call FUNC(setFormation));
            priority = 8;
        };
        class Line {
            displayName = "$STR_line";
            icon = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\line_ca.paa";
            statement = QUOTE([ARR_2(_selectedGroups,'LINE')] call FUNC(setFormation));
            priority = 7;
        };
        class Column {
            displayName = "$STR_column";
            icon = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\column_ca.paa";
            statement = QUOTE([ARR_2(_selectedGroups,'COLUMN')] call FUNC(setFormation));
            priority = 6;
        };
        class File {
            displayName = "$STR_file";
            icon = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\file_ca.paa";
            statement = QUOTE([ARR_2(_selectedGroups,'FILE')] call FUNC(setFormation));
            priority = 5;
        };
        class StagColumn {
            displayName = "$STR_staggered";
            icon = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\stag_column_ca.paa";
            statement = QUOTE([ARR_2(_selectedGroups,'STAG COLUMN')] call FUNC(setFormation));
            priority = 4;
        };
        class EchLeft {
            displayName = "$STR_echl";
            icon = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\ech_left_ca.paa";
            statement = QUOTE([ARR_2(_selectedGroups,'ECH LEFT')] call FUNC(setFormation));
            priority = 3;
        };
        class EchRight {
            displayName = "$STR_echr";
            icon = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\ech_right_ca.paa";
            statement = QUOTE([ARR_2(_selectedGroups,'ECH RIGHT')] call FUNC(setFormation));
            priority = 2;
        };
        class Diamond {
            displayName = "$STR_diamond";
            icon = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeFormation\diamond_ca.paa";
            statement = QUOTE([ARR_2(_selectedGroups,'DIAMOND')] call FUNC(setFormation));
            priority = 1;
        };
    };
    class Behaviour {
        displayName = "$STR_3DEN_Group_Attribute_Behaviour_displayName";
        condition = QUOTE(!(_selectedGroups isEqualTo []));
        class Careless {
            displayName = "$STR_3DEN_Attributes_Behaviour_Careless_text";
            icon = QPATHTOF(ui\careless_ca.paa);
            statement = QUOTE([ARR_2(_selectedGroups,'CARELESS')] call FUNC(setBehaviour));
        };
        class Safe {
            displayName = "$STR_safe";
            icon = QPATHTOF(ui\safe_ca.paa);
            iconColor[] = {0, 1, 0, 1};
            statement = QUOTE([ARR_2(_selectedGroups,'SAFE')] call FUNC(setBehaviour));
        };
        class Aware {
            displayName = "$STR_aware";
            icon = QPATHTOF(ui\aware_ca.paa);
            iconColor[] = {1, 1, 0, 1};
            statement = QUOTE([ARR_2(_selectedGroups,'AWARE')] call FUNC(setBehaviour));
        };
        class Combat {
            displayName = "$STR_combat";
            icon = QPATHTOF(ui\combat_ca.paa);
            iconColor[] = {1, 0, 0, 1};
            statement = QUOTE([ARR_2(_selectedGroups,'COMBAT')] call FUNC(setBehaviour));
        };
        class Stealth {
            displayName = "$STR_stealth";
            icon = QPATHTOF(ui\stealth_ca.paa);
            iconColor[] = {0, 1, 1, 1};
            statement = QUOTE([ARR_2(_selectedGroups,'STEALTH')] call FUNC(setBehaviour));
        };
    };
    class Speed {
        displayName = "$STR_HC_Menu_Speed";
        condition = QUOTE(!(_selectedGroups isEqualTo []));
        class Limited {
            displayName = "$STR_speed_limited";
            icon = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeSpeedMode\limited_ca.paa";
            statement = QUOTE([ARR_2(_selectedGroups,'LIMITED')] call FUNC(setSpeed));
            priority = 3;
        };
        class Normal {
            displayName = "$STR_speed_normal";
            icon = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeSpeedMode\normal_ca.paa";
            statement = QUOTE([ARR_2(_selectedGroups,'NORMAL')] call FUNC(setSpeed));
            priority = 2;
        };
        class Full {
            displayName = "$STR_speed_full";
            icon = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeSpeedMode\full_ca.paa";
            statement = QUOTE([ARR_2(_selectedGroups,'FULL')] call FUNC(setSpeed));
            priority = 1;
        };
    };
    class Stance {
        displayName = "$STR_A3_RscAttributeUnitPos_Title";
        condition = QUOTE(_selectedObjects findIf {alive _x && {_x isKindOf 'CAManBase'} && {!isPlayer _x}} != -1);
        class Auto {
            displayName = "$STR_A3_RscAttributeUnitPos_Auto_tooltip";
            icon = QPATHTOF(ui\default_ca.paa);
            statement = QUOTE([ARR_2(_selectedObjects,'AUTO')] call FUNC(setStance));
        };
        class Up {
            displayName = "$STR_A3_RscAttributeUnitPos_Up_tooltip";
            icon = "\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_stand_ca.paa";
            statement = QUOTE([ARR_2(_selectedObjects,'UP')] call FUNC(setStance));
        };
        class Middle {
            displayName = "$STR_A3_RscAttributeUnitPos_Crouch_tooltip";
            icon = "\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_crouch_ca.paa";
            statement = QUOTE([ARR_2(_selectedObjects,'MIDDLE')] call FUNC(setStance));
        };
        class Down {
            displayName = "$STR_A3_RscAttributeUnitPos_Down_tooltip";
            icon = "\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_prone_ca.paa";
            statement = QUOTE([ARR_2(_selectedObjects,'DOWN')] call FUNC(setStance));
        };
    };
    class HealUnits {
        displayName = ECSTRING(modules,ModuleHeal);
        icon = QPATHTOF(ui\medical_cross_ca.paa);
        class All {
            displayName = ECSTRING(common,All);
            statement = QUOTE([ARR_2(_selectedObjects,HEAL_MODE_ALL)] call FUNC(healUnits));
            condition = QUOTE(_selectedObjects findIf {crew _x findIf {_x isKindOf 'CAManBase' && {alive _x}} != -1} != -1);
            icon = QPATHTOF(ui\medical_cross_ca.paa);
            priority = 3;
        };
        class Players {
            displayName = ECSTRING(modules,Players);
            condition = QUOTE(_selectedObjects findIf {crew _x findIf {isPlayer _x && {alive _x}} != -1} != -1);
            statement = QUOTE([ARR_2(_selectedObjects,HEAL_MODE_PLAYERS)] call FUNC(healUnits));
            icon = QPATHTOF(ui\medical_cross_ca.paa);
            priority = 2;
        };
        class AI {
            displayName = "$STR_Team_Switch_AI";
            condition = QUOTE(_selectedObjects findIf {crew _x findIf {!isPlayer _x && {_x isKindOf 'CAManBase'} && {alive _x}} != -1} != -1);
            statement = QUOTE([ARR_2(_selectedObjects,HEAL_MODE_AI)] call FUNC(healUnits));
            icon = QPATHTOF(ui\medical_cross_ca.paa);
            priority = 1;
        };
        priority = -70;
    };
    class VehicleLogistics {
        displayName = CSTRING(VehicleLogistics);
        icon = "\A3\ui_f\data\igui\cfg\simpleTasks\types\truck_ca.paa";
        condition = QUOTE( \
            _selectedObjects findIf { \
                alive _x \
                && {_x isKindOf 'AllVehicles'} \
                && {!(_x isKindOf 'CAManBase')} \
                && { \
                    damage _x > 0 \
                    || { \
                        private _ammo = [_x] call EFUNC(common,getVehicleAmmo); \
                        _ammo != -1 \
                        && {_ammo < 1} \
                    } \
                    || {fuel _x < 1} \
                } \
            } != -1 \
        );
        class Repair {
            displayName = CSTRING(Repair);
            icon = "\A3\ui_f\data\igui\cfg\simpleTasks\types\repair_ca.paa";
            condition = QUOTE(_selectedObjects findIf {damage _x > 0 && {!(_x isKindOf 'CAManBase')}} != -1);
            statement = QUOTE(_selectedObjects call FUNC(repairVehicles));
            priority = 3;
        };
        class Rearm {
            displayName = CSTRING(Rearm);
            icon = "\A3\ui_f\data\igui\cfg\simpleTasks\types\rearm_ca.paa";
            condition = QUOTE(_selectedObjects findIf { \
                    private _ammo = [_x] call EFUNC(common,getVehicleAmmo); \
                    _ammo != -1 \
                    && {_ammo < 1} \
                    && {!(_x isKindOf 'CAManBase')} \
                } != -1 \
            );
            statement = QUOTE(_selectedObjects call FUNC(rearmVehicles));
            priority = 2;
        };
        class Refuel {
            displayName = CSTRING(Refuel);
            icon = "\A3\ui_f\data\igui\cfg\simpleTasks\types\refuel_ca.paa";
            condition = QUOTE(_selectedObjects findIf {fuel _x < 1} != -1);
            statement = QUOTE(_selectedObjects call FUNC(refuelVehicles));
            priority = 1;
        };
        priority = -71;
    };
    class Loadout {
        displayName = "$STR_3den_display3den_entitymenu_arsenal_text";
        icon = "\a3\3den\data\displays\display3den\entitymenu\arsenal_ca.paa";
        condition = QUOTE(_hoveredEntity isEqualType objNull && {_hoveredEntity isKindOf 'CAManBase'} && {alive _hoveredEntity});
        statement = QUOTE(_hoveredEntity call EFUNC(common,openArsenal));
        priority = -80;
        class CopyLoadout {
            displayName = "$STR_3DEN_Display3DEN_MenuBar_EntityCopy_text";
            icon = QPATHTOF(ui\copy_ca.paa);
            statement = QUOTE(GVAR(loadout) = getUnitLoadout _hoveredEntity);
            priority = 2;
        };
        class PasteLoadout {
            displayName = "$STR_3DEN_Display3DEN_MenuBar_EntityPaste_text";
            icon = QPATHTOF(ui\paste_ca.paa);
            condition = QUOTE(!isNil QQGVAR(loadout));
            statement = QUOTE(_hoveredEntity setUnitLoadout GVAR(loadout));
            priority = 1;
        };
    };
    class Inventory {
        displayName = CSTRING(EditInventory);
        icon = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeInventory\filter_0_ca.paa";
        condition = QUOTE( \
            _hoveredEntity isEqualType objNull \
            && {alive _hoveredEntity} \
            && {getNumber (configFile >> 'CfgVehicles' >> typeOf _hoveredEntity >> 'maximumLoad') > 0} \
        );
        statement = QUOTE([ARR_2(_hoveredEntity,'Inventory')] call EFUNC(attributes,open));
        priority = -81;
        class CopyInventory {
            displayName = "$STR_3DEN_Display3DEN_MenuBar_EntityCopy_text";
            icon = QPATHTOF(ui\copy_ca.paa);
            statement = QUOTE(GVAR(inventory) = _hoveredEntity call EFUNC(common,getInventory));
            priority = 2;
        };
        class PasteInventory {
            displayName = "$STR_3DEN_Display3DEN_MenuBar_EntityPaste_text";
            icon = QPATHTOF(ui\paste_ca.paa);
            condition = QUOTE(!isNil QQGVAR(inventory));
            statement = QUOTE([ARR_2(_hoveredEntity, GVAR(inventory))] call EFUNC(common,setInventory));
            priority = 1;
        };
    };
    class Garage {
        displayName = "$STR_3den_display3den_entitymenu_garage_text";
        icon = "\a3\3DEN\Data\Displays\Display3DEN\EntityMenu\garage_ca.paa";
        condition = QUOTE( \
            _hoveredEntity isEqualType objNull \
            && {alive _hoveredEntity} \
            && { \
                _hoveredEntity isKindOf 'LandVehicle' \
                || {_hoveredEntity isKindOf 'Air'} \
                || {_hoveredEntity isKindOf 'Ship'} \
            } \
        );
        statement = QUOTE(_hoveredEntity call EFUNC(garage,openGarage));
        priority = -82;
        class CopyAppearance {
            displayName = "$STR_3DEN_Display3DEN_MenuBar_EntityCopy_text";
            icon = QPATHTOF(ui\copy_ca.paa);
            statement = QUOTE(GVAR(appearances) setVariable [ARR_2(typeOf _hoveredEntity, _hoveredEntity call BIS_fnc_getVehicleCustomization)]);
            priority = 2;
        };
        class PasteAppearance {
            displayName = "$STR_3DEN_Display3DEN_MenuBar_EntityPaste_text";
            icon = QPATHTOF(ui\paste_ca.paa);
            condition = QUOTE(!isNil {GVAR(appearances) getVariable typeOf _hoveredEntity});
            statement = QUOTE( \
                GVAR(appearances) getVariable typeOf _hoveredEntity params [ARR_2('_textures','_animations')]; \
                [ARR_4(_hoveredEntity,_textures,_animations,true)] call BIS_fnc_initVehicle; \
            );
            priority = 1;
        };
    };
    class TeleportPlayers {
        displayName = CSTRING(TeleportPlayers);
        icon = QPATHTOF(ui\marker_ca.paa);
        condition = QUOTE(_selectedObjects findIf {isPlayer _x} != -1);
        statement = QUOTE(_selectedObjects call FUNC(teleportPlayers));
        priority = -99;
    };
    class TeleportZeus {
        displayName = CSTRING(TeleportZeus);
        icon = "\a3\Ui_F_Curator\Data\Logos\arma3_curator_eye_256_ca.paa";
        statement = QUOTE(call FUNC(teleportZeus));
        priority = -100;
    };
};
