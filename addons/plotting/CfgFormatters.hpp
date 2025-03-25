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
    // Formats speed: _this is distance in meters
    class Speed {
        class Running {
            // Unit with weapon lowered running in fast combat pace: takes ~30 s for 100 m -> 3.333 m/s -> 11.999 km/h
            // This is with ACE mod loaded, without ACE it takes about 27 s for 100 m
            formatter = QUOTE(FORMAT_1('%1 @ 12 km/h',[ARR_2(_this,3.333)] call FUNC(formatTravelTime)));
            priority = 100;
        };
        class VehicleSlow {
            // Vehicle at 30 km/h -> 8.333 m/s
            formatter = QUOTE(FORMAT_1('%1 @ 30 km/h',[ARR_2(_this,8.333)] call FUNC(formatTravelTime)));
            priority = 90;
        };
        class VehicleTown {
            // Vehicle at 50 km/h -> 13.889 m/s
            formatter = QUOTE(FORMAT_1('%1 @ 50 km/h',[ARR_2(_this,13.889)] call FUNC(formatTravelTime)));
            priority = 80;
        };
        class VehicleFast {
            // Vehicle at 100 km/h -> 27.778 m/s
            formatter = QUOTE(FORMAT_1('%1 @ 100 km/h',[ARR_2(_this,27.778)] call FUNC(formatTravelTime)));
            priority = 70;
        };
        class Helicopter {
            // Helicopter at 250 km/h -> 69.444 m/s
            formatter = QUOTE(FORMAT_1('%1 @ 250 km/h',[ARR_2(_this,69.444)] call FUNC(formatTravelTime)));
            priority = 60;
        };
        class Jet {
            // Jet at 600 km/h -> 166.667 m/s
            formatter = QUOTE(FORMAT_1('%1 @ 600 km/h',[ARR_2(_this,166.667)] call FUNC(formatTravelTime)));
            priority = 50;
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
