{
  private _faction = (findDisplay 312) displayCtrl _x;
  if (ctrlShown _faction) exitWith { _faction tvData (tvCurSel _faction) };
} forEach [270, 271, 272, 273, 274];
