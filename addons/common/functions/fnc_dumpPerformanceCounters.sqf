/*
 * Author: ACE-Team, ZEN Team
 * Dumps performance counter statistics into RPT.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_common_fnc_dumpPerformanceCounters
 *
 * Public: No
 */
#include "script_component.hpp"

diag_log text "~~~ ZEN PERFORMANCE COUNTERS DUMP ~~~";

diag_log text "---- REGISTERED ZEN PFH HANDLERS ----";

if (isNil "ZEN_PFH_COUNTER") then {
    diag_log text "None...";
} else {
    {
        _x params ["_id", "_delay", "_file", "_line"];

        private _state = ["ACTIVE", "REMOVED"] select isNil {cba_common_PFHhandles select _id};
        diag_log text format ["%1 - ID = %2, Delay = %3 - %4:%5", _state, _id, _delay, _file, _line];
    } forEach ZEN_PFH_COUNTER;
};

diag_log text "-------- ZEN COUNTER RESULTS --------";

if (isNil "ZEN_COUNTERS") then {
    diag_log text "None...";
} else {
    {
        _x params ["_name", "_results"];

        if (_results isEqualTo []) then {
            diag_log text format ["%1 - No results.", _name];
        } else {
            private _total = 0;
            private _count = count _results;

            {
                _x params ["_start", "_end"];
                _total = _total + (_end - _start);
            } forEach _results;

            private _average = (_total / _count) * 1000;
            diag_log text format ["%1 - Average: %2s / %3 = %4ms", _name, _total, _count, _average];
        };
    } forEach ZEN_COUNTERS;
};
