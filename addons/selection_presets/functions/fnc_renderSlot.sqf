#include "script_component.hpp"
/*
 * Author: mharis001
 * Renders the given slot control based on its preset's objects.
 *
 * Arguments:
 * 0: Slot Control <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_selection_presets_fnc_renderSlot
 *
 * Public: No
 */

#define COLOR_MODULES [1, 1, 1, 1]
#define COLOR_DEAD [0, 0, 0, 1]

BEGIN_COUNTER(renderSlot);

params ["_ctrlSlot"];

private _key = _ctrlSlot getVariable [QGVAR(key), -1];
private _objects = [_key] call FUNC(get);

// Consolidate units into groups when enabled
private _consolidateIntoGroups = GVAR(useGroupIcons) != USE_GROUP_ICONS_NO;
private _entities = [_objects, []] select _consolidateIntoGroups;

if (_consolidateIntoGroups) then {
    {
        private _group = group _x;

        if (!isNull _group && {side _group != sideLogic}) then {
            if (
                GVAR(useGroupIcons) == USE_GROUP_ICONS_EXCEPT_SINGLE_UNITS
                && {count units _group == 1}
            ) exitWith {};

            _entities pushBackUnique _group;
            continue;
        };

        _entities pushBackUnique _x;
    } forEach _objects;
};

// The different layouts for an individual slot, representing the following:
//   0: Key position (x, y, width, height)
//   1: Content element positions for 1, 2, 3, and 4 displayed items
// When there are fewer than four elements that need to be displayed, we distribute
// the icons more evenly over the available space
private _layouts = createHashMapFromArray [
    [
        SLOT_LAYOUT_WIDE,
        [
            [0, 0, 0.8, 1.2],
            [
                [
                    [2.5, 0.2]
                ],
                [
                    [1.8, 0.2],
                    [3.2, 0.2]
                ],
                [
                    [1.25, 0.2],
                    [2.5, 0.2],
                    [3.75, 0.2]
                ],
                [
                    [1, 0.2],
                    [2, 0.2],
                    [3, 0.2],
                    [4, 0.2]
                ]
            ]
        ]
    ],
    [
        SLOT_LAYOUT_STACKED,
        [
            [0, 0, 4.2, 0.8],
            [
                [
                    [1.7, 1]
                ],
                [
                    [1, 1],
                    [2.4, 1]
                ],
                [
                    [0.45, 1],
                    [1.7, 1],
                    [2.95, 1]
                ],
                [
                    [0.2, 1],
                    [1.2, 1],
                    [2.2, 1],
                    [3.2, 1]
                ]
            ]
        ]
    ],
    [
        SLOT_LAYOUT_COMPACT,
        [
            [0, 0, 2.2, 0.8],
            [
                [
                    [0.7, 1.5]
                ],
                [
                    [0.2, 1.5],
                    [1.2, 1.5]
                ],
                [
                    [0.2, 1],
                    [1.2, 1],
                    [0.7, 2]
                ],
                [
                    [0.2, 1],
                    [1.2, 1],
                    [0.2, 2],
                    [1.2, 2]
                ]
            ]
        ]
    ]
];

private _layout = _ctrlSlot getVariable [QGVAR(layout), SLOT_LAYOUT_WIDE];
private _layoutParams = _layouts get _layout;
_layoutParams params ["_keyPosition", "_positionsByCount"];

// Always need to update the key element's position, even if empty
private _ctrlKey = _ctrlSlot controlsGroupCtrl IDC_SLOT_KEY;
_keyPosition params ["_keyX", "_keyY", "_keyW", "_keyH"];
_ctrlKey ctrlSetPosition [POS_W(_keyX), POS_H(_keyY), POS_W(_keyW), POS_H(_keyH)];
_ctrlKey ctrlCommit 0;

// The background and mouse area should cover the entire slot
ctrlPosition _ctrlSlot params ["", "", "_slotWidth", "_slotHeight"];

{
    private _ctrl = _ctrlSlot controlsGroupCtrl _x;
    _ctrl ctrlSetPosition [0, 0, _slotWidth, _slotHeight];
    _ctrl ctrlCommit 0;
} forEach [IDC_SLOT_BACKGROUND, IDC_SLOT_MOUSE];

// Show the vertical divider when the key is above the slot contents
private _ctrlSlotDivider = _ctrlSlot controlsGroupCtrl IDC_SLOT_DIVIDER;

if (_layout != SLOT_LAYOUT_WIDE) then {
    _ctrlSlotDivider ctrlSetPosition [_slotWidth - pixelW, 0, pixelW, _slotHeight];
} else {
    _ctrlSlotDivider ctrlSetPosition [0, 0, 0, 0];
};

_ctrlSlotDivider ctrlCommit 0;

// Update the preset contents tooltip
private _tooltip = if (GVAR(showTooltips)) then {
    [_objects, _key] call FUNC(getTooltip)
} else {
    ""
};

private _ctrlSlotMouse = _ctrlSlot controlsGroupCtrl IDC_SLOT_MOUSE;
_ctrlSlotMouse ctrlSetTooltip _tooltip;

// Hide elements (by clearing the text) if there are no entities to render
if (_entities isEqualTo []) exitWith {
    {
        private _ctrl = _ctrlSlot controlsGroupCtrl _x;
        _ctrl ctrlSetText "";
    } forEach [
        IDC_SLOT_ICON_1,
        IDC_SLOT_ICON_2,
        IDC_SLOT_ICON_3,
        IDC_SLOT_EXTRA_COUNT
    ];

    END_COUNTER(renderSlot);
};

// Update the positioning of the elements based on the number of entities
// The positions array will only contain the ones that need to be updated
private _entityCount = count _entities;
private _positionsIndex = (_entityCount min 4) - 1;
private _positions = _positionsByCount select _positionsIndex;

private _contentIDCs = [
    IDC_SLOT_ICON_1,
    IDC_SLOT_ICON_2,
    IDC_SLOT_ICON_3,
    IDC_SLOT_EXTRA_COUNT
];

{
    _x params ["_itemX", "_itemY"];

    private _posX = POS_W(_itemX);
    private _posY = POS_H(_itemY);
    private _posW = POS_W(0.8);
    private _posH = POS_H(0.8);
    private _idc = _contentIDCs select _forEachIndex;

    // Compensate for the extra count text control's horizontal margins
    if (_idc == IDC_SLOT_EXTRA_COUNT) then {
        // Subtracting to account for engine hardcoded left margin of 0.008
        _posX = _posX - 0.008;

        // And, adding the space for both left and right margins to the width
        _posW = _posW + 2 * 0.008;
    };

    private _ctrl = _ctrlSlot controlsGroupCtrl _idc;
    _ctrl ctrlSetPosition [_posX, _posY, _posW, _posH];
    _ctrl ctrlCommit 0;
} forEach _positions;

// Update the icons (or hide if there are not enough entities to show)
{
    private _ctrl = _ctrlSlot controlsGroupCtrl _x;
    private _hasEntity = _forEachIndex < _entityCount;

    if (_hasEntity) then {
        private _entity = _entities select _forEachIndex;
        private _entityIsGroup = _entity isEqualType grpNull;

        private _icon = if (_entityIsGroup) then {
            [_entity] call EFUNC(common,getGroupIcon)
        } else {
            [_entity] call EFUNC(common,getVehicleIcon)
        };

        // Show dead units or vehicles as black (props remain yellow)
        private _color = if (
            _entityIsGroup
            || {alive _entity}
            || {
                private _isUnitOrVehicle = _entity isKindOf "AllVehicles";
                !_isUnitOrVehicle
            }
        ) then {
            // Modules are not shown based on side color
            if (!_entityIsGroup && {_entity isKindOf "Logic"}) exitWith {
                COLOR_MODULES
            };

            private _side = if (_entityIsGroup) then {
                side _entity
            } else {
                // Returns grpNull for props -> sideUnknown, which gives the yellow prop color
                side group _entity
            };

            [_side] call BIS_fnc_sideColor
        } else {
            COLOR_DEAD
        };

        _ctrl ctrlSetText _icon;
        _ctrl ctrlSetTextColor _color;
    } else {
        _ctrl ctrlSetText "";
    };
} forEach [
    IDC_SLOT_ICON_1,
    IDC_SLOT_ICON_2,
    IDC_SLOT_ICON_3
];

// Show the extra count if there are more than three entities
// Display "99+" if there are 100 or more extra entities
// The UI only supports up to two digits without overflow
private _extraCount = (_entityCount - 3) max 0;
private _extraCountText = if (_extraCount > 0) then {
    if (_extraCount < 100) then {
        format ["+%1", _extraCount]
    } else {
        "99+"
    };
} else {
    ""
};

private _ctrlSlotExtraCount = _ctrlSlot controlsGroupCtrl IDC_SLOT_EXTRA_COUNT;
_ctrlSlotExtraCount ctrlSetText _extraCountText;

END_COUNTER(renderSlot);
