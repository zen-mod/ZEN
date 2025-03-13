class GVAR(formatters) {
    class Distance {
        class Meter {
            formatter = QUOTE(format [ARR_2('%1 m',_this toFixed 1)]);
            priority = 100;
        };
        class Feet {
            formatter = QUOTE(format [ARR_2('%1 ft',(_this * 3.281) toFixed 1)]);
            priority = 90;
        };
        class Yards {
            formatter = QUOTE(format [ARR_2('%1 yd',(_this * 1.094) toFixed 1)]);
            priority = 80;
        };
        class Mile {
            formatter = QUOTE(format [ARR_2('%1 mi',(_this / 1609.344) toFixed 2)]);
            priority = 70;
        };
    };
    class Azimuth {
        class Degree {
            formatter = QUOTE(format [ARR_2('%1°',_this toFixed 1)]);
            priority = 100;
        };
        class NATOMil {
            formatter = QUOTE(format [ARR_2('%1 mil',(_this * 17.7778) toFixed 0)]);
            priority = 90;
        };
    };
};
