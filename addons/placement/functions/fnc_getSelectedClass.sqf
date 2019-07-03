#include "script_component.hpp"

{
  private _faction = (findDisplay IDD_RSCDISPLAYCURATOR) displayCtrl _x;
  if (ctrlShown _faction) exitWith { _faction tvData (tvCurSel _faction) };
} forEach [270, 271, 272, 273, 274]; // IDs of the 5 zeus faction categories
