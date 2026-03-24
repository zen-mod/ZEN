#include "script_component.hpp"
/*
 * Author: mharis001
 * Parses the given magazine detail string and returns the magazine's ID and creator.
 *
 * Arguments:
 * 0: Magazine Detail <STRING>
 *
 * Return Value:
 * Parsed Data <ARRAY>
 *   0: ID <NUMBER>
 *   1: Creator <NUMBER>
 *
 * Example:
 * ["6.5 mm 30Rnd Sand Mag(30/30)[id/cr:10000001/0]"] call zen_common_fnc_parseMagazineDetail
 *
 * Public: No
 */

params [["_magazine", "", [""]]];

private _split = _magazine splitString "[:/]";
_split select [count _split - 2, 2] apply {parseNumber _x}
