#include "script_component.hpp"
/*
 * Author: Ampersand, mharis001
 * Draws a hint that contains icon and line elements in 2D (Zeus display map)
 * and 3D (in world) for the given duration.
 *
 * Will overwrite an existing hint when called using the same ID. Position
 * arguments can be given as OBJECTs, in which case the hint elements will
 * follow objects as they move and will be hidden if the object is deleted.
 *
 * The visual properties for "ICON" elements are:
 *   0: Position <ARRAY|OBJECT>
 *   1: Icon Texture <STRING>
 *   2: Color (RGBA) <ARRAY> (default: [1, 1, 1, 1])
 *   3: Scale <NUMBER> (default: 1)
 *   4: Angle <NUMBER> (default: 0)
 *   5: Text <STRING> (default: "")
 *   6: Shadow <NUMBER|BOOL> (default: 0)
 *   7: Text Size <NUMBER> (default: 0.05)
 *   8: Font <STRING> (default: "RobotoCondensed")
 *   9: Align <STRING> (default: "center")
 *
 * The visual properties for "LINE" elements are:
 *   0: Start Position <ARRAY|OBJECT>
 *   1: End Position <ARRAY|OBJECT>
 *   2: Color (RGBA) <ARRAY> (default: [1, 1, 1, 1])
 *
 * Arguments:
 * 0: Elements <ARRAY>
 *   0: Type <STRING>
 *     - either "ICON" or "LINE".
 *   1: Visual Properties <ARRAY>
 *     - depends on element type (see above for details).
 * 1: Duration (in seconds) <NUMBER>
 * 2: ID <STRING|OBJECT> (default: "")
 *   - an ID is generated when an empty string is given.
 *   - in the case of an OBJECT, the hash value is used.
 * 3: Duration of fade out (in seconds). Fade out will occur within show duration <NUMBER> (default: 0)
 *
 * Return Value:
 * ID <STRING>
 *
 * Example:
 * [["ICON", [_unit, _texture]], 3] call zen_common_fnc_drawHint
 *
 * Public: No
 */

#define MAP_ICON_SIZE 24

params [
    ["_elements", [], [[]]],
    ["_duration", 0, [0]],
    ["_id", "", ["", objNull]],
    ["_fadeOut", 0, [0]]
];

private _ctrlMap = findDisplay IDD_RSCDISPLAYCURATOR displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;

// Map of hint IDs and their corresponding draw (2D and 3D) event handler IDs
if (isNil QGVAR(drawHintMap)) then {
    GVAR(drawHintMap) = createHashMap;
};

// Use an object's hash value as its hint ID
if (_id isEqualType objNull) then {
    _id = hashValue _id;
};

// Generate a hint ID if one is not given
if (_id isEqualTo "") then {
    if (isNil QGVAR(drawHintCounter)) then {
        GVAR(drawHintCounter) = -1;
    };

    GVAR(drawHintCounter) = GVAR(drawHintCounter) + 1;

    _id = [CBA_clientID, GVAR(drawHintCounter)] joinString ":";
};

// Remove an existing hint with the same ID
if (_id in GVAR(drawHintMap)) then {
    GVAR(drawHintMap) deleteAt _id params ["_id2D", "_id3D"];

    _ctrlMap ctrlRemoveEventHandler ["Draw", _id2D];
    removeMissionEventHandler ["Draw3D", _id3D];
};

// Validate the given hint elements and separate them by type
private _icons = [];
private _lines = [];

{
    _x params [["_type", "", [""]], ["_args", [], [[]]]];

    switch (_type) do {
        case "ICON": {
            _args params [
                ["_position", [0, 0, 0], [[], objNull], 3],
                ["_icon", "", [""]],
                ["_color", [1, 1, 1, 1], [[]], 4],
                ["_scale", 1, [0]],
                ["_angle", 0, [0]],
                ["_text", "", [""]],
                ["_shadow", 0, [0, false]],
                ["_textSize", 0.05, [0]],
                ["_font", "RobotoCondensed", [""]],
                ["_align", "center", [""]]
            ];

            _icons pushBack [_position, _icon, _color, _scale, _angle, _text, _shadow, _textSize, _font, _align];
        };
        case "LINE": {
            _args params [
                ["_begPos", [0, 0, 0], [[], objNull], 3],
                ["_endPos", [0, 0, 0], [[], objNull], 3],
                ["_color", [1, 1, 1, 1], [[]], 4]
            ];

            _lines pushBack [_begPos, _endPos, _color];
        };
        default {
            ERROR_1("Invalid hint element type - %1.",_type);
        };
    };
} forEach _elements;

// Add event handlers to draw the hint elements
private _fnc_draw2D = {
    params ["_ctrlMap"];
    _thisArgs params ["_icons", "_lines", "_endTime", "_fadeOutTime"];

    // No drawing if in screenshot mode
    if (call EFUNC(common,isInScreenshotMode)) exitWith {};

    private _time = CBA_missionTime;

    {
        _x params ["_position", "_icon", "_color", "_scale", "_angle", "_text", "_shadow", "_textSize", "_font", "_align"];

        if (_position isEqualTo objNull) then {continue};

        // Handle fade out
        private _a = linearConversion [_fadeOutTime, _endTime, _time, _color select 3, 0, true];
        private _newColor = (_color select [0, 3]) + [_a];

        _ctrlMap drawIcon [_icon, _newColor, _position, _scale * MAP_ICON_SIZE, _scale * MAP_ICON_SIZE, _angle, _text, _shadow, _textSize, _font, _align];
    } forEach _icons;

    {
        _x params ["_begPos", "_endPos", "_color"];

        if (objNull in [_begPos, _endPos]) then {continue};

        // Handle fade out
        private _a = linearConversion [_fadeOutTime, _endTime, _time, _color select 3, 0, true];
        private _newColor = (_color select [0, 3]) + [_a];

        _ctrlMap drawLine [_begPos, _endPos, _newColor];
    } forEach _lines;
};

private _fnc_draw3D = {
    _thisArgs params ["_icons", "_lines", "_endTime", "_fadeOutTime", "_id"];

    // Exit if the Zeus display is closed or hint duration is complete
    private _time = CBA_missionTime;
    if (isNull curatorCamera || {_time >= _endTime}) exitWith {
        GVAR(drawHintMap) deleteAt _id params ["_id2D", "_id3D"];

        private _ctrlMap = findDisplay IDD_RSCDISPLAYCURATOR displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;
        _ctrlMap ctrlRemoveEventHandler ["Draw", _id2D];
        removeMissionEventHandler ["Draw3D", _id3D];
    };

    // No 3D drawing needed if the map is visible
    if (visibleMap) exitWith {};

    {
        _x params ["_position", "_icon", "_color", "_scale", "_angle", "_text", "_shadow", "_textSize", "_font", "_align"];

        if (_position isEqualTo objNull) then {continue};

        if (_position isEqualType objNull) then {
            _position = unitAimPositionVisual _position;
        };

        // Handle fade out
        private _a = linearConversion [_fadeOutTime, _endTime, _time, _color select 3, 0, true];
        private _newColor = (_color select [0, 3]) + [_a];

        drawIcon3D [_icon, _newColor, _position, _scale, _scale, _angle, _text, _shadow, _textSize, _font, _align];
    } forEach _icons;

    {
        _x params ["_begPos", "_endPos", "_color"];

        if (objNull in [_begPos, _endPos]) then {continue};

        if (_begPos isEqualType objNull) then {
            _begPos = unitAimPositionVisual _begPos;
        };

        if (_endPos isEqualType objNull) then {
            _endPos = unitAimPositionVisual _endPos;
        };

        // Handle fade out
        private _a = linearConversion [_fadeOutTime, _endTime, _time, _color select 3, 0, true];
        private _newColor = (_color select [0, 3]) + [_a];

        drawLine3D [_begPos, _endPos, _newColor];
    } forEach _lines;
};

private _endTime = CBA_missionTime + _duration;
// Fade out will be performed within show duration; clip _fadeout value between 0 and duration.
private _fadeOutTime = _endTime - ((_fadeOut min _duration) max 0);

private _args = [_icons, _lines, _endTime, _fadeOutTime, _id];
private _id2D = [_ctrlMap, "Draw", _fnc_draw2D, _args] call CBA_fnc_addBISEventHandler;
private _id3D = [missionNamespace, "Draw3D", _fnc_draw3D, _args] call CBA_fnc_addBISEventHandler;
GVAR(drawHintMap) set [_id, [_id2D, _id3D]];

// Return the hint ID (in case a generated one was used)
_id
