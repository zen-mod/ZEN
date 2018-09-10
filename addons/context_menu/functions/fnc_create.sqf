#include "script_component.hpp"

params [["_contextActions", []], ["_parentRow", controlNull]];

// No context actions provided, open base level
if (_contextActions isEqualTo [] && {isNull _parentRow}) then {
    _contextActions = missionNamespace getVariable [QGVAR(actions), []];
};

// Check action conditions
private _params = [call FUNC(getContextPos)];
_params append GVAR(selected);
_contextActions = _contextActions select {
    _params call (_x select 4);
};

// Create context group control
private _display = findDisplay IDD_RSCDISPLAYCURATOR;
private _ctrlContextGroup = _display ctrlCreate [QGVAR(group), IDC_CONTEXT_GROUP];

// Store context group
GVAR(contextGroups) set [parseNumber !isNull _parentRow, _ctrlContextGroup];

// Create context action rows
private _numberOfRows = 0;

{
    _x params ["_actionName", "_displayName", "_picture", "_statement", "_condition", "", ["_children", []]];

    // Create context row control
    private _ctrlContextRow = _display ctrlCreate [QGVAR(row), IDC_CONTEXT_ROW, _ctrlContextGroup];

    // Set action name and picture
    private _ctrlName = _ctrlContextRow controlsGroupCtrl IDC_CONTEXT_NAME;
    _ctrlName ctrlSetText _displayName;

    private _ctrlPicture = _ctrlContextRow controlsGroupCtrl IDC_CONTEXT_PICTURE;
    _ctrlPicture ctrlSetText _picture;

    // Hide expandable icon if no children actions
    if (_children isEqualTo []) then {
        private _ctrlExpandable = _ctrlContextRow controlsGroupCtrl IDC_CONTEXT_EXPANDABLE;
        _ctrlExpandable ctrlShow false;
    };

    // Add mouse area EHs to highlight background
    private _ctrlMouse = _ctrlContextRow controlsGroupCtrl IDC_CONTEXT_MOUSE;
    _ctrlMouse ctrlAddEventHandler ["MouseEnter", {
        params ["_ctrlMouse"];

        private _ctrlContextRow = ctrlParentControlsGroup _ctrlMouse;

        // Update highlight color
        private _ctrlHighlight = _ctrlContextRow controlsGroupCtrl IDC_CONTEXT_HIGHLIGHT;
        _ctrlHighlight ctrlSetBackgroundColor [0, 0, 0, 1];

        // Close previously open child context group
        private _childContextGroup = GVAR(contextGroups) select 1;
        if !(ctrlParentControlsGroup _ctrlContextRow isEqualto _childContextGroup) then {
            ctrlDelete _childContextGroup;
        };

        // Create child context group if action has children
        private _children = _ctrlContextRow getVariable [QGVAR(children), _children];
        if !(_children isEqualTo []) then {
            [_children, _ctrlContextRow] call FUNC(create);
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
            private _statement = _ctrlContextRow getVariable [QGVAR(statement), _statement];
            private _params = [call FUNC(getContextPos)];
            _params append GVAR(selected);
            _params call _statement;
            {call FUNC(closeMenu)} call CBA_fnc_execNextFrame;
        };
    }];

    _ctrlContextRow setVariable [QGVAR(statement), _statement];
    _ctrlContextRow setVariable [QGVAR(children), _children];

    // Update row position in group
    _ctrlContextRow ctrlSetPosition [0, _numberOfRows * GUI_GRID_H];
    _ctrlContextRow ctrlCommit 0;

    _numberOfRows = _numberOfRows + 1;
} forEach _contextActions;

// Update context group position
private _wPos = 8 * GUI_GRID_W;
private _hPos = _numberOfRows * GUI_GRID_H;

private _groupPosition = if (isNull _parentRow) then {
    getMousePosition params ["_xPos", "_yPos"];

    _xPos = (safeZoneX + 0.2 * GUI_GRID_W) max (_xPos min (safeZoneX + safeZoneW - _wPos - 0.2 * GUI_GRID_W));
    _yPos = (safeZoneY + 0.2 * GUI_GRID_H) max (_yPos min (safeZoneY + safezoneH - _hPos - 0.2 * GUI_GRID_H));

    [_xPos, _yPos, _wPos, _hPos]
} else {
    ctrlPosition _parentRow params ["_xPos", "_yPos"];

    ctrlPosition ctrlParentControlsGroup _parentRow params ["_xPosGroup", "_yPosGroup"];
    _xPos = _xPos + _xPosGroup;
    _yPos = _yPos + _yPosGroup;

    _xPos = _xPos + _wPos + 0.2 * GUI_GRID_W;
    if (_xPos + _wPos > safeZoneX + safeZoneW - 0.2 * GUI_GRID_W) then {
        _xPos = _xPos - 2 * _wPos - 0.4 * GUI_GRID_W;
    };

    _yPos = (safeZoneY + 0.2 * GUI_GRID_H) max (_yPos min (safeZoneY + safezoneH - _hPos - 0.2 * GUI_GRID_H));

    [_xPos, _yPos, _wPos, _hPos]
};

// Update context background position
private _ctrlBackground = _ctrlContextGroup controlsGroupCtrl IDC_CONTEXT_BACKGROUND;
_ctrlBackground ctrlSetPosition [0, 0, _wPos, _hPos];
_ctrlBackground ctrlCommit 0;

_ctrlContextGroup ctrlSetPosition _groupPosition;
_ctrlContextGroup ctrlCommit 0;
