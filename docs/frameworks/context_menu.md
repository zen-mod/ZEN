# Context Menu

The ZEN context menu framework provides convenient, intuitive access to common Zeus actions such as remote controlling or opening the arsenal on a unit.

## Adding Actions Through Config

Context menu actions are added as subclasses to the `zen_context_menu_actions` root config class.
Children actions are also added as subclasses.

Actions can be added to both the global config `configFile` and the mission config `missionConfigFile`.
Mission config actions can add to action paths that exist from the global config.

**Config Entries:**

Name | Type | Description
---- | ---- | -----------
`displayName` | STRING | Name of the action
`icon` | STRING | Icon file path
`iconColor` | ARRAY | Icon color RGBA
`statement` | STRING | Code called when action is clicked
`condition` | STRING | Condition code required to show action
`priority` | NUMBER | Action sorting priority
`insertChildren` | STRING | Code to dynamically add children actions
`modifierFunction` | STRING | Code to modify the action before condition checking
`args` | ANY | Arguments passed to the action

**Example:**

```cpp
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

_Requires v1.4.0 or later._

#### Creating an Action

Context menu actions can be added by first creating an action with the `zen_context_menu_fnc_createAction` function.
This function is used to ensure that the created action array is in the correct format.

**Arguments:**

 \#   | Description | Type | Default Value (if optional)
:---: | ----------- | ---- | ---------------------------
0 | Action Name | STRING |
1 | Display Name | STRING |
2 | Icon and Icon Color | STRING or ARRAY | `["", [1, 1, 1, 1]]`
3 | Statement | CODE |
4 | Condition | CODE | `{true}`
5 | Arguments | ANY | `[]`
6 | Dynamic Children | CODE | `{}`
7 | Modifier Function | CODE | `{}`

**Return Value:**

- Action &lt;ARRAY&gt;

**Example:**

```sqf
private _action = [
    "HintTime",
    "Hint Time",
    "\a3\ui_f\data\igui\rsctitles\mpprogress\timer_ca.paa",
    {hint format ["Time - %1", [daytime] call BIS_fnc_timeToString]}
] call zen_context_menu_fnc_createAction
```

#### Adding the Created Action

The created action can be added using the `zen_context_menu_fnc_addAction` function.
Using the an empty parent path adds the action to the root level.
Actions are added locally and as a result the function must be executed on each client in order to have global effects.

**Arguments:**

 \#   | Description | Type | Default Value (if optional)
:---: | ----------- | ---- | ---------------------------
0 | Action | ARRAY
1 | Parent Path | ARRAY | []
2 | Priority | NUMBER | 0

**Return Value:**

- Full Action Path &lt;ARRAY&gt;

**Example:**

```sqf
[_action, [], 0] call zen_context_menu_fnc_addAction
```

## Removing Actions Through Script

_Requires v1.6.0 or later._

Context menu actions can be removed using the `zen_context_menu_fnc_removeAction` function with the full action path.

**Arguments:**

 \#   | Description | Type | Default Value (if optional)
:---: | ----------- | ---- | ---------------------------
0 | Action Path | ARRAY

**Return Value:**

- Removed &lt;BOOL&gt;

**Example:**

```sqf
["HintTime"] call zen_context_menu_fnc_removeAction
```

## Statement and Condition

The `statement` and `condition` code blocks are both executed in the **unscheduled** environment.
The `condition` code **must** return a BOOL indicating whether the action should be shown.

Actions that have an empty statement and no active children are not shown.
This removes the need to duplicate condition checks for actions that are only there to categorize others.

**Passed Parameters:**

- The variable column references the name of the local scope variable corresponding to the given parameter (for easy access, especially in configs).
- Context position is taken from the top-left corner of the menu, in format ASL.
- Hovered entity is the Zeus entity being hovered when the menu was opened. It is also included in its corresponding selected array. `objNull` if nothing was hovered.
- Arguments is the custom argument(s) given to the action when it was created.


 \#   | Description | Type | Variable
:---: | ----------- | ---- | --------
0 | Context Position | ARRAY | `_position`
1 | Selected Objects | ARRAY | `_objects`
2 | Selected Groups | ARRAY | `_groups`
3 | Selected Waypoints | ARRAY | `_waypoints`
4 | Selected Markers | ARRAY | `_markers`
5 | Hovered Entity | OBJECT, GROUP,<br/>ARRAY, or STRING | `_hoveredEntity`
6 | Arguments | ANY | `_args`

## Dynamic Children Actions

Dynamic children actions can be added to an action by returning an array of actions from the insert children code.
The same parameters that are available to the statement and condition are also available here.

Each action in the returned actions must be an array with the following format:

- 0: Action (created using `zen_context_menu_fnc_createAction`) &lt;ARRAY&gt;
- 1: Array of Children Actions &lt;ARRAY&gt;
- 2: Priority &lt;NUMBER&gt;

These actions are sorted based on priority with all of the children of the action and undergo the same condition checking to be shown.

## Modifier Function

The modifier function can be used to dynamically modify the properties of action, such as its name based on the hovered entity.
This is called before any other handling involving the action (condition checking, dynamic children creation) occurs.

**Passed Parameters:**

- 0: Action (to modify by reference) &lt;ARRAY&gt;
- 1: Parameters (same as statement and condition) &lt;ARRAY&gt;

The action is modified by changing the action array by reference.
Each time the modifier function is called, it receives a new copy of the original action (without any previous modifications).
