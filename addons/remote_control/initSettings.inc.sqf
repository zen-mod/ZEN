[
    QGVAR(cameraExitPosition),
    "LIST",
    [LSTRING(CameraExitPosition), LSTRING(CameraExitPosition_Description)],
    [ELSTRING(main,DisplayName), "STR_A3_CfgVehicles_ModuleRemoteControl_F"],
    [
        [
            CAMERA_EXIT_UNCHANGED,
            CAMERA_EXIT_RELATIVE,
            CAMERA_EXIT_RELATIVE_LIMITED,
            CAMERA_EXIT_ABOVE_UNIT,
            CAMERA_EXIT_BEHIND_UNIT
        ],
        [
            ["STR_3DEN_Attributes_Default_Unchanged_Text", LSTRING(CameraExitPosition_Unchanged_Description)],
            [LSTRING(CameraExitPosition_Relative), LSTRING(CameraExitPosition_Relative_Description)],
            [LSTRING(CameraExitPosition_RelativeLimited), LSTRING(CameraExitPosition_RelativeLimited_Description)],
            [LSTRING(CameraExitPosition_AboveUnit), LSTRING(CameraExitPosition_AboveUnit_Description)],
            [LSTRING(CameraExitPosition_BehindUnit), LSTRING(CameraExitPosition_BehindUnit_Description)]
        ],
        2
    ],
    false
] call CBA_fnc_addSetting;
