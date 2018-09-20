class EGVAR(context_menu,actions) {
    class Stance {
        displayName = "$STR_A3_RscAttributeUnitPos_Title";
        condition = QUOTE(_selectedObjects findIf {_x isKindOf 'CAManBase' && {!isPlayer _x}} > -1);
        class Auto {
            displayName = "$STR_A3_RscAttributeUnitPos_Auto_tooltip";
            icon = QPATHTOF(UI\default_ca.paa);
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
    class TeleportZeus {
        displayName = CSTRING(TeleportZeus);
        icon = "\a3\Ui_F_Curator\Data\Logos\arma3_curator_eye_256_ca.paa";
        statement = QUOTE(call FUNC(teleportZeus));
        priority = -100;
    };
};
