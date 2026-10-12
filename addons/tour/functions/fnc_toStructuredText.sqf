#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns structured text for the given text.
 * Expands {key} tokens into keycaps (e.g., {ctrl}, {lmb}) and <b> tags into bold text.
 *
 * Arguments:
 * 0: Text <STRING>
 *
 * Return Value:
 * Structured Text <TEXT>
 *
 * Example:
 * ["Hold {ctrl} and <b>click</b>"] call zen_tour_fnc_toStructuredText
 *
 * Public: No
 */

params ["_text"];

// Strings from config arrays are not localized automatically
if (isLocalized _text) then {
    _text = localize _text;
};

// Keycaps are white like bold text, so they stand out from the surrounding text
// Regex replacements treat backslashes as escapes, so the path is inserted with a plain replacement
_text = _text regexReplace ["\{([a-z0-9]+)\}/gi", "<img image='%KEYS%${1}_ca.paa' color='#ffffff'/>"];
_text = [_text, "%KEYS%", QPATHTOF(ui\keys\)] call CBA_fnc_replace;
_text = _text regexReplace ["<b>/gi", "<t font='RobotoCondensedBold' color='#ffffff'>"];
_text = _text regexReplace ["</b>/gi", "</t>"];

parseText _text
