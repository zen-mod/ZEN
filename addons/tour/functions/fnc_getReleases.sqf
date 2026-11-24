#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns releases sorted from newest to oldest by their version.
 * Can be limited to releases newer than the given version.
 *
 * Arguments:
 * 0: Newer Than <STRING> (default: "")
 *   - Version in the MAJOR.MINOR.PATCH format, or an empty string for all releases.
 *
 * Return Value:
 * Releases <ARRAY>
 *
 * Example:
 * ["1.15.0"] call zen_tour_fnc_getReleases
 *
 * Public: No
 */

params [["_newerThan", "", [""]]];

// Versions are compared as numbers for each part, so that 1.10.0 is newer than 1.9.0
private _fnc_parseVersion = {
    private _version = _this splitString "." apply {parseNumber _x};
    _version resize [3, 0];
    _version
};

// Checks if the first version is newer than the second, comparing each part in order
private _fnc_isNewer = {
    params ["_version", "_other"];

    private _isNewer = false;

    {
        private _otherPart = _other select _forEachIndex;

        if (_x != _otherPart) exitWith {
            _isNewer = _x > _otherPart;
        };
    } forEach _version;

    _isNewer
};

// Sorting ignores the config at the end of each release, so they are sorted by version
private _releases = configProperties [configFile >> QGVAR(releases), "isClass _x"] apply {
    (getText (_x >> "version") call _fnc_parseVersion) + [_x]
};

_releases sort false;

if (_newerThan != "") then {
    private _newerThanVersion = _newerThan call _fnc_parseVersion;

    _releases = _releases select {
        [_x select [0, 3], _newerThanVersion] call _fnc_isNewer
    };
};

_releases apply {_x select -1}
