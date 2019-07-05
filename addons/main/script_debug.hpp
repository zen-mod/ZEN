// FAST RECOMPILING
// #define DISABLE_COMPILE_CACHE
// To Use: [] call ZEN_PREP_RECOMPILE;

#ifdef DISABLE_COMPILE_CACHE
    #define LINKFUNC(x) {_this call FUNC(x)}
    #define PREP_RECOMPILE_START    if (isNil "ZEN_PREP_RECOMPILE") then {ZEN_RECOMPILES = []; ZEN_PREP_RECOMPILE = {{call _x} forEach ZEN_RECOMPILES}}; private _recomp = {
    #define PREP_RECOMPILE_END      }; call _recomp; ZEN_RECOMPILES pushBack _recomp;
#else
    #define LINKFUNC(x) FUNC(x)
    #define PREP_RECOMPILE_START /* */
    #define PREP_RECOMPILE_END /* */
#endif

// PERFORMANCE COUNTERS
// #define ENABLE_PERFORMANCE_COUNTERS
// To Use: [] call zen_common_fnc_dumpPerformanceCounters;

#ifdef ENABLE_PERFORMANCE_COUNTERS
    #define CBA_fnc_addPerFrameHandler { \
        params [["_function", {}, [{}]], ["_delay", 0, [0]], ["_args", []]]; \
        private _id = [_function, _delay, _args] call CBA_fnc_addPerFrameHandler; \
        if (isNil "ZEN_PFH_COUNTER") then {ZEN_PFH_COUNTER = []}; \
        ZEN_PFH_COUNTER pushBack [_id, _delay, __FILE__, __LINE__]; \
        _id \
    }

    #define COUNTER_NAME(x) GVAR(DOUBLES(x,counter))
    #define CREATE_COUNTER(x) if (isNil "ZEN_COUNTERS") then {ZEN_COUNTERS = []}; COUNTER_NAME(x) = [QUOTE(COUNTER_NAME(x)), []]; ZEN_COUNTERS pushBack COUNTER_NAME(x)
    #define BEGIN_COUNTER(x) if (isNil QUOTE(COUNTER_NAME(x))) then {CREATE_COUNTER(x)}; COUNTER_NAME(x) set [2, diag_tickTime]
    #define END_COUNTER(x) (COUNTER_NAME(x) select 1) pushBack [COUNTER_NAME(x) select 2, diag_tickTime]
#else
    #define CREATE_COUNTER(x) /* disabled */
    #define BEGIN_COUNTER(x) /* disabled */
    #define END_COUNTER(x) /* disabled */
#endif
