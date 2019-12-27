#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles clicking the sensors button.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_attributes_fnc_buttonSensors
 *
 * Public: No
 */

private _vehicle = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);

["STR_3DEN_Object_AttributeCategory_VehicleSystems", [
    ["COMBO", ["STR_3DEN_Object_Attribute_Radar_displayName", "STR_3DEN_Object_Attribute_Radar_tooltip"], [[], [
        ["STR_3DEN_Attributes_Radar_Default_text", "STR_3DEN_Attributes_Radar_Default_tooltip"],
        ["STR_3DEN_Attributes_Radar_RadarOn_text", "STR_3DEN_Attributes_Radar_RadarOn_tooltip"],
        ["STR_3DEN_Attributes_Radar_RadarOff_text", "STR_3DEN_Attributes_Radar_RadarOff_tooltip"]
    ], [2, 1] select isVehicleRadarOn _vehicle], true],
    ["CHECKBOX", ["STR_3DEN_Object_Attribute_ReportRemoteTargets_displayName", "STR_3DEN_Object_Attribute_ReportRemoteTargets_tooltip"], vehicleReportRemoteTargets _vehicle, true],
    ["CHECKBOX", ["STR_3DEN_Object_Attribute_ReceiveRemoteTargets_displayName", "STR_3DEN_Object_Attribute_ReceiveRemoteTargets_tooltip"], vehicleReceiveRemoteTargets _vehicle, true],
    ["CHECKBOX", ["STR_3DEN_Object_Attribute_ReportOwnPosition_displayName", "STR_3DEN_Object_Attribute_ReportOwnPosition_tooltip"], vehicleReportOwnPosition _vehicle, true]
], {
    params ["_dialogValues", "_vehicle"];

    {
        [QGVAR(setSensors), [_x, _dialogValues], _x] call CBA_fnc_targetEvent;
    } forEach (_vehicle call FUNC(getAttributeEntities));
}, {}, _vehicle] call EFUNC(dialog,create);
