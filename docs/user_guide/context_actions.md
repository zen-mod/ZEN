# Context Actions

Zeus Enhanced adds many commonly used Zeus actions to its context menu framework.

Some actions require hovering over the relevant entity when opening the menu, while others work with all currently selected Zeus entities of that type. Furthermore, for quality of life with some actions, the hovered entity when the menu is opened is included in the selected entities.

Since it is not possible to overwrite the "place waypoint on right-click" behavior when AI units are selected in Zeus, the context menu can be opened using both the right mouse button and CBA keybind (default: <kbd>V</kbd>). Additionally, the menu can be disabled or set to keybind only mode using the relevant CBA settings.

Here is a list of these actions and brief descriptions on what they do (and any usage details).

## Behavior

Applies the selected behavior to all currently selected groups.

## Captives

Toggles the captive/surrender state of all currently selected units. Requires ACE Captives to be installed.

## Combat Mode

Applies the selected combat mode to all currently selected groups.

## Create Area Marker

Creates an [area marker](/user_guide/area_markers.md) at the context menu's position.
Available only when the context menu is opened on the map.

## Door State

Sets the state of the selected door (closed, locked, opened).
Available when the context menu is opened with the cursor hovering over a door.

## Editable Objects

Allows Zeus to add or remove editable objects within the selected radius.
Clicking the main action will open the "Update Editable Objects" module display.

## Fire Artillery

Makes all currently selected artillery units fire the selected ammo type at the specified position.

## Formation

Applies the selected formation to all currently selected groups.

## Heal

Heals all selected units based on the on the mode (all, players, AI).

## Inventory

Opens the inventory display for the hovered object.
Sub-actions allow for copying and pasting the hovered object's inventory onto another.
The main action acts as a shortcut for the "Edit" sub-action.

## Loadout

Opens the preferred arsenal type (specified in CBA settings) on the hovered unit.
Sub-actions allow for copying and pasting the hovered unit's loadout onto another and resetting the unit's loadout to the config defined one. Furthermore, the unit's current weapon can be switched between the rifle, the handgun and the binoculars.
The main action acts as a shortcut for the "Edit" sub-action.

## Remote Control

Starts the remote control process on the hovered unit or vehicle.

## Speed

Applies the selected speed mode to all currently selected groups.

## Stance

Applies the selected stance to all currently selected AI units.

## Teleport Players

Teleports all currently selected players to the specified position.
The actions starts the 3D position selection process which confirms where to teleport the players.

## Teleport Zeus

Teleports Zeus to the position where the context menu is opened (top left corner).

## Vehicle Appearance

Opens the Zeus garage on the hovered vehicle.
Sub-actions allow for copying and pasting the hovered vehicle's customization onto another.
The main action acts as a shortcut for the "Edit" sub-action.

## Vehicle Logistics

Allows Zeus to repair, rearm, and refuel all selected vehicles based on selected sub-action.
