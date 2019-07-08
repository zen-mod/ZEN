#include "script_component.hpp"
/*
 * Author: mharis001
 * Compiles a list of markers sorted by category.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_markers_tree_fnc_compile
 *
 * Public: No
 */

// Exit if markers tree has already been compiled
if (!isNil {uiNamespace getVariable QGVAR(cache)}) exitWith {};

private _cache = [];
private _cfgMarkerClasses = configFile >> "CfgMarkerClasses";

{
    if (getNumber (_x >> "scope") > 0 && {getText (_x >> "markerClass") != ""}) then {
        private _class = configName _x;
        private _name  = getText (_x >> "name");
        private _icon  = getText (_x >> "icon");
        private _color = getArray (_x >> "color") apply {if (_x isEqualType "") then {call compile _x} else {_x}};
        private _category = getText (_cfgMarkerClasses >> getText (_x >> "markerClass") >> "displayName");

        // Special handling and checking for colors to improve visuals of tree
        if (count _color != 4 || {!(_color isEqualTypeAll 0)} || {_color isEqualTo [0, 0, 0, 1]}) then {
            _color = [1, 1, 1, 1];
        };

        private _index = _cache findIf {_x select 0 == _category};
        private _data  = [_class, _name, _icon, _color];

        if (_index == -1) then {
            _cache pushBack [_category, [_data]];
        } else {
            (_cache select _index select 1) pushBack _data;
        };
    };
} forEach configProperties [configFile >> "CfgMarkers", "isClass _x"];

uiNamespace setVariable [QGVAR(cache), _cache];
