#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the "Spawn Reinforcements" Zeus module display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_modules_fnc_gui_spawnReinforcements
 *
 * Public: No
 */

params ["_display"];

if (isNil QGVAR(lastSpawnReinforcements)) then {
    GVAR(lastSpawnReinforcements) = [0, 0, 0, 0, [], -3, -3, 1, 0, 0];
};

GVAR(lastSpawnReinforcements) params ["_side", "_faction", "_category", "_vehicle", "_group", "_LZ", "_RP", "_vehicleBehaviour", "_unitBehaviour", "_insertionMethod"];

private _ctrlButtonOK = _display displayCtrl IDC_OK;
private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);

scopeName "Main";
private _fnc_errorAndClose = {
    params ["_msg"];
    _display closeDisplay 0;
    deleteVehicle _logic;
    [_msg] call EFUNC(common,showMessage);
    breakOut "Main";
};

if !(QGVAR(moduleCreateLZ) call EFUNC(position_logics,exists)) then {
    ["Place an LZ"] call _fnc_errorAndClose;
};

private _fnc_sideChanged = {
    params ["_ctrlSide", "_sideIndex"];

    private _display = ctrlParent _ctrlSide;
    private _cfgVehicles = configFile >> "CfgVehicles";
    private _cfgVehicleIcons = configFile >> "CfgVehicleIcons";
    private _cfgFactionClasses = configFile >> "CfgFactionClasses";
    private _cfgEditorSubcategories = configFile >> "CfgEditorSubcategories";

    uiNamespace getVariable QGVAR(reinforcementsCache) params ["_vehiclesCache", "_infantryCache"];

    private _ctrlFaction = _display displayCtrl IDC_SPAWNREINFORCEMENTS_FACTION;
    lbClear _ctrlFaction;

    private _vehicleFactions = [_vehiclesCache select _sideIndex] call CBA_fnc_hashKeys;

    {
        private _config = _cfgFactionClasses >> _x;
        private _displayName = getText (_config >> "displayName");
        private _icon = getText (_config >> "icon");

        private _index = _ctrlFaction lbAdd _displayName;
        _ctrlFaction lbSetPicture [_index, _icon];
        _ctrlFaction lbSetData [_index, _x];
    } forEach _vehicleFactions;

    lbSort _ctrlFaction;
    _ctrlFaction lbSetCurSel 0;

    private _ctrlGroupTree = _display displayCtrl IDC_SPAWNREINFORCEMENTS_GROUP_TREE;
    tvClear _ctrlGroupTree;

    private _sideColor = [[west, east, independent, civilian] select _sideIndex] call BIS_fnc_sideColor;

    [_infantryCache select _sideIndex, {
        private _factionConfig = _cfgFactionClasses >> _key;
        private _factionName = getText (_factionConfig >> "displayName");
        private _factionIcon = getText (_factionConfig >> "icon");

        private _factionIndex = _ctrlGroupTree tvAdd [[], _factionName];
        _ctrlGroupTree tvSetPicture [[_factionIndex], _factionIcon];

        [_value, {
            private _categoryConfig = _cfgEditorSubcategories >> _key;
            private _categoryName = getText (_categoryConfig >> "displayName");

            private _categoryIndex = _ctrlGroupTree tvAdd [[_factionIndex], _categoryName];

            {
                private _unitConfig = _cfgVehicles >> _x;
                private _unitName = getText (_unitConfig >> "displayName");
                private _unitIcon = getText (_unitConfig >> "icon");

                if (isText (_cfgVehicleIcons >> _unitIcon)) then {
                    _unitIcon = getText (_cfgVehicleIcons >> _unitIcon);
                };

                private _unitIndex = _ctrlGroupTree tvAdd [[_factionIndex, _categoryIndex], _unitName];
                _ctrlGroupTree tvSetTooltip [[_factionIndex, _categoryIndex, _unitIndex], _unitName];
                _ctrlGroupTree tvSetPicture [[_factionIndex, _categoryIndex, _unitIndex], _unitIcon];
                _ctrlGroupTree tvSetPictureColor [[_factionIndex, _categoryIndex, _unitIndex], _sideColor];
                _ctrlGroupTree tvSetData [[_factionIndex, _categoryIndex, _unitIndex], _x];
            } forEach _value;

            _ctrlGroupTree tvSort [[_factionIndex, _categoryIndex], false];
        }] call CBA_fnc_hashEachPair;

        _ctrlGroupTree tvSort [[_factionIndex], false];
    }] call CBA_fnc_hashEachPair;

    _ctrlGroupTree tvSort [[], false];

    private _ctrlList = _display displayCtrl IDC_SPAWNREINFORCEMENTS_GROUP_LIST;
    lbClear _ctrlList;
};

private _fnc_factionChanged = {
    params ["_ctrlFaction", "_factionIndex"];

    private _display = ctrlParent _ctrlFaction;
    private _cfgEditorSubcategories = configFile >> "CfgEditorSubcategories";

    uiNamespace getVariable QGVAR(reinforcementsCache) params ["_vehiclesCache"];

    private _ctrlSide = _display displayCtrl IDC_SPAWNREINFORCEMENTS_SIDE;
    private _sideHash = _vehiclesCache select lbCurSel _ctrlSide;
    private _factionHash = [_sideHash, _ctrlFaction lbData _factionIndex] call CBA_fnc_hashGet;

    private _vehicleCategories = [_factionHash] call CBA_fnc_hashKeys;

    private _ctrlCategory = _display displayCtrl IDC_SPAWNREINFORCEMENTS_CATEGORY;
    lbClear _ctrlCategory;

    {
        private _config = _cfgEditorSubcategories >> _x;
        private _displayName = getText (_config >> "displayName");

        private _index = _ctrlCategory lbAdd _displayName;
        _ctrlCategory lbSetPicture [_index, "#(argb,8,8,3)color(0,0,0,0)"]; // todo: keep?
        _ctrlCategory lbSetData [_index, _x];
    } forEach _vehicleCategories;

    lbSort _ctrlCategory;
    _ctrlCategory lbSetCurSel 0;
};

private _fnc_categoryChanged = {
    params ["_ctrlCategory", "_categoryIndex"];

    private _display = ctrlParent _ctrlCategory;
    private _cfgVehicles = configFile >> "CfgVehicles";

    uiNamespace getVariable QGVAR(reinforcementsCache) params ["_vehiclesCache"];

    private _ctrlSide = _display displayCtrl IDC_SPAWNREINFORCEMENTS_SIDE;
    private _ctrlFaction = _display displayCtrl IDC_SPAWNREINFORCEMENTS_FACTION;
    private _sideHash = _vehiclesCache select lbCurSel _ctrlSide;
    private _factionHash = [_sideHash, _ctrlFaction lbData lbCurSel _ctrlFaction] call CBA_fnc_hashGet;

    private _vehicles = [_factionHash, _ctrlCategory lbData _categoryIndex] call CBA_fnc_hashGet;

    private _ctrlVehicle = _display displayCtrl IDC_SPAWNREINFORCEMENTS_VEHICLE;
    lbClear _ctrlVehicle;

    {
        private _config = _cfgVehicles >> _x;
        private _displayName = getText (_config >> "displayName");
        private _icon = getText (_config >> "icon");
        private _maxCargo = format ["(%1)", _x call EFUNC(common,getCargoPositionsCount)];

        private _index = _ctrlVehicle lbAdd _displayName;
        _ctrlVehicle lbSetTextRight [_index, _maxCargo];
        _ctrlVehicle lbSetPicture [_index, _icon];
        _ctrlVehicle lbSetData [_index, _x];
    } forEach _vehicles;

    lbSort _ctrlVehicle;
    _ctrlVehicle lbSetCurSel 0;
};

private _fnc_vehicleChanged = {
    params ["_ctrlVehicle", "_selectedIndex"];

    private _display = ctrlParent _ctrlVehicle;
    private _ctrlGroupList = _display displayCtrl IDC_SPAWNREINFORCEMENTS_GROUP_LIST;
    private _ctrlGroupCount = _display displayCtrl IDC_SPAWNREINFORCEMENTS_GROUP_COUNT;

    private _vehicleClass = _ctrlVehicle lbData _selectedIndex;
    private _maxCargo = [_vehicleClass] call EFUNC(common,getCargoPositionsCount);

    while {lbSize _ctrlGroupList > _maxCargo} do {
        _ctrlGroupList lbDelete (lbSize _ctrlGroupList - 1);
    };

    _ctrlGroupCount ctrlSetText str lbSize _ctrlGroupList;
};

private _ctrlSide = _display displayCtrl IDC_SPAWNREINFORCEMENTS_SIDE;
_ctrlSide ctrlAddEventHandler ["LBSelChanged", _fnc_sideChanged];

private _ctrlFaction = _display displayCtrl IDC_SPAWNREINFORCEMENTS_FACTION;
_ctrlFaction ctrlAddEventHandler ["LBSelChanged", _fnc_factionChanged];

private _ctrlCategory = _display displayCtrl IDC_SPAWNREINFORCEMENTS_CATEGORY;
_ctrlCategory ctrlAddEventHandler ["LBSelChanged", _fnc_categoryChanged];

private _ctrlVehicle = _display displayCtrl IDC_SPAWNREINFORCEMENTS_VEHICLE;
_ctrlVehicle ctrlAddEventHandler ["LBSelChanged", _fnc_vehicleChanged];

_ctrlSide lbSetCurSel _side;
_ctrlFaction lbSetCurSel _faction;
_ctrlCategory lbSetCurSel _category;
_ctrlVehicle lbSetCurSel _vehicle;

private _fnc_treeDblClick = {
    params ["_ctrlGroupTree", "_selectedPath"];

    if (count _selectedPath < 3) exitWith {};

    private _display = ctrlParent _ctrlGroupTree;
    private _unitClass = _ctrlGroupTree tvData _selectedPath;

    [_display, _unitClass] call (_display getVariable QFUNC(addToGroup));
};

private _ctrlTree = _display displayCtrl IDC_SPAWNREINFORCEMENTS_GROUP_TREE;
_ctrlTree ctrlAddEventHandler ["TreeDblClick", _fnc_treeDblClick];

private _fnc_addToGroup = {
    params ["_display", "_unitClass"];

    private _ctrlList = _display displayCtrl IDC_SPAWNREINFORCEMENTS_GROUP_LIST;
    private _ctrlVehicle = _display displayCtrl IDC_SPAWNREINFORCEMENTS_VEHICLE;

    if (lbSize _ctrlList == [_ctrlVehicle lbData lbCurSel _ctrlVehicle] call EFUNC(common,getCargoPositionsCount)) exitWith {};

    private _unitConfig = configFile >> "CfgVehicles" >> _unitClass;
    private _unitName = getText (_unitConfig >> "displayName");
    private _unitIcon = getText (_unitConfig >> "icon");
    private _unitSide = getNumber (_unitConfig >> "side");
    private _unitFaction = getText (_unitConfig >> "faction");
    private _unitCategory = getText (_unitConfig >> "editorSubcategory");

    if (isText (configFile >> "CfgVehicleIcons" >> _unitIcon)) then {
        _unitIcon = getText (configFile >> "CfgVehicleIcons" >> _unitIcon);
    };

    private _factionConfig = configFile >> "CfgFactionClasses" >> _unitFaction;
    private _factionName = getText (_factionConfig >> "displayName");
    private _factionIcon = getText (_factionConfig >> "icon");

    private _categoryName = getText (configFile >> "CfgEditorSubcategories" >> _unitCategory >> "displayName");

    private _tooltip = format ["%1\n%2\n%3", _unitName, _categoryName, _factionName];

    private _index = _ctrlList lbAdd _unitName;
    _ctrlList lbSetTooltip [_index, _tooltip];
    _ctrlList lbSetPicture [_index, _unitIcon];
    _ctrlList lbSetPictureRight [_index, _factionIcon];
    _ctrlList lbSetPictureColor [_index, [_unitSide] call BIS_fnc_sideColor];
    _ctrlList lbSetData [_index, _unitClass];

    private _ctrlCount = _display displayCtrl IDC_SPAWNREINFORCEMENTS_GROUP_COUNT;
    _ctrlCount ctrlSetText str lbSize _ctrlList;
};

_display setVariable [QFUNC(addToGroup), _fnc_addToGroup];

private _fnc_listKeyDown = {
    params ["_ctrlList", "_keyCode"];

    if (_keyCode == DIK_DELETE && {lbCurSel _ctrlList != -1}) then {
        _ctrlList lbDelete lbCurSel _ctrlList;

        private _ctrlCount = ctrlParent _ctrlList displayCtrl IDC_SPAWNREINFORCEMENTS_GROUP_COUNT;
        _ctrlCount ctrlSetText str lbSize _ctrlList;

        true // handled
    } else {
        false
    };
};

private _ctrlList = _display displayCtrl IDC_SPAWNREINFORCEMENTS_GROUP_LIST;
_ctrlList ctrlAddEventHandler ["KeyDown", _fnc_listKeyDown];

{
    [_display, _x] call _fnc_addToGroup;
} forEach _group;

private _ctrlLZ = _display displayCtrl IDC_SPAWNREINFORCEMENTS_LZ;
[_ctrlLZ, QGVAR(moduleCreateLZ), _LZ] call EFUNC(position_logics,initList);

private _ctrlRP = _display displayCtrl IDC_SPAWNREINFORCEMENTS_RP;
[_ctrlRP, QGVAR(moduleCreateRP), _RP, true] call EFUNC(position_logics,initList);

private _ctrlVehicleBehaviour = _display displayCtrl IDC_SPAWNREINFORCEMENTS_VEHICLE_BEHAVIOUR;
_ctrlVehicleBehaviour lbSetCurSel _vehicleBehaviour;

private _ctrlUnitBehaviour = _display displayCtrl IDC_SPAWNREINFORCEMENTS_UNIT_BEHAVIOUR;
_ctrlUnitBehaviour lbSetCurSel _unitBehaviour;

private _ctrlInsertion = _display displayCtrl IDC_SPAWNREINFORCEMENTS_INSERTION;
_ctrlInsertion lbSetCurSel _insertionMethod;

private _fnc_onUnload = {
    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    if (isNull _logic) exitWith {};

    deleteVehicle _logic;
};

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    if (isNull _display) exitWith {};

    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    if (isNull _logic) exitWith {};

    private _ctrlSide = _display displayCtrl IDC_SPAWNREINFORCEMENTS_SIDE;
    private _side = lbCurSel _ctrlSide;

    private _ctrlFaction = _display displayCtrl IDC_SPAWNREINFORCEMENTS_FACTION;
    private _faction = lbCurSel _ctrlFaction;

    private _ctrlCategory = _display displayCtrl IDC_SPAWNREINFORCEMENTS_CATEGORY;
    private _category = lbCurSel _ctrlCategory;

    private _ctrlVehicle = _display displayCtrl IDC_SPAWNREINFORCEMENTS_VEHICLE;
    private _vehicle = lbCurSel _ctrlVehicle;

    private _ctrlGroupList = _display displayCtrl IDC_SPAWNREINFORCEMENTS_GROUP_LIST;
    private _group = [];

    for "_i" from 0 to (lbSize _ctrlGroupList - 1) do {
        _group pushBack (_ctrlGroupList lbData _i);
    };

    private _ctrlLZ = _display displayCtrl IDC_SPAWNREINFORCEMENTS_LZ;
    private _LZ = _ctrlLZ lbValue lbCurSel _ctrlLZ;

    private _ctrlRP = _display displayCtrl IDC_SPAWNREINFORCEMENTS_RP;
    private _RP = _ctrlRP lbValue lbCurSel _ctrlRP;

    private _ctrlVehicleBehaviour = _display displayCtrl IDC_SPAWNREINFORCEMENTS_VEHICLE_BEHAVIOUR;
    private _vehicleBehaviour = lbCurSel _ctrlVehicleBehaviour;

    private _ctrlUnitBehaviour = _display displayCtrl IDC_SPAWNREINFORCEMENTS_UNIT_BEHAVIOUR;
    private _unitBehaviour = lbCurSel _ctrlUnitBehaviour;

    private _ctrlInsertion = _display displayCtrl IDC_SPAWNREINFORCEMENTS_INSERTION;
    private _insertionMethod = lbCurSel _ctrlInsertion;

    GVAR(lastSpawnReinforcements) = [_side, _faction, _category, _vehicle, _group, _LZ, _RP, _vehicleBehaviour, _unitBehaviour, _insertionMethod];

    _vehicle = _ctrlVehicle lbData _vehicle;
    _LZ = [QGVAR(moduleCreateLZ), _LZ, _logic] call EFUNC(position_logics,select);
    _RP = [QGVAR(moduleCreateRP), _RP, _logic] call EFUNC(position_logics,select);

    _LZ = ASLtoAGL getPosASL _LZ;

    // Handle none option for RP
    if (isNull _RP) then {
        _RP = [];
    } else {
        _RP = ASLtoAGL getPosASL _RP;
    };

    [
        QGVAR(moduleSpawnreinforcements),
        [_vehicle, _group, ASLtoAGL getPosASL _logic, _LZ, _RP, _vehicleBehaviour > 0, _unitBehaviour, _insertionMethod]
    ] call CBA_fnc_serverEvent;
};

_display displayAddEventHandler ["Unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
