# Plotting

This feature helps you measure distances and directions with 3D and map plots. 
You can set the starting and ending points to be either fixed locations or attached to an object, allowing the values to update dynamically.

You can cycle between different distance and azimuth formats using the <kbd>R</kbd> and <kbd>Tab &#8633;</kbd> keys, which can be customized in the CBA Keybinding settings. 
You can also change the plot colors in the CBA settings.

## Measure Distance

This action creates a simple line. It calculates the 3D distance between the starting and ending points and shows it at both ends of the line. 
The azimuth at the end point indicates the direction from the start point to the end point, while the azimuth at the start point shows the direction from the end point back to the start.

## Measure Radius

This action draws a circle with the starting point at the center. 
The radius of the circle is determined by the 3D distance between the start and end points. 
The azimuth at the end point indicates the direction from the center to the end point.

## Measure Offset

This action creates a rectangular cuboid, using the starting point as one corner and the ending point as the opposite corner. 
The end point displays the offsets in the X, Y, and Z axes relative to the starting point.

## Clear Plots

This action removes all measurement plots from the display.
