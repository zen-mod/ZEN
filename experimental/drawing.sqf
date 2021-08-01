removeMissionEventHandler ["Draw3D", HANDLE];
HANDLE = addMissionEventHandler ["Draw3D", {
    for "_i" from 2 to count POSITIONS do {
        drawLine3D [POSITIONS#(_i-2), POSITIONS#(_i-1), [1,0,0,1]];
    };
    for "_i" from 2 to count POSITIONS_2 do {
        drawLine3D [POSITIONS_2#(_i-2), POSITIONS_2#(_i-1), [0,1,0,1]];
    };
}];




private _startPos = POSITIONS#0 vectorAdd [880, 0, -2200];
private _endPos = _startPos vectorAdd [120, 0, -100];
private _startVectDir = [1000, 0, -2500];
private _endVectDir = [1, 0, 0];
private _intPos = [_startPos, _startVectDir, _endPos, _endVectDir] call ZEN_common_fnc_getLineIntersection;
systemChat str [_startPos, _intPos vectorDiff _startPos, _endPos vectorDiff _startPos];
POSITIONS_2 = [_startPos, _intPos, _endPos];