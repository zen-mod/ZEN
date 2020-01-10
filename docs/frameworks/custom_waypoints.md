# Custom Waypoints

The ZEN custom waypoints framework allows addon makers to easily make their waypoints available in the Zeus interface.

### Adding Waypoints

Waypoints are added as subclasses to the `ZEN_WaypointTypes` root config class.

**Config Entries:**

Name | Type | Description
---- | ---- | -----------
`displayName` | STRING | Displayed name of the waypoint
`type` | STRING | Waypoint type, [reference](https://community.bistudio.com/wiki/Waypoint_types)
`script` | STRING | Path to waypoint script file, used when type is "SCRIPTED"

### Example

```cpp
class ZEN_WaypointTypes {
    class Paradrop {
        displayName = "Paradrop";
        type = "SCRIPTED";
        script = "\x\zen\addons\ai\functions\fnc_waypointParadrop.sqf";
    };
};
```
