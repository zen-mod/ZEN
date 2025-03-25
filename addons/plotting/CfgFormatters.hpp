class GVAR(formatters) {
    class Distance {
        class Meter {
            formatter = QUOTE(FORMAT_1('%1 m',[ARR_4(_this,1,parseNumber (_this < 100),true)] call CBA_fnc_formatNumber));
            priority = 100;
        };
        class Feet {
            formatter = QUOTE(FORMAT_1('%1 ft',[ARR_4(_this * 3.281,1,0,true)] call CBA_fnc_formatNumber));
            priority = 90;
        };
    };
    class Azimuth {
        class Degree {
            formatter = QUOTE(FORMAT_1('%1°',_this toFixed 0));
            priority = 100;
        };
        class NATOMil {
            formatter = QUOTE(FORMAT_1('%1 mil',(_this * 17.7778) toFixed 0));
            priority = 90;
        };
    };
};
