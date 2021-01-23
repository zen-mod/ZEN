# Vehicle Garage

Zeus Enhanced adds a Vehicle Garage made specifically for Zeus, allowing curators to customize vehicles to better detail their missions.

The garage can be opened on a vehicle through its attributes display or through the context menu action. On the left are the tab buttons, these toggle their associated lists of texture and component customization options available for the vehicle.

### Apply To All

In order to easily apply the same customization to multiple vehicles, all vehicles intended to be modified can be selected and the garage can be opened on one of them. Pressing the "Apply To All" button will copy the current vehicle's customization to all selected vehicles of the same type.

### Shortcuts

- <kbd>N</kbd> : Cycle between vision modes.
- <kbd>TAB</kbd> : Cycle between tabs.
- <kbd>BACKSPACE</kbd> : Toggle interface visibility.
- <kbd>LMB</kbd> : Show hidden interface.
- <kbd>RMB</kbd> : Toggle interface (when not panning).

### Register a Texture

A custom texture can be made available for the garage by calling the `zen_garage_fnc_defineCustomTexture` function.
This function has an effect on all children of the given base vehicle type.
It is local, and thus must be executed on every Zeus client to have a global effect.

**Arguments:**

 \#   | Description | Type | Default Value (if optional)
:---: | ----------- | ---- | ---------------------------
0 | Base vehicle type | STRING |
1 | Texture variant name | STRING |
2 | Path to texture for each hidden selection | ARRAY |

**Return Value:**

- None

**Example:**
```sqf
[
    "Heli_Light_01_base_F",
    "My new shiny AAF texture",
    [
        "A3\Air_F\Heli_Light_01\Data\heli_light_01_ext_indp_co.paa"
    ]
] call zen_garage_fnc_defineCustomTexture;
```
