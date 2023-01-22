#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles placement of an object by Zeus.
 *
 * Arguments:
 * 0: Curator (not used) <OBJECT>
 * 1: Placed Object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_curator, _object] call zen_editor_fnc_handleObjectPlaced
 *
 * Public: No
 */

params ["", "_object"];

// Re-collapse the entities tree if editable icons are hidden
// Placing an object expands a portion of the tree
if (!GVAR(iconsVisible)) then {
    private _ctrlEntites = findDisplay IDD_RSCDISPLAYCURATOR displayCtrl IDC_RSCDISPLAYCURATOR_ENTITIES;
    _ctrlEntites call EFUNC(common,collapseTree);
};

RscDisplayCurator_sections params ["_mode"];

if (!GVAR(includeCrew) && {_mode == 0 || {_mode == 4 && {isClass (configFile >> "CfgVehicles" >> GVAR(recentTreeData))}}}) then {
    deleteVehicleCrew _object;
};

private _group = group _object;

if (!isNull _group && {!isGroupDeletedWhenEmpty _group}) then {
    _group deleteGroupWhenEmpty true;
};

// If crewed aircraft is placed using the map at a position that is over water or outside of the map, spawn it flying
#define SAFESPEED 100
if (visibleMap && {GVAR(includeCrew) && {_object isKindOf "Air" && {
    surfaceIsWater position _object || {
    position _object params ["_x", "_y"];
    _x < 0 || {
    _x > worldSize || {
    _y < 0 || {
    _y > worldSize}}}}
}}}) then {
    _object setVehiclePosition [_object, [], 0, "FLY"];
    if (_object isKindOf "Plane") then {
        _object setVelocityModelSpace [0, SAFESPEED, 0];
    };
};
