class EGVAR(context_menu,actions) {
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
        condition = QUOTE(_selectedObjects findIf {_x isKindOf 'CAManBase' && {!isPlayer _x}} > -1);
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
    class Arsenal {
        displayName = "$STR_3den_display3den_entitymenu_arsenal_text";
        icon = "\a3\3den\data\displays\display3den\entitymenu\arsenal_ca.paa";
        condition = QUOTE(_hoveredEntity isEqualType objNull && {_hoveredEntity isKindOf 'CAManBase'} && {alive _hoveredEntity});
        statement = QUOTE(_hoveredEntity call EFUNC(common,openArsenal));
        priority = -80;
    };
    class TeleportZeus {
        displayName = CSTRING(TeleportZeus);
        icon = "\a3\Ui_F_Curator\Data\Logos\arma3_curator_eye_256_ca.paa";
        statement = QUOTE(call FUNC(teleportZeus));
        priority = -100;
    };
};
