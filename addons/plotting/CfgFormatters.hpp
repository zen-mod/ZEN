class GVAR(formatters) {
    class Distance {
        class Meter {
            formatter = QUOTE(format [ARR_2('%1 m',_value toFixed 1)]);
            priority = 100;
        };
        class Feet {
            formatter = QUOTE(format [ARR_2('%1 ft',(_value * 3.281) toFixed 1)]);
            priority = 90;
        };
        class Yards {
            formatter = QUOTE(format [ARR_2('%1 yd',(_value * 1.094) toFixed 1)]);
            priority = 80;
        };
        class Mile {
            formatter = QUOTE(format [ARR_2('%1 mi',(_value / 1609.344) toFixed 2)]);
            priority = 70;
        };
    };
    class Azimuth {
        class Degree {
            formatter = QUOTE(format [ARR_2('%1°',_value toFixed 1)]);
            priority = 100;
        };
        class NATOMil {
            formatter = QUOTE(format [ARR_2('%1 mil',(_value * 17.7778) toFixed 0)]);
            priority = 90;
        };
    };
};
