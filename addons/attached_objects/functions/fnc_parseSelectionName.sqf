#include "script_component.hpp"
/*
 * Author: Ampersand
 * Attempt to translate Czech selection names.
 *
 * Arguments:
 * 0: Selection Name <STRING>
 *
 * Return Value:
 * 0: Translated Name <STRING>
 *
 * Example:
 * [_selection] call zen_attached_objects_fnc_parseSelectionName
 *
 * Public: No
 */

params ["_selection"];

{
    _selection = _selection regexReplace [_x, localize (LSTRING(Czech) + _x) + " "];
} forEach [
    "hlavne",
    "hlaven",
    "kola",
    "konec",
    "leveho",
    "leve",
    "nabojnice",
    "optika",
    "osa",
    "otoc",
    "poklop",
    "praveho",
    "prave",
    "predniho",
    "raketa",
    "slapek",
    "slapky",
    "smerovky",
    "svetlo",
    "vejskovky",
    "velitele",
    "veze",
    "vez",
    "vrtule"
];

(_selection splitString " _") joinString " "
