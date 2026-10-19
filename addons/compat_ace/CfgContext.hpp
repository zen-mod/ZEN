class EGVAR(context_menu,actions) {
    class AceMedicalMenu {
        displayName = CSTRING(OpenMedicalMenu);
        icon = QPATHTOEF(context_actions,ui\medical_cross_ca.paa);
        condition = QUOTE(_hoveredEntity call FUNC(canOpenMedicalMenu));
        statement = QUOTE(_hoveredEntity call FUNC(openMedicalMenu));
        priority = 51;
    };  
};
