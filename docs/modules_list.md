# Modules List

Zeus Enhanced adds a lot of new modules to Zeus, as well as improving some existing ones.
Here is a list of these modules and brief descriptions of what they do (and any usage details).

## Ambient Animation

Plays a ambient animation on the attached AI unit. Animation can be stopped using the same module.
In combat ready mode, the unit will snap out of the animation when a gun is fired near it.

## Ambient Flyby

Creates an aircraft of the selected type that will fly over the module's position from the selected direction.
The height, distance, and speed options allow for further control of the flyby.

## Attach Effect

Attaches an effect (IR Strobe, Chem Light) to the attached group or units of a selected side.
Attached items can be removed using the "None" option.

## Attach Flag

Attaches the selected flag to the attached vehicle or unit.
The flag can be removed using "None" option.

## Attach To

Attaches the object the module is placed on to a selected object.
If the object is already attached, it will be detached.

## Bind Variable

Sets the given variable name in `missionNamespace` to the attached object.
Selecting the public option will broadcast this value.

## Change Height

Changes the height of the attached object by the given value.

## Chatter

Sends the entered message AI communication over chat.
When placed on a unit, sends the message from the unit over the selected channel.
When not placed on a unit, sends the message from the HQ element of the selected side.

## Convoy Parameters

Sets the convoy parameters (separation, speed, stay on road) of the attached land vehicle.
This should be used on all vehicles in a convoy which are ideally in the same group.

## Create IED

Makes the attached object act as an IED that is activated by the selected side within the selected radius.
The "Extreme" explosion size option creates many explosions all around the IED instead of a single explosion.
IEDs that are able to be jammed will not be activated by vehicles equipped with an ECM.

## Create Minefield

Creates a minefield of the given area centered at the module's position filled with the selected mine types.
The mine density option affects the spacing of the mines from: Very Low = 30 m to Very High = 10 m.

!> Caution should be used when using a large area with a high mine density.

## Damage Buildings

Sets the damaged state of the nearest building to the module or all buildings within the given radius, depending on the selected mode.
In nearest mode, only damage states that the nearest building supports are selectable.
In radius mode, the module will default to undamaged if a building does not support the selected state.

!> Enabling destruction effects when using the module on a large amount of buildings can create a lot of lag.

## Earthquake

Creates an earthquake of the selected intensity and radius around the module.
Optionally, the earthquake can damage a random amount of buildings (increasing with intensity) within the radius.

## Equip With ECM

Equips the attached vehicle with an ECM which prevents the detonation of jammable IEDs.

## Fly Height

Sets the flying altitude of the attached aircraft relative to the ground.

## Functions Viewer

Opens the functions viewer.

## Global Hint

Sends the entered message as a global hint.
The message preview shows the message with all of the formatting applies.

## Heal

Heals the attached unit. Works with BI's scripted revive system and ACE medical.

## Hide Zeus

Hides or unhides the Zeus player and bird.

## Light Source

Creates a light source of the selected color, range, and attenuation.
The light source can be edited by double clicking the module it is attached to.

## Make Invincible

Makes the attached object and optionally its crew invincible.
Invincibility can be removed using this module as well.

## Patrol Area

Makes the attached group patrol an area of the given radius with the selected behavior.

## Promote To Zeus

Assigns the attached player as a Zeus.

## Set Date

Sets the current date (and time of day) in the mission.

## Show In Config

Opens the config viewer. If placed on an object, the config viewer will be opened to that object's config entry.

## Side Relations

Modifies the relationship between two sides (BLUFOR, OPFOR, Independent).
Optionally, the relationship change can be broadcast over the respective side's radios.

## Sit On Chair

Makes the attached unit sit on a chair of the selected type.
The unit will stand up if it is already sitting.

## Smoke Pillar

Creates a persistent smoke pillar of the selected type.

## Teleport Players

Teleports players from the selected side, group(s), or individual player(s) to the module's position.
If the module is placed on a vehicle, players will be teleported into the vehicle.

## Toggle Simulation

Toggles the simulation of the attached object.

## Toggle Visibility

Toggles the visibility of the attached object.

## Update Editable Objects

Adds or removes editable objects of the selected types from the local or all curators.
The module can be used in "All Mission Objects" mode to avoid having to place it near objects and input a radius.

## USS Freedom

Spawns the USS Freedom aircraft carrier.

## USS Liberty

Spawns the USS Liberty destroyer.
