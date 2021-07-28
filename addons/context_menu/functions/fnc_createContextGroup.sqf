#include "script_component.hpp"
/*
 * Author: mharis001
 * Creates a context group with rows of actions.
 *
 * Arguments:
 * 0: Actions <ARRAY>
 * 1: Context Level <NUMBER> (default: 0)
 * 2: Parent Row <CONTROL> (default: controlNull)
 *
 * Return Value:
 * None
 *
 * Example:
 * [_actions] call zen_context_menu_fnc_createContextGroup
 *
 * Public: No
 */

params ["_actions", ["_contextLevel", 0], ["_parentRow", controlNull]];

// Exit if no context actions are provided
if (_actions isEqualTo []) exitWith {};

// Create context group control
private _display = findDisplay IDD_RSCDISPLAYCURATOR;
private _ctrlContextGroup = _display ctrlCreate [QGVAR(group), IDC_CONTEXT_GROUP];

// Assign context level and store context group
_ctrlContextGroup setVariable [QGVAR(level), _contextLevel];
GVAR(contextGroups) set [_contextLevel, _ctrlContextGroup];

// Keep track of the maximum text width among all rows
private _textWidth = POS_W(5.9);

// Create context action rows
private _contextRows = [];

{
    _x params ["_action", "_children"];
    _action params ["", "_displayName", "_icon", "_iconColor", "_statement", "_condition", "_args"];

    // Create context row control
    private _ctrlContextRow = _display ctrlCreate [QGVAR(row), IDC_CONTEXT_ROW, _ctrlContextGroup];
    _contextRows pushBack _ctrlContextRow;

    // Set action name and icon
    private _ctrlName = _ctrlContextRow controlsGroupCtrl IDC_CONTEXT_NAME;
    _ctrlName ctrlSetText _displayName;

    private _ctrlIcon = _ctrlContextRow controlsGroupCtrl IDC_CONTEXT_ICON;
    _ctrlIcon ctrlSetTextColor _iconColor;
    _ctrlIcon ctrlSetText _icon;

    _textWidth = _textWidth max ctrlTextWidth _ctrlName;

    // Hide expandable icon if no children actions
    if (_children isEqualTo []) then {
        private _ctrlExpandable = _ctrlContextRow controlsGroupCtrl IDC_CONTEXT_EXPANDABLE;
        _ctrlExpandable ctrlShow false;
    };

    // Add mouse area EHs
    private _ctrlMouse = _ctrlContextRow controlsGroupCtrl IDC_CONTEXT_MOUSE;
    _ctrlMouse ctrlAddEventHandler ["MouseEnter", {
        params ["_ctrlMouse"];

        private _ctrlContextRow = ctrlParentControlsGroup _ctrlMouse;
        private _ctrlContextGroup = ctrlParentControlsGroup _ctrlContextRow;

        // Update highlight color
        private _ctrlHighlight = _ctrlContextRow controlsGroupCtrl IDC_CONTEXT_HIGHLIGHT;
        _ctrlHighlight ctrlSetBackgroundColor [0, 0, 0, 1];

        // Close previously opened child context groups
        private _contextLevel = _ctrlContextGroup getVariable QGVAR(level);
        for "_i" from (_contextLevel + 1) to (count GVAR(contextGroups) - 1) do {
            ctrlDelete (GVAR(contextGroups) select _i);
        };

        // Create child context group if action has children
        private _children = _ctrlContextRow getVariable QGVAR(children);
        if (_children isNotEqualTo []) then {
            [_children, _contextLevel + 1, _ctrlContextRow] call FUNC(createContextGroup);
        };
    }];

    _ctrlMouse ctrlAddEventHandler ["MouseExit", {
        params ["_ctrlMouse"];

        private _ctrlContextRow = ctrlParentControlsGroup _ctrlMouse;

        // Update highlight color
        private _ctrlHighlight = _ctrlContextRow controlsGroupCtrl IDC_CONTEXT_HIGHLIGHT;
        _ctrlHighlight ctrlSetBackgroundColor [0, 0, 0, 0];
    }];

    _ctrlMouse ctrlAddEventHandler ["MouseButtonDown", {
        params ["_ctrlMouse", "_button"];

        if (_button isEqualTo 0) then {
            private _ctrlContextRow = ctrlParentControlsGroup _ctrlMouse;
            (_ctrlContextRow getVariable QGVAR(params)) params ["_condition", "_statement", "_args"];

            // Exit on empty statement, the menu should not close when the action does nothing
            if (_statement isEqualTo {}) exitWith {};

            SETUP_ACTION_VARS;

            if (ACTION_PARAMS call _condition) then {
                ACTION_PARAMS call _statement;
            };

            FUNC(close) call CBA_fnc_execNextFrame;
        };
    }];

    _ctrlContextRow setVariable [QGVAR(params), [_condition, _statement, _args]];
    _ctrlContextRow setVariable [QGVAR(children), _children];
} forEach _actions;

// Update positioning of context rows based on the maximum text width
private _posW = _textWidth + POS_W(2.1);
private _posH = POS_H(count _actions);

{
    private _ctrlContextRow = _x;
    _ctrlContextRow ctrlSetPositionY POS_H(_forEachIndex);
    _ctrlContextRow ctrlSetPositionW _posW;
    _ctrlContextRow ctrlCommit 0;

    private _ctrlHighlight = _ctrlContextRow controlsGroupCtrl IDC_CONTEXT_HIGHLIGHT;
    _ctrlHighlight ctrlSetPositionW _posW;
    _ctrlHighlight ctrlCommit 0;

    private _ctrlName = _ctrlContextRow controlsGroupCtrl IDC_CONTEXT_NAME;
    _ctrlName ctrlSetPositionW _textWidth;
    _ctrlName ctrlCommit 0;

    private _ctrlMouse = _ctrlContextRow controlsGroupCtrl IDC_CONTEXT_MOUSE;
    _ctrlHighlight ctrlSetPositionW _posW;
    _ctrlHighlight ctrlCommit 0;

    private _ctrlExpandable = _ctrlContextRow controlsGroupCtrl IDC_CONTEXT_EXPANDABLE;
    _ctrlExpandable ctrlSetPositionX (_posW - POS_W(1));
    _ctrlExpandable ctrlCommit 0;
} forEach _contextRows;

// Update the context group background's position
private _ctrlBackground = _ctrlContextGroup controlsGroupCtrl IDC_CONTEXT_BACKGROUND;
_ctrlBackground ctrlSetPosition [0, 0, _posW, _posH];
_ctrlBackground ctrlCommit 0;

// Update the context group's position
private _groupPosition = if (isNull _parentRow) then {
    // No parent row, position is based on mouse position when the menu was opened
    GVAR(mousePos) params ["_posX", "_posY"];

    // Apply a one pixel right, one pixel down offset so an option is not selected by default
    _posX = safeZoneX + SPACING_W max (_posX + pixelW min (safeZoneX + safeZoneW - _posW - SPACING_W));
    _posY = safeZoneY + SPACING_H max (_posY + pixelH min (safeZoneY + safezoneH - _posH - SPACING_H));

    [_posX, _posY, _posW, _posH]
} else {
    // Has parent row, position is based on parent group's position
    ctrlPosition ctrlParentControlsGroup _parentRow params ["_posX", "_posY", "_parentWidth"];

    // Add y position of row relative to group
    _posY = _posY + (ctrlPosition _parentRow select 1);

    // Determine position of children context groups (left or right of parent)
    // This follows logic of BI's context menu (ctrlMenu)
    // If menu is opened more than half way across screen, expand to the left
    _posX = if (GVAR(mousePos) select 0 > 0.5) then {
        _posX - _posW - SPACING_W;
    } else {
        _posX + _parentWidth + SPACING_W;
    };

    _posY = safeZoneY + SPACING_H max (_posY min (safeZoneY + safezoneH - _posH - SPACING_H));

    [_posX, _posY, _posW, _posH]
};

_ctrlContextGroup ctrlSetPosition _groupPosition;
_ctrlContextGroup ctrlCommit 0;
