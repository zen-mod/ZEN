# Custom Modules

The ZEN custom modules framework allows addon and mission makers to add their own modules to the Zeus interface through script.

!> A maximum of **100** custom modules can be added.

## Registering A Module

A new module can be added by calling the `zen_custom_modules_fnc_register` function.
Modules are added locally and as a result the function must be executed on each client in order to have global effects.

**Arguments:**

 \#   | Description | Type | Default Value (if optional)
:---: | ----------- | ---- | ---------------------------
0 | Category | STRING |
1 | Module Name | STRING |
2 | Function | CODE |
3 | Icon File | STRING | `"\a3\modules_f\data\portraitmodule_ca.paa"`

**Return Value:**

- Successfully Registered &lt;BOOL&gt;

**Example:**

```sqf
["Custom Modules", "Cool Hint", {hint str _this}] call zen_custom_modules_fnc_register
```

## Module Function

The module function is executed in the **unscheduled** environment on the client that placed the module.

**Passed Parameters:**

 \#   | Description | Type | Notes
:---: | ----------- | ---- | -----
0 | Module Position | ARRAY | In ASL format
1 | Attached Object | OBJECT | `objNull` if not attached
