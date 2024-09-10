#include "script_component.hpp"
/*
 * Author: Bohemia Interactive
 * Module function for initializing the Zeus Game Master module.
 * Edited to allow for control over ascension messages and camera eagle,
 * fix double attributes dialog bug, fix respawn on start with forced interface bug,
 * and fix loss of curator assignment when the module's locality is transferred.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 * 1: Units <ARRAY>
 * 2: Activated <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC, [], true] call zen_modules_fnc_bi_moduleCurator
 *
 * Public: No
 */

params ["_logic", "_units", "_activated"];

if (_activated) then {
    // BI's module framework is bugged and calls module function twice on clients after mission start
    if (_logic getVariable [QGVAR(initialized), false]) exitWith {};

    // Mark the module as initialized on this machine, fixes double attributes dialog bug
    _logic setVariable [QGVAR(initialized), true];

    // Determine the curator module's owner
    private _ownerVar = _logic getVariable ["owner", ""];
    private _isUID = parseNumber _ownerVar > 0;

    if (cheatsEnabled) then {
        private _ownerVarArray = toArray _ownerVar;
        _ownerVarArray resize 3;

        if (toString _ownerVarArray == "DEV") then {
            _isUID = true;
        };
    };

    if (_ownerVar == "" && {!isMultiplayer}) then {
        ["Curator owner not defined, player used instead in singleplayer."] call BIS_fnc_error;
        _ownerVar = player call BIS_fnc_objectVar;
    };

    if (_isUID && {!isMultiplayer}) then {
        _ownerVar = player call BIS_fnc_objectVar;
    };

    private _isAdmin = _ownerVar == "#adminLogged" || {_ownerVar == "#adminVoted"};

    // Wipe out the variable so clients can't access it
    _logic setVariable ["owner", nil];

    if (isServer) then {
        // Prepare admin variable
        private _adminVar = "";

        if (_isAdmin) then {
            private _letters = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"];
            _adminVar = "admin_";

            for "_i" from 0 to 9 do {
                _adminVar = _adminVar + selectRandom _letters;
            };

            _logic setVariable ["adminVar", _adminVar, true];
        };

        // Update curator module addons based on the allowed addons
        private _addonsType = _logic getVariable ["Addons", 2];

        switch (_addonsType) do {
            // All (including unofficial ones)
            case 3: {
                private _addons = configProperties [configFile >> "CfgPatches", "isClass _x"] apply {configName _x};

                // Activating addons only works during mission init
                if (time == 0) then {
                    _addons call BIS_fnc_activateAddons;
                };

                removeAllCuratorAddons _logic;
                _logic addCuratorAddons _addons;
            };

            // All active
            case 2: {};

            // All mission
            case 1: {
                private _addons = [];

                {
                    _addons append unitAddons typeOf _x;
                } forEach entities "All";

                removeAllCuratorAddons _logic;
                _logic addCuratorAddons _addons;
            };

            // None
            case 0: {
                removeAllCuratorAddons _logic;
            };
        };

        // Handle ownership
        [_logic, _ownerVar, _adminVar, _isUID] spawn {
            scriptName "BIS_fnc_moduleCurator: Owner";

            params ["_logic", "_ownerVar", "_adminVar", "_isUID"];

            if (_adminVar != "") then {
                _ownerVar = _adminVar;
            };

            private _name = _logic getVariable ["name", ""];

            if (_name == "") then {
                _name = localize "STR_A3_Curator";
            };

            // Wait until the mission starts
            waitUntil {time > 0};

            // Refresh addons list so it's broadcasted to clients
            private _addons = curatorAddons _logic;
            removeAllCuratorAddons _logic;
            _logic addCuratorAddons _addons;

            while {true} do {
                // Wait for player to become Zeus
                if (_isUID) then {
                    waitUntil {
                        isNull _logic || {playableUnits findIf {getPlayerUID _x == _ownerVar} != -1}
                    };
                } else {
                    waitUntil {
                        isNull _logic || {isPlayer (missionNamespace getVariable [_ownerVar, objNull])}
                    };
                };

                if (isNull _logic) exitWith {};

                // Assign the player as the curator
                private _player = if (_isUID) then {
                    private _units = playableUnits;
                    _units param [_units findIf {getPlayerUID _x == _ownerVar}, objNull]
                } else {
                    missionNamespace getVariable [_ownerVar, objNull]
                };

                waitUntil {unassignCurator _logic; isNull _logic || {isNull getAssignedCuratorUnit _logic}};
                waitUntil {_player assignCurator _logic; isNull _logic || {getAssignedCuratorUnit _logic == _player}};
                if (isNull _logic) exitWith {};

                // Add radio channels
                {
                    _x radioChannelAdd [_player];
                } forEach (_logic getvariable ["channels", []]);

                // Send a notification to all assigned players
                [{
                    if (!EGVAR(common,ascensionMessages)) exitWith {};

                    params ["_logic", "_player", "_name"];

                    if (_logic getVariable ["showNotification", true]) then {
                        {
                            if (isPlayer _x) then {
                                [["CuratorAssign", [_name, name _player]], "BIS_fnc_showNotification", _x] call BIS_fnc_MP;
                            };
                        } forEach curatorEditableObjects _logic;
                    };
                }, [_logic, _player, _name]] call EFUNC(common,runAfterSettingsInit);

                // Trigger scripted curator assigned event
                [_logic, "curatorUnitAssigned", [_logic, _player]] call BIS_fnc_callScriptedEventHandler;

                // Support for event added by ace_zeus
                ["ace_zeus_zeusUnitAssigned", [_logic, _player]] call CBA_fnc_globalEvent;

                // Wait for player to stop being Zeus
                if (_isUID) then {
                    waitUntil {
                        isNull _logic || {playableUnits findIf {getPlayerUID _x == _ownerVar} == -1}
                    };
                } else {
                    waitUntil {
                        isNull _logic || {_player != missionNamespace getVariable [_ownerVar, objNull]}
                    };
                };

                if (isNull _logic) exitWith {};

                // Remove radio channels
                {
                    _x radioChannelRemove [_player];
                } forEach (_logic getVariable ["channels", []]);

                // Unassign the player as the curator
                waitUntil {unassignCurator _logic; isNull _logic || {isNull getAssignedCuratorUnit _logic}};

                if (isNull _logic) exitWith {};
            };
        };

        // Fix assigned curator logic for a unit becoming null when locality is transferred away from the server
        // This causes the bug where the player is forced to respawn in order to access Zeus
        _logic addEventHandler ["Local", {
            params ["_logic", "_local"];

            if (!_local) then {
                private _unit = getAssignedCuratorUnit _logic;

                if (getAssignedCuratorLogic _unit != _logic) then {
                    unassignCurator _logic;

                    // Need to delay assignment, it can take some time for the module to be unassigned
                    [{
                        params ["_logic"];

                        isNull getAssignedCuratorUnit _logic
                    }, {
                        params ["_logic", "_unit"];

                        _unit assignCurator _logic;
                    }, [_logic, _unit]] call CBA_fnc_waitUntilAndExecute;
                };
            };
        }];

        // Create camera bird
        [{
            if (!EGVAR(common,cameraBird)) exitWith {};

            params ["_logic"];

            private _birdType = _logic getVariable ["birdType", "Eagle_F"];

            if (_birdType != "") then {
                private _bird = createVehicle [_birdType, [100, 100, 100], [], 0, "NONE"];
                _logic setVariable ["bird", _bird, true];
            };

            // Handle changing locality of bird
            _logic addEventHandler ["Local", {
                params ["_logic"];

                private _bird = _logic getVariable ["bird", objNull];
                _bird setOwner owner _logic;
            }];
        }, [_logic]] call EFUNC(common,runAfterSettingsInit);

        // Activate all future addons (only works during mission init)
        if (time == 0) then {
            private _addons = [];

            {
                if (typeOf _x == "ModuleCuratorAddAddons_F") then {
                    private _paramAddons = call compile ("[" + (_x getVariable ["addons", ""]) + "]");
                    _addons append _paramAddons;

                    {
                        _addons append unitAddons _x;
                    } forEach _paramAddons;
                };
            } forEach synchronizedObjects _logic;

            _addons call BIS_fnc_activateAddons;
        };
    };

    if (hasInterface) then {
        waitUntil {local player};

        private _serverCommand = ["#kick", "#shutdown"] select (_ownerVar == "#adminLogged");

        // Black effect until the forced interface is open
        private _forced = _logic getVariable ["forced", 0] > 0;

        if (_forced) then {
            private _isCurator = switch (true) do {
                case (_isUID): {
                    getPlayerUID player == _ownerVar
                };
                case (_isAdmin): {
                    isServer || {serverCommandAvailable _serverCommand}
                };
                default {
                    player == missionNamespace getVariable [_ownerVar, objNull]
                };
            };

            if (_isCurator) then {
                // Wait for player to finish respawning on start
                // Fixes issue where player is unable to interact with respawn menu
                [{
                    time > 0
                    && {playerRespawnTime == -1}
                    && {
                        !isMultiplayer
                        || {getMissionConfigValue ["respawnOnStart", 0] != 1}
                        || {player getVariable ["BIS_fnc_selectRespawnTemplate_respawned", false]}
                    }
                }, {
                    [true, true] spawn BIS_fnc_forceCuratorInterface;
                    ("RscDisplayCurator" call BIS_fnc_rscLayer) cuttext ["", "BLACK IN", 1e10];
                }] call CBA_fnc_waitUntilAndExecute;
            };
        };

        // Check if player is server admin
        if (_isAdmin) then {
            private _adminVar = _logic getVariable ["adminVar", ""];
            _logic setVariable ["adminVar", nil];

            if (isServer) then {
                // Player is the host, they will always be the admin
                missionNamespace setVariable [_adminVar, player];
            } else {
                // Player is a client, need to check when they become admin
                [_logic, _adminVar, _serverCommand] spawn {
                    scriptName "BIS_fnc_moduleCurator: Admin Check";

                    params ["_logic", "_adminVar", "_serverCommand"];

                    while {true} do {
                        waitUntil {sleep 0.1; serverCommandAvailable _serverCommand};
                        missionNamespace setVariable [_adminVar, player, true];

                        private _handle = player addEventHandler ["Respawn", format ["missionNamespace setVariable ['%1', _this select 0, true]", _adminVar]];

                        waitUntil {sleep 0.1; !serverCommandAvailable _serverCommand};
                        missionNamespace setVariable [_adminVar, objNull, true];

                        player removeEventHandler ["Respawn", _handle];
                    };
                };
            };
        };

        [_logic] spawn {
            params ["_logic"];

            sleep 1;

            waitUntil {alive player};

            // Show warning when Zeus key is not assigned
            if (actionKeys "curatorInterface" isEqualTo []) then {
                [
                    format [
                        localize "str_a3_cfgvehicles_modulecurator_f_keyNotAssigned",
                        (["IGUI", "WARNING_RGB"] call BIS_fnc_displayColorGet) call BIS_fnc_colorRGBAtoHTML
                    ]
                ] call BIS_fnc_guiMessage;
            };

            // Show hint about pinging for players
            if (
                isNil {profileNamespace getVariable "bis_fnc_curatorPinged_done"}
                && {isTutHintsEnabled}
                && {isNull getAssignedCuratorLogic player}
                && {player in curatorEditableObjects _logic}
            ) then {
                sleep 0.5;
                [["Curator", "Ping"]] call BIS_fnc_advHint;
            };
        };

        // Add local event handlers
        _logic addEventHandler ["CuratorFeedbackMessage", {_this call BIS_fnc_showCuratorFeedbackMessage}];
        _logic addEventHandler ["CuratorPinged", {_this call BIS_fnc_curatorPinged}];
        _logic addEventHandler ["CuratorObjectPlaced", {_this call BIS_fnc_curatorObjectPlaced}];
        _logic addEventHandler ["CuratorObjectEdited", {_this call BIS_fnc_curatorObjectEdited}];
        _logic addEventHandler ["CuratorWaypointPlaced", {_this call BIS_fnc_curatorWaypointPlaced}];

        _logic addEventHandler ["CuratorObjectDoubleClicked", {(_this select 1) call BIS_fnc_showCuratorAttributes}];
        _logic addEventHandler ["CuratorGroupDoubleClicked", {(_this select 1) call BIS_fnc_showCuratorAttributes}];
        _logic addEventHandler ["CuratorWaypointDoubleClicked", {(_this select 1) call BIS_fnc_showCuratorAttributes}];
        _logic addEventHandler ["CuratorMarkerDoubleClicked", {(_this select 1) call BIS_fnc_showCuratorAttributes}];

        player call BIS_fnc_curatorRespawn;
    };
};
