#include "script_component.hpp"

#define CUSTOM_MODULE(id) QUOTE(DOUBLES(GVAR(module),id))

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {
            CUSTOM_MODULE(1),
            CUSTOM_MODULE(2),
            CUSTOM_MODULE(3),
            CUSTOM_MODULE(4),
            CUSTOM_MODULE(5),
            CUSTOM_MODULE(6),
            CUSTOM_MODULE(7),
            CUSTOM_MODULE(8),
            CUSTOM_MODULE(9),
            CUSTOM_MODULE(10),
            CUSTOM_MODULE(11),
            CUSTOM_MODULE(12),
            CUSTOM_MODULE(13),
            CUSTOM_MODULE(14),
            CUSTOM_MODULE(15),
            CUSTOM_MODULE(16),
            CUSTOM_MODULE(17),
            CUSTOM_MODULE(18),
            CUSTOM_MODULE(19),
            CUSTOM_MODULE(20),
            CUSTOM_MODULE(21),
            CUSTOM_MODULE(22),
            CUSTOM_MODULE(23),
            CUSTOM_MODULE(24),
            CUSTOM_MODULE(25),
            CUSTOM_MODULE(26),
            CUSTOM_MODULE(27),
            CUSTOM_MODULE(28),
            CUSTOM_MODULE(29),
            CUSTOM_MODULE(30),
            CUSTOM_MODULE(31),
            CUSTOM_MODULE(32),
            CUSTOM_MODULE(33),
            CUSTOM_MODULE(34),
            CUSTOM_MODULE(35),
            CUSTOM_MODULE(36),
            CUSTOM_MODULE(37),
            CUSTOM_MODULE(38),
            CUSTOM_MODULE(39),
            CUSTOM_MODULE(40),
            CUSTOM_MODULE(41),
            CUSTOM_MODULE(42),
            CUSTOM_MODULE(43),
            CUSTOM_MODULE(44),
            CUSTOM_MODULE(45),
            CUSTOM_MODULE(46),
            CUSTOM_MODULE(47),
            CUSTOM_MODULE(48),
            CUSTOM_MODULE(49),
            CUSTOM_MODULE(50),
            CUSTOM_MODULE(51),
            CUSTOM_MODULE(52),
            CUSTOM_MODULE(53),
            CUSTOM_MODULE(54),
            CUSTOM_MODULE(55),
            CUSTOM_MODULE(56),
            CUSTOM_MODULE(57),
            CUSTOM_MODULE(58),
            CUSTOM_MODULE(59),
            CUSTOM_MODULE(60),
            CUSTOM_MODULE(61),
            CUSTOM_MODULE(62),
            CUSTOM_MODULE(63),
            CUSTOM_MODULE(64),
            CUSTOM_MODULE(65),
            CUSTOM_MODULE(66),
            CUSTOM_MODULE(67),
            CUSTOM_MODULE(68),
            CUSTOM_MODULE(69),
            CUSTOM_MODULE(70),
            CUSTOM_MODULE(71),
            CUSTOM_MODULE(72),
            CUSTOM_MODULE(73),
            CUSTOM_MODULE(74),
            CUSTOM_MODULE(75),
            CUSTOM_MODULE(76),
            CUSTOM_MODULE(77),
            CUSTOM_MODULE(78),
            CUSTOM_MODULE(79),
            CUSTOM_MODULE(80),
            CUSTOM_MODULE(81),
            CUSTOM_MODULE(82),
            CUSTOM_MODULE(83),
            CUSTOM_MODULE(84),
            CUSTOM_MODULE(85),
            CUSTOM_MODULE(86),
            CUSTOM_MODULE(87),
            CUSTOM_MODULE(88),
            CUSTOM_MODULE(89),
            CUSTOM_MODULE(90),
            CUSTOM_MODULE(91),
            CUSTOM_MODULE(92),
            CUSTOM_MODULE(93),
            CUSTOM_MODULE(94),
            CUSTOM_MODULE(95),
            CUSTOM_MODULE(96),
            CUSTOM_MODULE(97),
            CUSTOM_MODULE(98),
            CUSTOM_MODULE(99),
            CUSTOM_MODULE(100)
        };
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"zen_modules"};
        author = ECSTRING(main,Author);
        authors[] = {"mharis001"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

PRELOAD_ADDONS;

#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"
