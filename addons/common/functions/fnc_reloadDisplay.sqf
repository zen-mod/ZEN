#include "script_component.hpp"
/*
 * Author: mharis001
 * Reloads the Zeus display. Repeated calls have no effect
 * until the display is finished reloading.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_common_fnc_reloadDisplay
 *
 * Public: No
 */

if (!isNull findDisplay IDD_RSCDISPLAYCURATOR && {isNil QGVAR(displayReload)}) then {
    GVAR(displayReload) = true;

    {
        (findDisplay IDD_RSCDISPLAYCURATOR) closeDisplay IDC_CANCEL;

        [{
            isNull findDisplay IDD_RSCDISPLAYCURATOR
        }, {
            openCuratorInterface;
            GVAR(displayReload) = nil;
        }] call CBA_fnc_waitUntilAndExecute;
    } call CBA_fnc_execNextFrame;
};
