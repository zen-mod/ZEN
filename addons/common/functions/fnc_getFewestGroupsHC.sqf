#include "script_component.hpp"
/*
 * Author: Ampersand
 * Returns the headless client with the fewest local groups. objNull if none are available.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Headless Client <OBJECT>
 *
 * Example:
 * [] call zen_common_fnc_getFewestGroupsHC
 *
 * Public: No
 */

if (!isServer) exitWith {objNull};

private _hcs = [];
private _hcIDs = [];
private _hcLoad = [];

{
    if (_x isKindOf "HeadlessClient_F") then {
        _hcs pushBack _x;
        _hcIDs pushBack owner _x;
        _hcLoad pushBack 0;
    };
} forEach allPlayers;

switch (count _hcIDs) do {
    case 0: {
        objNull
    };
    case 1: {
        _hcs select 0
    };
    default {
        // Count local groups for each HC
        {
            private _hcIndex = _hcIDs find groupOwner _x;
            if (_hcIndex != -1) then {
                private _groupCount = _hcLoad select _hcIndex;
                _hcLoad set [_hcIndex, _groupCount + 1];
            };
        } forEach allGroups;

        _hcs select (_hcLoad find selectMin _hcLoad)
    };
};
