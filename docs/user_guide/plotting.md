# Plotting

This feature helps you measure distances and directions with 3D and map plots. 
You can set the starting and ending points to be either fixed locations or attached to an object, allowing the values to update dynamically.

You can cycle between different distance, speed, and azimuth formats using the <kbd>Ctrl</kbd>+<kbd>R</kbd>, <kbd>Alt</kbd>+<kbd>R</kbd>, and <kbd>Ctrl</kbd>+<kbd>T</kbd> keys, which can be customized in the CBA Keybinding settings. 
You can also change the plot colors in the CBA settings.

## Measure Distance

This action creates a simple line. It calculates the 3D distance between the starting and ending points and shows it at the end of the line. 

Next to the distance, the travel time is shown in the format M:SS or H:MM:SS, based on the currently selected speed. 
You can change the speed by pressing <kbd>Shift</kbd>+<kbd>R</kbd> by default. 
If the start point is attached to a unit, the speed of the unit is used instead.

The azimuth at the end point indicates the direction from the start point to the end point.

## Measure Radius

This action draws a circle with the starting point at the center. 
The radius of the circle is determined by the 3D distance between the start and end points. 
Same as in [Measure Distance](#measure-distance), the travel time is shown next to the distance.
The azimuth at the end point indicates the direction from the center to the end point.

## Measure Offset

This action creates a rectangular cuboid, using the starting point as one corner and the ending point as the opposite corner. 
The end point displays the offsets in the X, Y, and Z axes relative to the starting point.

## Clear Plots

This action removes all measurement plots from the display.
