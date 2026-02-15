class GVAR(formatters) {
    // Formats distance: _this is distance in meters
    class Distance {
        class Meter {
            formatter = QUOTE(FORMAT_1('%1 m',[ARR_3(_this,1,parseNumber (abs _this < 100))] call CBA_fnc_formatNumber));
            priority = 100;
        };
        class Feet {
            formatter = QUOTE(FORMAT_1('%1 ft',[ARR_3(_this * 3.281,1,0)] call CBA_fnc_formatNumber));
            priority = 90;
        };
    };

    // Formats custom speeds: _this is [distance (m), speed (m/s)]
    class Speed {
        class kmh {
            formatter = QUOTE(call FUNC(formatSpeedKmh));
            priority = 100;

            // Defines static speeds for this format to cycle through when plot is not attached to object
            // Must have at least one entry
            speeds[] = {
                3.333,      // Unit with weapon lowered running in fast combat pace: takes ~12 km/h -> 3.333 m/s. This is with ACE mod loaded. Without ACE, the unit is a bit faster.
                8.333,      // Vehicle at 30 km/h
                13.889,     // Vehicle at 50 km/h
                27.778,     // Vehicle at 100 km/h
                69.444,     // Helicopter at 250 km/h
                166.667,    // Jet at 600 km/h
            };
        };
    };

    // Formats direction: _this is direction in the range 0..360 degrees.
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
