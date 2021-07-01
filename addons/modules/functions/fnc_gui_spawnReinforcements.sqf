#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the "Spawn Reinforcements" Zeus module display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY, LOGIC] call zen_modules_fnc_gui_spawnReinforcements
 *
 * Public: No
 */

#define LOGIC_TYPE_LZ QGVAR(moduleCreateLZ)
#define LOGIC_TYPE_RP QGVAR(moduleCreateRP)

params ["_display", "_logic"];

private _selections = GVAR(saved) getVariable [QGVAR(spawnReinforcements), [0, 0, 0, 0, 0, [], -3, 1, 0, 100, -3, 0]];
_selections params ["_side", "_faction", "_category", "_vehicle", "_treeMode", "_unitList", "_vehicleLZ", "_vehicleBehaviour", "_insertionMethod", "_flyHeight", "_unitRP", "_unitBehaviour"];

private _position = ASLtoAGL getPosASL _logic;
_display setVariable [QGVAR(position), _position];
deleteVehicle _logic;

if !(LOGIC_TYPE_LZ call EFUNC(position_logics,exists)) exitWith {
    _display closeDisplay IDC_CANCEL;
    [LSTRING(PlaceAnLZ)] call EFUNC(common,showMessage);
};

private _fnc_sideChanged = {
    params ["_ctrlSide", "_sideIndex"];

    private _sideID = [1, 0, 2, 3] select _sideIndex;
    private _sideColor = [_sideID] call BIS_fnc_sideColor;

    private _display = ctrlParent _ctrlSide;
    private _cfgVehicles = configFile >> "CfgVehicles";
    private _cfgFactionClasses = configFile >> "CfgFactionClasses";
    private _cfgEditorSubcategories = configFile >> "CfgEditorSubcategories";

    uiNamespace getVariable QGVAR(reinforcementsCache) params ["_vehiclesCache", "_infantryCache", "_groupsCache"];

    // Add vehicle factions of the selected side
    private _ctrlFaction = _display displayCtrl IDC_SPAWNREINFORCEMENTS_FACTION;
    lbClear _ctrlFaction;

    private _vehicleFactions = keys (_vehiclesCache select _sideIndex);

    {
        private _config = _cfgFactionClasses >> _x;
        private _name = getText (_config >> "displayName");
        private _icon = getText (_config >> "icon");

        private _index = _ctrlFaction lbAdd _name;
        _ctrlFaction lbSetPicture [_index, _icon];
        _ctrlFaction lbSetData [_index, _x];
    } forEach _vehicleFactions;

    lbSort _ctrlFaction;
    _ctrlFaction lbSetCurSel 0;

    // Populate tree with premade groups of the selected side
    private _ctrlTreeGroups = _display displayCtrl IDC_SPAWNREINFORCEMENTS_TREE_GROUPS;
    tvClear _ctrlTreeGroups;

    {
        private _factionIndex = _ctrlTreeGroups tvAdd [[], _x];

        {
            private _categoryIndex = _ctrlTreeGroups tvAdd [[_factionIndex], _x];

            {
                _x params ["_name", "_icon", "_units"];

                private _groupIndex = _ctrlTreeGroups tvAdd [[_factionIndex, _categoryIndex], _name];
                private _groupPath  = [_factionIndex, _categoryIndex, _groupIndex];

                _ctrlTreeGroups tvSetTooltip [_groupPath, _name];
                _ctrlTreeGroups tvSetPicture [_groupPath, _icon];
                _ctrlTreeGroups tvSetPictureColor [_groupPath, _sideColor];

                _ctrlTreeGroups tvSetData [_groupPath, str _groupPath];
                _ctrlTreeGroups setVariable [str _groupPath, _units];
            } forEach _y;

            _ctrlTreeGroups tvSort [[_factionIndex, _categoryIndex], false];
        } forEach _y;

        _ctrlTreeGroups tvSort [[_factionIndex], false];
    } forEach (_groupsCache select _sideIndex);

    _ctrlTreeGroups tvSort [[], false];

    // Populate tree with units of the selected side
    private _ctrlTreeUnits = _display displayCtrl IDC_SPAWNREINFORCEMENTS_TREE_UNITS;
    tvClear _ctrlTreeUnits;

    {
        private _faction = getText (_cfgFactionClasses >> _x >> "displayName");
        private _factionIndex = _ctrlTreeUnits tvAdd [[], _faction];

        {
            private _category = getText (_cfgEditorSubcategories >> _x >> "displayName");
            private _categoryIndex = _ctrlTreeUnits tvAdd [[_factionIndex], _category];

            {
                private _name = getText (_cfgVehicles >> _x >> "displayName");
                private _icon = [_x] call EFUNC(common,getVehicleIcon);

                private _unitIndex = _ctrlTreeUnits tvAdd [[_factionIndex, _categoryIndex], _name];
                private _unitPath  = [_factionIndex, _categoryIndex, _unitIndex];

                _ctrlTreeUnits tvSetTooltip [_unitPath, _name];
                _ctrlTreeUnits tvSetPicture [_unitPath, _icon];
                _ctrlTreeUnits tvSetPictureColor [_unitPath, _sideColor];
                _ctrlTreeUnits tvSetData [_unitPath, _x];
            } forEach _y;

            _ctrlTreeUnits tvSort [[_factionIndex, _categoryIndex], false];
        } forEach _y;

        _ctrlTreeUnits tvSort [[_factionIndex], false];
    } forEach (_infantryCache select _sideIndex);

    _ctrlTreeUnits tvSort [[], false];

    private _ctrlUnitList = _display displayCtrl IDC_SPAWNREINFORCEMENTS_UNIT_LIST;
    lbClear _ctrlUnitList;

    private _ctrlUnitCount = _display displayCtrl IDC_SPAWNREINFORCEMENTS_UNIT_COUNT;
    _ctrlUnitCount ctrlSetText "0";
};

private _ctrlSide = _display displayCtrl IDC_SPAWNREINFORCEMENTS_SIDE;
_ctrlSide ctrlAddEventHandler ["LBSelChanged", _fnc_sideChanged];

private _fnc_factionChanged = {
    params ["_ctrlFaction", "_factionIndex"];

    private _display = ctrlParent _ctrlFaction;
    private _cfgEditorSubcategories = configFile >> "CfgEditorSubcategories";

    uiNamespace getVariable QGVAR(reinforcementsCache) params ["_vehiclesCache"];

    private _ctrlSide = _display displayCtrl IDC_SPAWNREINFORCEMENTS_SIDE;
    private _sideHash = _vehiclesCache select lbCurSel _ctrlSide;
    private _factionHash = _sideHash get (_ctrlFaction lbData _factionIndex);

    // Add vehicle categories of the selected side and faction
    private _ctrlCategory = _display displayCtrl IDC_SPAWNREINFORCEMENTS_CATEGORY;
    lbClear _ctrlCategory;

    private _vehicleCategories = keys _factionHash;

    {
        private _index = _ctrlCategory lbAdd getText (_cfgEditorSubcategories >> _x >> "displayName");
        _ctrlCategory lbSetPicture [_index, "#(argb,8,8,3)color(0,0,0,0)"]; // Align text with other combo boxes
        _ctrlCategory lbSetData [_index, _x];
    } forEach _vehicleCategories;

    lbSort _ctrlCategory;
    _ctrlCategory lbSetCurSel 0;
};

private _ctrlFaction = _display displayCtrl IDC_SPAWNREINFORCEMENTS_FACTION;
_ctrlFaction ctrlAddEventHandler ["LBSelChanged", _fnc_factionChanged];

private _fnc_categoryChanged = {
    params ["_ctrlCategory", "_categoryIndex"];

    private _display = ctrlParent _ctrlCategory;
    private _cfgVehicles = configFile >> "CfgVehicles";

    uiNamespace getVariable QGVAR(reinforcementsCache) params ["_vehiclesCache"];

    private _ctrlSide = _display displayCtrl IDC_SPAWNREINFORCEMENTS_SIDE;
    private _sideHash = _vehiclesCache select lbCurSel _ctrlSide;

    private _ctrlFaction = _display displayCtrl IDC_SPAWNREINFORCEMENTS_FACTION;
    private _factionHash = _sideHash get (_ctrlFaction lbData lbCurSel _ctrlFaction);

    // Add vehicles of the selected side, faction, and category
    private _ctrlVehicle = _display displayCtrl IDC_SPAWNREINFORCEMENTS_VEHICLE;
    lbClear _ctrlVehicle;

    private _vehicles = _factionHash get (_ctrlCategory lbData _categoryIndex);

    {
        private _config = _cfgVehicles >> _x;
        private _name = getText (_config >> "displayName");
        private _icon = getText (_config >> "icon");
        private _capacity = format ["(%1)", [_x] call EFUNC(common,getCargoPositionsCount)];

        private _index = _ctrlVehicle lbAdd _name;
        _ctrlVehicle lbSetTextRight [_index, _capacity];
        _ctrlVehicle lbSetPicture [_index, _icon];
        _ctrlVehicle lbSetData [_index, _x];
    } forEach _vehicles;

    lbSort _ctrlVehicle;
    _ctrlVehicle lbSetCurSel 0;
};

private _ctrlCategory = _display displayCtrl IDC_SPAWNREINFORCEMENTS_CATEGORY;
_ctrlCategory ctrlAddEventHandler ["LBSelChanged", _fnc_categoryChanged];

private _fnc_vehicleChanged = {
    params ["_ctrlVehicle", "_vehicleIndex"];

    private _display = ctrlParent _ctrlVehicle;
    private _vehicle = _ctrlVehicle lbData _vehicleIndex;
    private _capacity = [_vehicle] call EFUNC(common,getCargoPositionsCount);

    private _ctrlUnitList = _display displayCtrl IDC_SPAWNREINFORCEMENTS_UNIT_LIST;

    for "_i" from lbSize _ctrlUnitList - 1 to _capacity step -1 do {
        _ctrlUnitList lbDelete _i;
    };

    private _ctrlUnitCount = _display displayCtrl IDC_SPAWNREINFORCEMENTS_UNIT_COUNT;
    _ctrlUnitCount ctrlSetText str lbSize _ctrlUnitList;

    private _isAir = _vehicle isKindOf "Air";

    private _ctrlInsertion = _display displayCtrl IDC_SPAWNREINFORCEMENTS_VEHICLE_INSERTION;
    _ctrlInsertion ctrlEnable _isAir;

    private _ctrlFlyHeight = _display displayCtrl IDC_SPAWNREINFORCEMENTS_VEHICLE_HEIGHT;
    _ctrlFlyHeight ctrlEnable _isAir;

    if (
        isClass (configFile >> "CfgPatches" >> "ace_fastroping")
        && {getNumber (configFile >> "CfgVehicles" >> _vehicle >> "ace_fastroping_enabled") > 0}
    ) then {
        if (lbSize _ctrlInsertion < 3) then {
            _ctrlInsertion lbAdd localize ELSTRING(ai,Fastrope);
        };
    } else {
        private _index = lbCurSel _ctrlInsertion;

        // Switch to land if fastroping is not available
        if (_index == 2) then {
            _index = 0;
        };

        _ctrlInsertion lbDelete 2;
        _ctrlInsertion lbSetCurSel _index;
    };
};

private _ctrlVehicle = _display displayCtrl IDC_SPAWNREINFORCEMENTS_VEHICLE;
_ctrlVehicle ctrlAddEventHandler ["LBSelChanged", _fnc_vehicleChanged];

_ctrlSide     lbSetCurSel _side;
_ctrlFaction  lbSetCurSel _faction;
_ctrlCategory lbSetCurSel _category;
_ctrlVehicle  lbSetCurSel _vehicle;

private _fnc_treeModeChanged = {
    params ["_ctrlTreeMode", "_mode"];

    private _display = ctrlParent _ctrlTreeMode;
    private _ctrlTreeGroups = _display displayCtrl IDC_SPAWNREINFORCEMENTS_TREE_GROUPS;
    private _ctrlTreeUnits  = _display displayCtrl IDC_SPAWNREINFORCEMENTS_TREE_UNITS;

    _ctrlTreeGroups ctrlShow (_mode == 0);
    _ctrlTreeUnits  ctrlShow (_mode == 1);
};

private _ctrlTreeMode = _display displayCtrl IDC_SPAWNREINFORCEMENTS_TREE_MODE;
_ctrlTreeMode ctrlAddEventHandler ["ToolBoxSelChanged", _fnc_treeModeChanged];
_ctrlTreeMode lbSetCurSel _treeMode;

[_ctrlTreeMode, _treeMode] call _fnc_treeModeChanged;

private _fnc_groupTreeDblClicked = {
    params ["_ctrlTreeGroups", "_selectedPath"];

    // Exit if a group path was not selected
    if (count _selectedPath < 3) exitWith {};

    private _display = ctrlParent _ctrlTreeGroups;

    private _dataVar = _ctrlTreeGroups tvData _selectedPath;
    private _units = _ctrlTreeGroups getVariable _dataVar;
    private _fnc_addUnit = _display getVariable QFUNC(addUnit);

    {
        [_display, _x] call _fnc_addUnit;
    } forEach _units;
};

private _ctrlTreeGroups = _display displayCtrl IDC_SPAWNREINFORCEMENTS_TREE_GROUPS;
_ctrlTreeGroups ctrlAddEventHandler ["TreeDblClick", _fnc_groupTreeDblClicked];

private _fnc_unitTreeDblClicked = {
    params ["_ctrlTreeUnits", "_selectedPath"];

    // Exit if a unit path was not selected
    if (count _selectedPath < 3) exitWith {};

    private _unit = _ctrlTreeUnits tvData _selectedPath;
    private _display = ctrlParent _ctrlTreeUnits;
    [_display, _unit] call (_display getVariable QFUNC(addUnit));
};

private _ctrlTreeUnits = _display displayCtrl IDC_SPAWNREINFORCEMENTS_TREE_UNITS;
_ctrlTreeUnits ctrlAddEventHandler ["TreeDblClick", _fnc_unitTreeDblClicked];

private _fnc_addUnit = {
    params ["_display", "_unitClass"];

    private _ctrlVehicle  = _display displayCtrl IDC_SPAWNREINFORCEMENTS_VEHICLE;
    private _ctrlUnitList = _display displayCtrl IDC_SPAWNREINFORCEMENTS_UNIT_LIST;
    private _capacity = [_ctrlVehicle lbData lbCurSel _ctrlVehicle] call EFUNC(common,getCargoPositionsCount);

    // Exit if max number of units have already been added
    if (lbSize _ctrlUnitList >= _capacity) exitWith {};

    private _unitConfig = configFile >> "CfgVehicles" >> _unitClass;
    private _unitName = getText (_unitConfig >> "displayName");
    private _unitSide = getNumber (_unitConfig >> "side");
    private _unitIcon = [_unitClass] call EFUNC(common,getVehicleIcon);
    private _unitFaction  = getText (_unitConfig >> "faction");
    private _unitCategory = getText (_unitConfig >> "editorSubcategory");

    private _factionConfig = configFile >> "CfgFactionClasses" >> _unitFaction;
    private _factionName = getText (_factionConfig >> "displayName");
    private _factionIcon = getText (_factionConfig >> "icon");

    private _categoryName = getText (configFile >> "CfgEditorSubcategories" >> _unitCategory >> "displayName");
    private _tooltip = format ["%1\n%2\n%3", _unitName, _categoryName, _factionName];

    private _index = _ctrlUnitList lbAdd _unitName;
    _ctrlUnitList lbSetTooltip [_index, _tooltip];
    _ctrlUnitList lbSetPicture [_index, _unitIcon];
    _ctrlUnitList lbSetPictureRight [_index, _factionIcon];
    _ctrlUnitList lbSetPictureColor [_index, [_unitSide] call BIS_fnc_sideColor];
    _ctrlUnitList lbSetData [_index, _unitClass];

    private _ctrlUnitCount = _display displayCtrl IDC_SPAWNREINFORCEMENTS_UNIT_COUNT;
    _ctrlUnitCount ctrlSetText str lbSize _ctrlUnitList;
};

_display setVariable [QFUNC(addUnit), _fnc_addUnit];

{
    [_display, _x] call _fnc_addUnit;
} forEach _unitList;

private _fnc_listKeyDown = {
    call {
        params ["_ctrlUnitList", "_keyCode"];

        if (_keyCode == DIK_DELETE && {lbCurSel _ctrlUnitList != -1}) exitWith {
            _ctrlUnitList lbDelete lbCurSel _ctrlUnitList;

            private _ctrlUnitCount = ctrlParent _ctrlUnitList displayCtrl IDC_SPAWNREINFORCEMENTS_UNIT_COUNT;
            _ctrlUnitCount ctrlSetText str lbSize _ctrlUnitList;

            true // handled
        };

        false
    };
};

private _fnc_listDblClicked = {
    params ["_ctrlUnitList", "_selectedIndex"];

    _ctrlUnitList lbDelete _selectedIndex;

    private _ctrlUnitCount = ctrlParent _ctrlUnitList displayCtrl IDC_SPAWNREINFORCEMENTS_UNIT_COUNT;
    _ctrlUnitCount ctrlSetText str lbSize _ctrlUnitList;
};

private _ctrlUnitList = _display displayCtrl IDC_SPAWNREINFORCEMENTS_UNIT_LIST;
_ctrlUnitList ctrlAddEventHandler ["KeyDown", _fnc_listKeyDown];
_ctrlUnitList ctrlAddEventHandler ["LBDblClick", _fnc_listDblClicked];

private _fnc_clearList = {
    params ["_ctrlUnitClear"];

    private _display = ctrlParent _ctrlUnitClear;

    private _ctrlUnitList = _display displayCtrl IDC_SPAWNREINFORCEMENTS_UNIT_LIST;
    lbClear _ctrlUnitList;

    private _ctrlUnitCount = _display displayCtrl IDC_SPAWNREINFORCEMENTS_UNIT_COUNT;
    _ctrlUnitCount ctrlSetText "0";
};

private _ctrlUnitClear = _display displayCtrl IDC_SPAWNREINFORCEMENTS_UNIT_CLEAR;
_ctrlUnitClear ctrlAddEventHandler ["ButtonClick", _fnc_clearList];

private _ctrlVehicleLZ = _display displayCtrl IDC_SPAWNREINFORCEMENTS_VEHICLE_LZ;
[_ctrlVehicleLZ, LOGIC_TYPE_LZ, _vehicleLZ, false, _position] call EFUNC(position_logics,initList);

private _ctrlVehicleBehaviour = _display displayCtrl IDC_SPAWNREINFORCEMENTS_VEHICLE_BEHAVIOUR;
_ctrlVehicleBehaviour lbSetCurSel _vehicleBehaviour;

private _ctrlInsertion = _display displayCtrl IDC_SPAWNREINFORCEMENTS_VEHICLE_INSERTION;
_ctrlInsertion lbSetCurSel _insertionMethod;

private _ctrlFlyHeight = _display displayCtrl IDC_SPAWNREINFORCEMENTS_VEHICLE_HEIGHT;
_ctrlFlyHeight ctrlSetText str _flyHeight;

private _ctrlUnitRP = _display displayCtrl IDC_SPAWNREINFORCEMENTS_UNIT_RP;
[_ctrlUnitRP, LOGIC_TYPE_RP, _unitRP, true, _position] call EFUNC(position_logics,initList);

private _ctrlUnitBehaviour = _display displayCtrl IDC_SPAWNREINFORCEMENTS_UNIT_BEHAVIOUR;
_ctrlUnitBehaviour lbSetCurSel _unitBehaviour;

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display  = ctrlParent _ctrlButtonOK;
    private _position = _display getVariable QGVAR(position);

    private _side     = lbCurSel (_display displayCtrl IDC_SPAWNREINFORCEMENTS_SIDE);
    private _faction  = lbCurSel (_display displayCtrl IDC_SPAWNREINFORCEMENTS_FACTION);
    private _category = lbCurSel (_display displayCtrl IDC_SPAWNREINFORCEMENTS_CATEGORY);
    private _vehicle  = lbCurSel (_display displayCtrl IDC_SPAWNREINFORCEMENTS_VEHICLE);
    private _treeMode = lbCurSel (_display displayCtrl IDC_SPAWNREINFORCEMENTS_TREE_MODE);

    private _ctrlUnitList = _display displayCtrl IDC_SPAWNREINFORCEMENTS_UNIT_LIST;
    private _unitList = [];

    for "_i" from 0 to (lbSize _ctrlUnitList - 1) do {
        _unitList pushBack (_ctrlUnitList lbData _i);
    };

    private _vehicleBehaviour = lbCurSel (_display displayCtrl IDC_SPAWNREINFORCEMENTS_VEHICLE_BEHAVIOUR);
    private _insertionMethod  = lbCurSel (_display displayCtrl IDC_SPAWNREINFORCEMENTS_VEHICLE_INSERTION);
    private _unitBehaviour    = lbCurSel (_display displayCtrl IDC_SPAWNREINFORCEMENTS_UNIT_BEHAVIOUR);

    private _flyHeight = parseNumber ctrlText (_display displayCtrl IDC_SPAWNREINFORCEMENTS_VEHICLE_HEIGHT) max 50;

    private _ctrlVehicleLZ = _display displayCtrl IDC_SPAWNREINFORCEMENTS_VEHICLE_LZ;
    private _vehicleLZ = _ctrlVehicleLZ lbValue lbCurSel _ctrlVehicleLZ;

    private _ctrlUnitRP = _display displayCtrl IDC_SPAWNREINFORCEMENTS_UNIT_RP;
    private _unitRP = _ctrlUnitRP lbValue lbCurSel _ctrlUnitRP;

    private _selections = [_side, _faction, _category, _vehicle, _treeMode, _unitList, _vehicleLZ, _vehicleBehaviour, _insertionMethod, _flyHeight, _unitRP, _unitBehaviour];
    GVAR(saved) setVariable [QGVAR(spawnReinforcements), _selections];

    // Convert vehicle index to type
    _vehicle = (_display displayCtrl IDC_SPAWNREINFORCEMENTS_VEHICLE) lbData _vehicle;

    // Convert position logic index to object
    private _positionLZ = [LOGIC_TYPE_LZ, _vehicleLZ, _position] call EFUNC(position_logics,select);
    private _positionRP = [LOGIC_TYPE_RP, _unitRP, _position] call EFUNC(position_logics,select);

    _positionLZ = ASLtoAGL getPosASL _positionLZ;

    // Handle none option for RP
    if (!isNull _positionRP) then {
        _positionRP = ASLtoAGL getPosASL _positionRP;
    };

    [QGVAR(moduleSpawnReinforcements), [_vehicle, _unitList, _position, _positionLZ, _positionRP, _vehicleBehaviour > 0, _insertionMethod, _unitBehaviour, _flyHeight]] call CBA_fnc_serverEvent;
};

private _ctrlButtonOK = _display displayCtrl IDC_OK;
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
