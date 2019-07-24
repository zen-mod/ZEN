#include "script_component.hpp"

if (GVAR(draw) != -1) then {
    removeMissionEventHandler ["Draw3D", GVAR(draw)];
    GVAR(draw) = -1;
};
