# Modules List

Zeus Enhanced adds a lot of new modules to Zeus, as well as improving some existing ones.
Here is a list of these modules and brief descriptions of what they do (and any usage details).

## Add Full Arsenal

Adds a full arsenal to the attached object. The type of arsenal added is based on the "Preferred Arsenal" setting.

## Ambient Animation

Plays a ambient animation on the attached AI unit. Animation can be stopped using the same module.
In combat ready mode, the unit will snap out of the animation when a gun is fired near it.

## Ambient Flyby

Creates an aircraft of the selected type that will fly over the module's position from the selected direction.
The height, distance, and speed options allow for further control of the flyby.

## Artillery Fire Mission

Makes the attached artillery unit fire the given number of rounds of the selected ammo at a grid position or target module with the given spread.
The "Units" option will make the selected number of additional nearby unit's of the same type also fire.

## Atomic Bomb

Detonates an atomic bomb at the module's position with the specified destruction radius.

## Attach/Detach Effect

Attaches an effect (IR Strobe, Chemlight) to the attached group or units of a selected side.
Attached items can be removed by selecting the "None" option.

## Attach Flag

Attaches the selected flag to the attached vehicle or unit.
The flag can be removed by selecting "None" option.

## Attach To

Attaches the object the module is placed on to a selected object.
If the object is already attached, it will be detached.

## Bind Variable To Object

Sets the given variable name in `missionNamespace` to the attached object.
Selecting the public option will broadcast this value.

## Change Height

Changes the height of the attached object by the given value.

## Change Weather

Immediately changes the weather to the selected values for overcast, rain, lightning, rainbows, wind, gusts, and fog.

## Chatter

Sends the entered message AI communication over chat.
When placed on a unit, sends the message from the unit over the selected channel.
When not placed on a unit, sends the message from the HQ element of the selected side.

## Configure Doors

Opens the 3D door configuration UI on the attached or nearest building.

## Convoy Parameters

Sets the convoy parameters (separation, speed, stay on road) of the attached land vehicle.
This should be used on all vehicles in a convoy which are ideally in the same group.

## Create Area Marker

Creates an [area marker](/user_guide/area_markers.md) at the module's position.
This module must be placed on the map.

## Create/Edit Intel

Creates an object of the selected type and adds action to collect its intel.
The intel is added as a diary record with the given title and text (under the "Intel" subject).
Additionally, the module can be attached to an existing object to add (or edit) an intel action.

## Create IED

Makes the attached object act as an IED that is activated by the selected side within the selected radius.
The "Extreme" explosion size option creates many explosions all around the IED instead of a single explosion.
IEDs that are able to be jammed will not be activated by vehicles equipped with an ECM.

## Create LZ

Creates an LZ module with the given name which can be used in conjunction with other modules (such as the "Spawn Reinforcements" module) to specify a position.
The module also acts as a helipad, which helps in directing AI helicopters to land at a specific position.

## Create Minefield

Creates a minefield of the given area centered at the module's position filled with the selected mine types.
The mine density option affects the spacing of the mines from: Very Low = 30 m to Very High = 10 m.

!> Caution should be used when using a large area with a high mine density.

## Create RP

Creates an RP module with the given name which can be used in conjunction with other modules (such as the "Spawn Reinforcements" module) to specify a position.

## Create Target

Creates a target module with the given name which can be used in conjunction with other modules (such as the "Artillery Fire Mission" module) to specify a position.
Optionally, a laser target for the selected side can be attached to the module.

## Create Teleporter

Creates a teleport location at the attached object or, if not attached, at a newly created flag pole.
Players can use the "Teleport" action on any teleporter objects to teleport between them.
When used on a vehicle, players will first be teleported into an empty seat if possible.

## Crew To Gunner

Orders an AI vehicle occupant to replace the incapacitated or dead gunner.

## Custom Fire

Creates a custom fire effect based on the selected fire color, fire damage, effect size, and particle density, lifetime, speed, size, and orientation.

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

## Execute Code

Executes the entered code on the selected machine(s).
When used in JIP mode, the module can be deleted to stop execution on new JIP clients.

## Export Mission SQF

Outputs SQF code that can be executed to restore the current mission.

## Fly Height

Sets the flying altitude of the attached aircraft relative to the ground.

## Functions Viewer

Opens the functions viewer.

## Garrison Group

Garrisons units from the attached group in nearby buildings.

## Global Hint

Sends the entered message as a global hint.
The message preview shows the message with all of the formatting applied.

## Group Side

Changes the side of the attached unit's group.

## Heal

Heals the attached unit. Works with BI's scripted revive system and ACE medical.

## Hide Zeus

Hides or shows the Zeus player and bird.

## Hide Terrain Objects

Hides or shows terrain objects of the selected types within the specified radius of the module.

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

## Remove Arsenal

Removes any existing arsenal from the attached object. The type of arsenal removed is based on the "Preferred Arsenal" setting.

## Rotate Object

Sets the attached object's pitch, roll, and yaw.

## Set Date

Sets the current date (and time of day) in the mission.

## Show In Config Viewer

Opens the config viewer. If placed on an object, the config viewer will be opened to that object's config entry.

## Side Relations

Modifies the relationship between two sides (BLUFOR, OPFOR, Independent).
Optionally, the relationship change can be broadcast over the respective side's radios.

## Sit On Chair

Makes the attached unit sit on a chair of the selected type.
The unit will stand up if it is already sitting.

## Smoke Pillar

Creates a persistent smoke pillar of the selected type.

## Spawn Reinforcements

Spawns a reinforcement group (at the module's position) composed of the selected units which will be transported to an LZ by the selected vehicle.
Optionally, the group can be made to move to an RP after arriving at the LZ.

The vehicle can be directed to return to its spawn position and despawn or stay at the LZ and provide support.
Air vehicles have additional insertion methods available such as land, paradrop, or fastrope.

## Suicide Bomber

Makes the attached unit act as a suicide bomber that is activated by the selected side within the selected radius.
When the "Dead Man's Switch" option is enabled, the unit will detonate if they die or go unconscious.

When "Auto Seek" is enabled, the unit will actively try to find and move towards nearby units of the activation side.
The range of Auto Seek is based on the unit's spot distance skill with a minimum of 100 meters.

## Suppressive Fire

Makes the attached unit or group perform suppressive fire on a target for the specified amount of time.

## Teleport Players

Teleports players from the selected side, group(s), or individual player(s) to the module's position.
If the module is placed on a vehicle, players will be teleported into the vehicle.

## Toggle Flashlights

Toggles the flashlights of all AI units of the given side (or group, when placed on a unit) to the selected state.
The "Add Gear" option, will add a random, compatible flashlight to unit's weapon if possible and the weapon does not already have one.

## Toggle IR Lasers

Toggles the IR lasers of all AI units of the given side (or group, when placed on a unit) to the selected state.
The "Add Gear" option, will add a random, compatible IR laser to unit's weapon if possible and the weapon does not already have one.

## Toggle Lamps

Sets the state (on/off) of all building light sources such as street lamps within the specified radius.

## Toggle Simulation

Toggles the simulation of the attached object.

## Toggle Visibility

Toggles the visibility of the attached object.

## Tracers

Creates an invisible unit that shoots customizable tracer bursts at a specified target when no players are within 100 m of the module.

## Un-Garrison Group

Un-garrisons units from the attached group.

## Update Editable Objects

Adds or removes editable objects of the selected types from the local or all curators.
The module can be used in "All Mission Objects" mode to avoid having to place it near objects and input a radius.

## USS Freedom

Spawns the USS Freedom aircraft carrier.

## USS Liberty

Spawns the USS Liberty destroyer.

## Vehicle Turret Optics

Modifies the attached vehicle's NVG and TI equipment availability.  
