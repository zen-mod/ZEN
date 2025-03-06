class GVAR(formatters) {
    class Distance {
        class Meter {
            displayName = CSTRING(FormatterName_Distance_Meter);
            formatter = QUOTE(format [ARR_2('%1 m',_value toFixed 1)]);
            priority = 100;
        };
        class Feet {
            displayName = CSTRING(FormatterName_Distance_Feet);
            formatter = QUOTE(format [ARR_2('%1 ft',(_value * 3.281) toFixed 1)]);
            priority = 90;
        };
        class NauticalMile {
            displayName = CSTRING(FormatterName_Distance_NauticalMile);
            formatter = QUOTE(format [ARR_2('%1 NM',(_value / 1852) toFixed 2)]);
            priority = 80;
        };
    };
    class Azimuth {
        class Degree {
            displayName = CSTRING(FormatterName_Azimuth_Degree);
            formatter = QUOTE(format [ARR_2('%1°',_value toFixed 1)]);
            priority = 100;
        };
        class NATOMil {
            displayName = CSTRING(FormatterName_Azimuth_NATOMil);
            formatter = QUOTE(format [ARR_2('%1 mil',(_value * 17.7778) toFixed 0)]);
            priority = 90;
        };
    };
};
