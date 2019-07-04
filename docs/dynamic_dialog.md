# Dynamic Dialog

The ZEN dynamic dialog framework provides a straightforward way to create simple, but powerful dialogs.

The dynamic dialog framework implements a saved values system which will restore the user's last confirmed selections and restore them when the dialog is opened again. This behavior can be turned off on a control specific basis by setting the "Force Default" argument in the content controls to `true`.

All `STRING` arguments can be stringtable entries which will be automatically localized.

## Creating A Dialog

The heart of the framework is the `zen_dialog_fnc_create` function, the arguments of which detail the structure and actions of the dialog.

**Arguments:**

 \#   | Description | Type | Default Value (if optional)
:---: | ----------- | ---- | ---------------------------
0 | Title | STRING |
1 | Content | ARRAY |
2 | On Confirm | CODE |
3 | On Cancel | CODE | `{}`
4 | Arguments | ANY | `[]`

**Return Value:**

- Dialog Created &lt;BOOL&gt;

## Content Controls

The "Content" argument specifies the various controls the make up the dialog, in the order they appear.

Each content control is defined in a sub-array in the content array with the same arguments except for the control specific arguments. Here is a break down of the sub-array:

\#   | Description | Type | Default Value (if optional)
:---: | ----------- | ---- | ---------------------------
0 | Control Type | STRING |
1 | Display Name and Tooltip | STRING or ARRAY
2 | Control Specific Argument(s) | --- |
3 | Force Default | BOOL | `false`

The control specific arguments(s) for the 8 currently available control types are detailed below. The return value is the value returned by this control type in the dialog values array (detailed further below).

### Checkbox `CHECKBOX`

A simple checkbox control.

**Control Specific Argument(s):**

- Default checked state &lt;BOOL&gt;

**Return Value:**

- Checked &lt;BOOL&gt;

### Color `COLOR`

A color picker control supporting both RGB and RGBA colors. The color picker type depends on the length of the default color array (3 or 4 with values between 0 and 1; standard Arma color format).

**Control Specific Argument(s):**

- Default color &lt;ARRAY&gt;

**Return Value:**

- Color &lt;ARRAY&gt;

### Combo Box `COMBO`

A combo box control with support for detailing specific entries.

**Control Specific Argument(s):**

- 0: Values that can be returned &lt;ARRAY&gt;
- 1: Corresponding pretty names (see below) &lt;ARRAY&gt;
- 2: Default index &lt;NUMBER&gt;

**Pretty Names:**

The corresponding pretty names array can have elements in the following format, only the display name is required.

- 0: Display name &lt;STRING&gt;
- 1: Tooltip &lt;STRING&gt;
- 2: Picture &lt;STRING&gt;
- 3: Text color RGBA &lt;ARRAY&gt;

**Return Value:**

- Value &lt;ANY&gt;

### Edit Box `EDIT`

A single line edit box with support for an optional sanitizing function.
The function is called on every key press with the full text as an argument and its return value is the resulting text.

**Control Specific Argument(s):**

- 0: Default text &lt;STRING&gt;
- 1: Sanitizing function &lt;CODE&gt;

**Return Value:**

- Text &lt;STRING&gt;

### List Box `LIST`

A list box control with support for detailing specific entries.
This control type works identically to the combo box control type except for the format in which the entries are presented (list view rather than a drop down).
In addition, this control type accepts an additional height argument to change how tall the list box is.

**Control Specific Argument(s):**

- 0: Values that can be returned &lt;ARRAY&gt;
- 1: Corresponding pretty names (see above) &lt;ARRAY&gt;
- 2: Default index &lt;NUMBER&gt;
- 3: Height &lt;NUMBER&gt;

**Return Value:**

- Value &lt;ANY&gt;

### Side Select `SIDES`

A side selection control with clickable icons for the BLUFOR, OPFOR, Independent, and Civilian sides.

**Control Specific Argument(s):**

- Default side &lt;SIDE&gt;

**Return Value:**

- Side &lt;SIDE&gt;

### Slider `SLIDER`

A slider control with an attached edit box which can both be used to change the value.

**Control Specific Argument(s):**

- 0: Minimum value &lt;NUMBER&gt;
- 1: Maximum value &lt;NUMBER&gt;
- 2: Default value &lt;NUMBER&gt;
- 3: Number of displayed decimal (0, 1, or 2) &lt;NUMBER&gt;

**Return Value:**

- Value &lt;NUMBER&gt;

### Toolbox `TOOLBOX`

A toolbox selection control with support for 2 to 5 options.

Two sub-types exist for this control type, mostly for QOL - `TOOLBOX:YESNO` and `TOOLBOX:ENABLED`.
When either sub-type is used, it is not necessary to specify the option names.

The return value type depends on the given default value:
- `BOOL` type is only available for toolbox controls with 2 options
- `NUMBER` type represents the index of the default option

**Control Specific Argument(s):**

- 0: Default value &lt;BOOL|NUMBER&gt;
- 1: Option names &lt;ARRAY&gt;

**Return Value:**

- Value &lt;BOOL|NUMBER&gt;

### Vector `VECTOR`

A vector input control with support for both XY and XYZ vectors.
The number of axes displayed depends on the length of the default value array (2 or 3).

**Control Specific Argument(s):**

- Default vector &lt;ARRAY&gt;

**Return Value:**

- Vector &lt;ARRAY&gt;

## On Confirm and On Cancel

The `On Confirm` and `On Cancel` code blocks are both executed in the **unscheduled** environment when the dialog is closed.
The on confirm code is called only when the user presses the "OK" button, otherwise the on cancel code is called.

These code blocks are passed the following parameters:

- 0: Dialog values &lt;ARRAY&gt;
    - Values returned by the content controls, in the same order as the contents array.
- 1: Arguments &lt;ANY&gt;
    - Same as those passed to the function to when creating the dialog.
