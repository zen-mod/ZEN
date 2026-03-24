#include "script_component.hpp"
/*
 * Author: Ampersand, mharis001
 * Handles receiving a player ping as Zeus.
 *
 * Arguments:
 * 0: Curator (not used) <OBJECT>
 * 1: Player (not used) <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_curator, _player] call zen_editor_fnc_handleCuratorPinged
 *
 * Public: No
 */

GVAR(pingTarget) = nil;
GVAR(pingViewed) = nil;
