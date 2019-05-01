# Context Menu

The ZEN context menu framework provides convenient, intuitive access to common Zeus actions such as remote controlling or opening the arsenal on a unit.

## Adding Actions Through Config

Context menu actions are added as subclasses to the `zen_context_menu_actions` root config class.
Children actions are also added as subclasses.

**Config Entries:**

Name | Type | Description
---- | ---- | -----------
`displayName` | STRING | Name of the action
`icon` | STRING | Icon file path
`iconColor` | ARRAY | Icon color RGBA
`statement` | STRING | Code called when action is clicked
`condition` | STRING | Condition code required to show action
`priority` | NUMBER | Action sorting priority

**Example:**

```clike
class zen_context_menu_actions {
    class HintName {
        displayName = "Hint Name";
        icon = "\folder\icon_name.paa";
        statement = "hint str name player";
        priority = 50;
    };  
};
```

## Adding Actions Through Script

Context menu actions can be added by calling the `zen_context_menu_fnc_addAction` function.
Actions are added locally and as a result the function must be executed on each client in order to have global effects.

**Arguments:**

 \#   | Description | Type | Default Value (if optional)
:---: | ----------- | ---- | ---------------------------
0 | Parent Path | ARRAY |
1 | Action Name | STRING |
2 | Display Name | STRING |
3 | Icon and Icon Color | STRING or ARRAY | ["", [1, 1, 1, 1]]
4 | Statement | CODE |
5 | Condition | CODE | {true}
6 | Priority | NUMBER | 0

**Return Value:**

&nbsp;&nbsp;&nbsp;&nbsp;Full Action Path &lt;ARRAY&gt;

**Example:**

```clike
[[], "HintTime", "Hint Time", "", {hint ([daytime] call BIS_fnc_timeToString)}] call zen_context_menu_fnc_addAction
```

## Statement and Condition

The `statement` and `condition` code blocks are both executed in the **unscheduled** environment.
The `condition` code **must** return a BOOL indicating whether the action should be shown.

**Passed Parameters:**

- The variable column references the name of local scope variable corresponding to the given parameter (for easy access, especially in configs).
- Context position is taken from the top-left corner of the menu, in format ASL.
- Hovered entity is the Zeus entity being hovered when the menu was opened. It is also included in its corresponding selected array. `objNull` if nothing was hovered.


 \#   | Description | Type | Variable
:---: | ----------- | ---- | --------
0 | Context Position | ARRAY | `_contextPosASL`
1 | Selected Objects | ARRAY | `_selectedObjects`
2 | Selected Groups | ARRAY | `_selectedGroups`
3 | Selected Waypoints | ARRAY | `_selectedWaypoints`
4 | Selected Markers | ARRAY | `_selectedMarkers`
5 | Hovered Entity | OBJECT, GROUP,<br/>ARRAY, or STRING | `_hoveredEntity`
