class zen_context_menu_actions {
    class ace_medical_menu {
        displayName = CSTRING(openMedicalMenu);
        icon = QPATHTOEF(context_actions,ui\medical_cross_ca.paa);
        condition = QUOTE([_hoveredEntity] call FUNC(canOpenMedicalMenu));
        statement = QUOTE([_hoveredEntity] call FUNC(openMedicalMenu));
        priority = 51;
    };  
};
