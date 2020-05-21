// Add hidden Tempest variants
[
   "O_Truck_03_ammo_F",
    format ["%1 (%2)", localize "STR_A3_texturesources_hex0", localize "str_a3_rscdisplayaanarticle_menu_3"],
    [
        "\A3\Soft_F_EPC\Truck_03\Data\Truck_03_ext01_CO.paa",
        "\A3\Soft_F_EPC\Truck_03\Data\Truck_03_ext02_CO.paa",
        "\A3\Soft_F_EPC\Truck_03\Data\Truck_03_cargo_CO.paa",
        "\A3\missions_f_oldman\Data\img\Decals\science_containers_tempest_co.paa"
    ]
] call FUNC(defineCustomTexture);
[
    "O_Truck_03_ammo_F",
    format ["%1 (%2)", localize "STR_A3_texturesources_greenhex0", localize "str_a3_rscdisplayaanarticle_menu_3"],
    [
        "\A3\Soft_F_Exp\Truck_03\Data\Truck_03_ext01_ghex_CO.paa",
        "\A3\Soft_F_Exp\Truck_03\Data\Truck_03_ext02_ghex_CO.paa",
        "\A3\Soft_F_Exp\Truck_03\Data\Truck_03_cargo_ghex_CO.paa",
        "\A3\missions_f_oldman\Data\img\Decals\science_containers_tempest_co.paa"
    ]
] call FUNC(defineCustomTexture);

// Add hidden Taru variants
{
    [
       _x,
        format ["%1 (%2)", localize "str_a3_texturesources_black0", localize "str_a3_rscdisplayaanarticle_menu_3"],
        [
            "A3\Air_F_Heli\Heli_Transport_04\Data\heli_transport_04_base_01_Black_co.paa",
            "A3\Air_F_Heli\Heli_Transport_04\Data\heli_transport_04_base_02_Black_co.paa",
            "A3\missions_f_oldman\Data\img\Decals\science_pods_co.paa",
            "A3\Air_F_Heli\Heli_Transport_04\Data\Heli_Transport_04_Pod_Ext02_Black_CO.paa"
        ]
    ] call FUNC(defineCustomTexture);
} forEach ["O_Heli_Transport_04_covered_F", "O_Heli_Transport_04_medevac_F", "O_Heli_Transport_04_box_F"];

// Add hidden Gorgon variants
[
    "I_APC_Wheeled_03_cannon_F",
    localize "str_a3_texturesources_sand0",
    [
        "A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext_co.paa",
        "A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext2_co.paa",
        "A3\Armor_F_Gamma\APC_Wheeled_03\Data\rcws30_co.paa",
        "A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext_alpha_co.paa"
    ]
] call FUNC(defineCustomTexture);

// Add hidden Blackfoot variants
[
    "B_Heli_Attack_01_dynamicLoadout_F",
    localize "STR_A3_TEXTURESOURCES_OLIVE0",
    [
        "\A3\Air_F_Beta\heli_attack_01\data\heli_attack_01_co.paa"
    ]
] call FUNC(defineCustomTexture);
[
    "B_Heli_Attack_01_dynamicLoadout_F",
    localize "str_a3_texturesources_green0",
    [
        "A3\Air_F\Heli_Light_02\Data\heli_light_02_common_co.paa"
    ]
] call FUNC(defineCustomTexture);
[
    "B_Heli_Attack_01_dynamicLoadout_F",
    localize "str_a3_texturesources_black0",
    [
        "A3\Air_F_Beta\heli_attack_01\data\UI\Heli_Attack_01_EDEN_CA.PAA"
    ]
] call FUNC(defineCustomTexture);

// Add hidden Orca variants
[
    "Heli_Light_02_base_F",
    localize "str_a3_cfgfactionclasses_ind_f0",
    [
        "\a3\air_f\Heli_Light_02\Data\heli_light_02_ext_indp_co.paa"
    ]
] call FUNC(defineCustomTexture);

// Add hidden Pawnee/Hummingbird variants
[
    "Heli_Light_01_base_F",
    localize "str_a3_texturesources_green0",
    [
        "A3\Air_F\Heli_Light_01\Data\Heli_Light_01_ext_Blufor_CO.paa"
    ]
] call FUNC(defineCustomTexture);
[
    "Heli_Light_01_base_F",
    localize "str_a3_texturesources_black0",
    [
        "\a3\air_f\Heli_Light_01\Data\heli_light_01_ext_ion_co.paa"
    ]
] call FUNC(defineCustomTexture);
[
    "Heli_Light_01_base_F",
    localize "str_a3_cfgfactionclasses_ind_f0",
    [
        "A3\Air_F\Heli_Light_01\Data\heli_light_01_ext_indp_co.paa"
    ]
] call FUNC(defineCustomTexture);
