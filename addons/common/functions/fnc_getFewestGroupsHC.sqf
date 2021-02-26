#include "script_component.hpp"
/*
 * Author: Ampersand
 * Returns HC with fewest groups, if available.
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

if !(isServer) exitWith {objNull};

private _HCs = [];
private _HCIDs = [];
private _HCLoad = [];

{
    if (_x isKindOf "HeadlessClient_F") then {
        _HCs pushBack _x;
        _HCIDs pushBack owner _x;
        _HCLoad pushBack 0;
    };
} forEach allPlayers;

switch (count _HCIDs) do {
    case (0): {
        objNull
    };
    case (1): {
        _HCIDs select 0;
    };
    default {
        // Count local groups for each HC
        {
            private _HCIndex = _HCIDs find groupOwner _x;
            if (_HCIndex > -1) then {
                private _groupCount = _HCLoad select _HCIndex;
                _HCLoad set [_HCIndex, _groupCount + 1];
            };
        } forEach allGroups;

        _HCs select (_HCLoad find selectMin _HCLoad)
    };
};
