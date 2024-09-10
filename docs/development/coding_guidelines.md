# Coding Guidelines

## 1. Naming Conventions

### 1.1 Variable Names

#### 1.1.1 Private Variable Naming

To improve the readability of code, try to use self-explanatory variable names and avoid using single-character variable names.

Example: `_velocity` instead of `_v`

#### 1.1.2 Global Variable Naming

All global variables must start with the ZEN prefix followed by the component, separated by underscores. Global variables may not contain the `fnc_` prefix if the value is not callable code.

Example: `zen_component_variableName`

_For ZEN this is done automatically through the use of the `GVAR` macro family._

#### 1.1.3 Function Naming

All functions shall use ZEN and the component name as a prefix, as well as the `fnc_` prefix behind the component name.

Example: `zen_component_fnc_functionName`

_For ZEN this is done automatically through the usage of the `PREP` macro._

### 1.2 Files & Config

#### 1.2.1 SQF Files

Files containing SQF scripts shall have a file name extension of `.sqf`.

#### 1.2.2 Header Files

All header files shall have the file name extension of `.hpp`.

#### 1.2.3 Own SQF File

All functions shall be put in their own `.sqf` file.

#### 1.2.4 Config Elements

Config files shall be split up into different header files, each with the name of the config and be included in the `config.cpp` of the component.

Example:

```cpp
#include "CfgVehicles.hpp"
```

And in `CfgVehicles.hpp`:

```cpp
class CfgVehicles {
    // Content
};
```

#### 1.2.5 Addon Template

An addon template is available at the [extras/blank](https://github.com/zen-mod/ZEN/tree/master/extras/blank) repo directory.

### 1.3 Stringtable

All text that shall be displayed to a user shall be defined in a `stringtable.xml` file for multi-language support.

- There shall be no empty stringtable language values.
- All stringtables shall follow the format as specified by [Tabler](https://github.com/bux/tabler) and the [translation guidelines](http://ace3mod.com/wiki/development/how-to-translate-ace3.html) form.

## 2. Macro Usage

### 2.1 Component/PBO Specific Macro Usage

The family of `GVAR` macros define global variable strings or constants for use within a component. Please use these to make sure we follow naming conventions across all components and also prevent duplicate/overwriting between variables in different components. The macro family expands as follows, for the example of the component 'balls':

Macro | Expands To
----- | ----------
`GVAR(face)` | `zen_balls_face`
`QGVAR(face)` | `"zen_balls_face"`
`QQGVAR(face)` | `""zen_balls_face""` used inside `QUOTE` macros where double quotation is required.
`EGVAR(leg,face)` | `zen_leg_face`
`QEGVAR(leg,face)` | `"zen_leg_face"`
`QQEGVAR(leg,face)` | `""zen_leg_face""` used inside `QUOTE` macros where double quotation is required.

There also exists the `FUNC` family of Macros:

Macro | Expands To
----- | ----------
`FUNC(face)` | `zen_balls_fnc_face`
`EFUNC(leg,face)` | `zen_leg_fnc_face`
`LINKFUNC(face)` | `FUNC(face)` or "pass by reference" `{_this call FUNC(face)}`
`QFUNC(face)` | `"zen_balls_fnc_face"`
`QEFUNC(leg,face)` | `"zen_leg_fnc_face"`
`QQFUNC(face)` | `""zen_balls_fnc_face""` used inside `QUOTE` macros where double quotation is required.
`QQEFUNC(leg,face)` | `""zen_leg_fnc_face""` used inside `QUOTE` macros where double quotation is required.

The `LINKFUNC` macro allows for the recompiling of a function used in event handler code when function caching is disabled. Example: `player addEventHandler ["Fired", LINKFUNC(firedEH)];` will run updated code after each recompile.

### 2.2 General Purpose Macros

[CBA script_macros_common.hpp](https://github.com/CBATeam/CBA_A3/blob/master/addons/main/script_macros_common.hpp)

`QUOTE()` is utilized within configuration files for bypassing the quote issues in configuration macros. So, all code segments inside a given config should utilize wrapping in the `QUOTE()` macro instead of direct strings. This allows us to use our macros inside the string segments, such as `QUOTE(_this call FUNC(balls))`

#### 2.2.1 `setVariable`, `getVariable` Family Macros

These macros are allowed but are not enforced.

Macro | Expands To
----- | ----------
`GETVAR(player,MyVarName,false)` | `player getVariable ["MyVarName", false]`
`GETMVAR(MyVarName,objNull)` | `missionNamespace getVariable ["MyVarName", objNull]`
`GETUVAR(MyVarName,displayNull)` | `uiNamespace getVariable ["MyVarName", displayNull]`
`SETVAR(player,MyVarName,127)` | `player setVariable ["MyVarName", 127]`
`SETPVAR(player,MyVarName,127)` | `player setVariable ["MyVarName", 127, true]`
`SETMVAR(MyVarName,player)` | `missionNamespace setVariable ["MyVarName", player]`
`SETUVAR(MyVarName,_control)` | `uiNamespace setVariable ["MyVarName", _control]`

#### 2.2.2 STRING Family Macros

Requires that the strings be defined in the component's `stringtable.xml` is the correct format: `STR_ZEN_<component>_<string>`

Example: `STR_ZEN_Balls_Banana`

Script strings (still require `localize` to localize the string):

Macro | Expands To
----- | ----------
`LSTRING(banana)` | `"STR_ZEN_balls_banana"` |
`ELSTRING(leg,banana)` | `"STR_ZEN_leg_banana"` |


Config Strings (require `$` as first character):

Macro | Expands To
----- | ----------
`CSTRING(banana)` | `"$STR_ZEN_balls_banana"` |
`ECSTRING(leg,banana)` | `"$STR_ZEN_leg_banana"` |

### 2.2.3 Path Family Macros

The family of path macros define global paths to files for use within a component. Please use these to reference files in the ZEN project. The macro family expands as follows, for the example of the component 'balls':

Macro | Expands To
----- | ----------
`PATHTOF(data\banana.p3d)` | `\x\zen\addons\balls\data\banana.p3d`
`QPATHTOF(data\banana.p3d)` | `"\x\zen\addons\balls\data\banana.p3d"`
`PATHTOEF(leg,data\banana.p3d)` | `\x\zen\addons\leg\data\banana.p3d`
`QPATHTOEF(leg,data\banana.p3d)` | `"\x\zen\addons\leg\data\banana.p3d"`


## 3. Functions

Functions shall be created in the `functions\` subdirectory and named `fnc_functionName.sqf`. They shall then be indexed via the `PREP(functionName)` macro in the component's `XEH_PREP.hpp` file.

The `PREP` macro allows for CBA function caching, which drastically speeds up load times.

!> Beware though that function caching is enabled by default and as such to disable it you need to uncomment `#define DISABLE_COMPILE_CACHE` in the component's `script_component.hpp` file.

### 3.1 Headers

Every function should have a header with the following format at the start of their function file. This is not necessary for inline functions or functions not contained in their own file.

```sqf
/*
 * Author: [Name of Author(s)]
 * [Description]
 *
 * Arguments:
 * 0: First Argument <STRING>
 * 1: Second Argument <OBJECT>
 * 2: Multiple Input Types <STRING|ARRAY|CODE>
 * 3: Optional Argument <BOOL> (default: true)
 * 4: Unused Argument (not used) <NUMBER>
 *
 * Return Value:
 * Return Value <BOOL>
 *
 * Example:
 * ["example", player] call zen_common_fnc_example
 *
 * Public: [Yes/No]
 */
```

A return value of "None" should be used when the functions returns `nil` or its return value has no meaning.

### 3.2 Includes

Every function should include the `script_component.hpp` file at the start, above the function header. Any additional includes must be below this include. Any defines should be below the function header.

All code must be written below the aforementioned items.

#### 3.2.1 Reasoning

This ensures every function starts of in a uniform manner and enforces function documentation.

## 4. Global Variables

All global variables should be defined in the `XEH_preInit.sqf` file of the component they will be used in with an initial default value.

Exceptions:
- Dynamically generated global variables.
- Variables that do not originate from the ZEN project, such as BI global variables or third party such as CBA.

## 5. Code Style

To help you follow the coding style we recommend you get the [EditorConfig](http://editorconfig.org/#download) plugin for your editor. It will help with correcting indentations and deleting trailing spaces.

### 5.1 Braces Placement

Braces `{ }` which enclose a code block will have the first bracket placed behind the statement in case of `if`, `switch` statements or `while`, `waitUntil` and `for` loops. The second brace will be placed on the same column as the statement but on a separate line.

- Opening brace on the same line as keyword.
- Closing brace on own line, same level of indentation as keyword.

**Good:**

```cpp
class Something: Or {
    class Other {
        foo = "bar";
    };
};
```

**Bad:**

```cpp
class Something : Or
{
    class Other
    {
        foo = "bar";
    };
};
```

**Bad:**

```cpp
class Something : Or {
    class Other {
        foo = "bar";
        };
    };
```

When using `if`/`else`, the `else` must be on the same line as the closing brace:

```sqf
if (alive _unit) then {
    _unit setDamage 1;
} else {
    hint ":(";
};
```

In cases where there are a lot of one-liner classes, something like this is allowed to save space:

```cpp
class One {foo = 1};
class Two {foo = 2};
class Three {foo = 3};
```

#### 5.1.1 Reasoning

Putting the opening brace in its own line wastes a lot of space, and keeping the closing brace on the same level as the keyword makes it easier to recognize what exactly the brace closes.

### 5.2 Indentation

Every new scope should be on a new indent. This will make the code easier to understand and read. Indentations consist of 4 spaces. Tabs are not allowed. Tabs or spaces are not allowed to trail on a line, last character needs to be non blank.

**Good:**

```sqf
call {
    call {
        if (/* condition */) then {
            /* code */
        };
    };
};
```

**Bad:**

```sqf
call {
        call {
        if (/* condition */) then {
            /* code */
        };  
        };
};
```

### 5.3 Inline Comments

Inline comments should use `//`. Usage of `/* */` is allowed for larger comment blocks.

Example:

```sqf
//// Comment   // < incorrect
// Comment     // < correct
/* Comment */  // < correct
```

### 5.4 Comments In Code

All code shall be documented by comments that describe what is being done. This can be done through the function header and/or inline comments.

Comments within the code shall be used when they are describing a complex and critical section of code or if the subject code does something a certain way because of a specific reason. Unnecessary comments in the code are not allowed.

**Good:**

```sqf
// find the object with the most blood loss
_highestObj = objNull;
_highestLoss = -1;
{
    if ([_x] call EFUNC(medical,getBloodLoss) > _highestLoss) then {
        _highestLoss = [_x] call EFUNC(medical,getbloodloss);
        _highestObj = _x;
    };
} foreach _units;
```

**Good:**

```sqf
// Check if the unit is an engineer
_object getvariable [QGVAR(engineerSkill), 0] >= 1;
```

**Bad:**

```sqf
// Get the engineer skill and check if it is above 1
_object getvariable [QGVAR(engineerSkill), 0] >= 1;
```

**Bad:**

```sqf
// Get the variable myValue from the object
_myValue = _object getvariable [QGVAR(myValue), 0];
```

**Bad:**

```sqf
// Loop through all units to increase the myValue variable
{
    _x setvariable [QGVAR(myValue), (_x getvariable [QGVAR(myValue), 0]) + 1];
} forEach _units;
```

### 5.5 Parentheses Around Code

When making use of parentheses `( )`, use as few as possible, unless doing so decreases readability of the code.

Avoid statements such as:

```sqf
if (!(_value)) then {};
```

The following is allowed, but unnecessary:

```sqf
_value = (_array select 0) select 1;
```

Any conditions in statements shall always be wrapped around brackets.

```sqf
if (!_value) then {};
if (_value) then {};
```

### 5.6 Magic Numbers

There shall be no magic numbers. Any magic number shall be put in a define either on top of the `.sqf` file (below the header), or in the `script_component.hpp` file in the root directory of the component (recommended) in case it is used in multiple locations.

**Magic numbers are any of the following:**

- A constant numerical or text value used to identify a file format or protocol.
- Distinctive unique values that are unlikely to be mistaken for other meanings.
- Unique values with unexplained meaning or multiple occurrences which could (preferably) be replaced with named constants.

[Source](http://en.wikipedia.org/wiki/Magic_number_%28programming%29)

### 5.7 Spaces Between Array Elements
When using array notation `[]`, always use a space between elements to improve code readability.

**Good:**

```sqf
params ["_unit", "_vehicle"];
private _pos = [0, 0, 0];
```

**Bad:**

```sqf
params ["_unit","_vehicle"];
private _pos = [0,0,0];
```


### 5.8 Command Names

Command names will be written with the proper capitalization. For example, `addEventHandler` is good whereas `addeventhandler` is not allowed.

## 6. Code Standards

### 6.1 Error Testing

If a function returns error information, then that error information will be tested.

### 6.2 Unreachable Code

There shall be no unreachable code.

### 6.3 Function Parameters

Parameters of functions must be retrieved through the usage of the `param` or `params` commands. If the function is part of the public API, parameters must be checked on allowed data types and values through the usage of the `param` and `params` commands.

Usage of the CBA Macro `PARAM_x` or function `BIS_fnc_param` is not allowed within the ZEN project.

### 6.4 Return Values

Functions and code blocks that specify a return a value must have a meaningful return value. If there is no meaningful return value, the function should return `nil`.

### 6.5 Private Variables

All private variables shall make use of the `private` keyword on initialization. When declaring a private variable before initialization, usage of the `private ARRAY` syntax is allowed. All private variables must be either initialized using the `private` keyword, or declared using the `private ARRAY` syntax.

Exceptions to this rule are variables obtained from an array, which shall be done with usage of the `params` command family, which ensures the variable is declared as private.

**Good:**

```sqf
private _myVariable = "hello world";
```

**Good:**

```sqf
_myArray params ["_elementOne", "_elementTwo"];
```

**Bad:**

```sqf
_elementOne = _myArray select 0;
_elementTwo = _myArray select 1;
```

### 6.6 Lines of Code

Any one function shall contain no more than 250 lines of code, excluding the function header and any includes.

### 6.7 Variable Declarations

Declarations should be at the smallest feasible scope.

**Good:**

```sqf
if (call FUNC(myCondition)) then {
   private _areAllAboveTen = true; // <- smallest feasable scope

   {
      if (_x >= 10) then {
         _areAllAboveTen = false;
      };
   } forEach _anArray;

   if (_areAllAboveTen) then {
       hint "all values are above ten!";
   };
}
```

**Bad:**

```sqf
private _areAllAboveTen = true; // <- this is bad, because it can be initialized in the if statement
if (call FUNC(myCondition)) then {
   {
      if (_x >= 10) then {
         _areAllAboveTen = false;
      };
   } forEach _anArray;

   if (_areAllAboveTen) then {
       hint "all values are above ten!";
   };
};
```

### 6.8 Variable Initialization

Private variables will not be introduced until they can be initialized with meaningful values.

**Good:**

```sqf
private _myVariable = 0; // good because the value will be used
{
    _x params ["_value", "_amount"];
    if (_value > 0) then {
        _myVariable = _myVariable + _amount;
    };
} forEach _array;
```

**Good:**

```sqf
private _myVariable = [1, 2] select _condition;
```

**Bad:**

```sqf
private _myVariable = 0; // Bad because it is initialized with a zero, but this value does not mean anything
if (_condition) then {
    _myVariable = 1;
} else {
    _myVariable = 2;
};
```

### 6.9 Initialization Expression in `for` Loops

The initialization expression in a `for` loop shall perform no actions other than to initialize the value of a single `for` loop parameter.

### 6.10 Increment Expression in `for` Loops

The increment expression in a `for` loop shall perform no action other than to change a single loop parameter to the next value for the loop.

### 6.11 `getVariable`

When using `getVariable`, there shall either be a default value given in the statement or the return value shall be checked for correct data type(s) as well as return value. A default value may not be given after a `nil` check.

**Bad:**

```sqf
_return = _object getVariable "varName";
if (isNil "_return") then {_return = 0};
```

**Good**:

```sqf
_return = _object getVariable ["varName", 0];
```

**Good**:

```sqf
_return = _object getVariable "varName";
if (isNil "_return") exitWith {};
```

### 6.12 Global Variables

Global variables should not be used to pass along information from one function to another. Use arguments instead.

**Bad:**

```sqf
fnc_example = {
    hint GVAR(myVariable);
};
```

```sqf
GVAR(myVariable) = "hello my variable";
call fnc_example;
```

**Good:**

```sqf
fnc_example = {
   params ["_content"];
   hint _content;
};
```

```sqf
["hello my variable"] call fnc_example;
```

### 6.13 Temporary Objects & Variables

Unnecessary temporary objects or variables should be avoided.

### 6.14 Commented Out Code

Code that is not used (commented out) shall be deleted.

### 6.15 Constant Global Variables

There shall be no constant global variables, constants shall be put in a `#define`.

### 6.16 Constant Private Variables

Constant private variables that are used more as once shall be put in a `#define`.

### 6.17 Logging

Functions shall whenever possible and logical, make use of logging functionality through the logging and debugging macros from CBA.

### 6.18 Code Used More than Once

Any code that could/is used more than once, shall be put in a separate `.sqf` file and made a function, unless this code is less as 5 lines and used only in a per-frame handler.

## 7. Design considerations

### 7.1 Readability vs Performance

This is a large open source project that will get many different maintainers in its lifespan. When writing code, keep in mind that other developers also need to be able to understand your code. Balancing readability and performance of code is not a black and white subject. The rule of thumb is:

- When improving performance of code that sacrifices readability (or visa-versa), first see if the design of the implementation is done in the best way possible.
- Document that change with the reasoning in the code.

### 7.2 Scheduled vs Unscheduled

Avoid the usage of scheduled space as much as possible and stay in unscheduled. This is to provide a smooth experience to the user by guaranteeing code to run when we want it.

This also helps avoid various bugs as a result of unguaranteed execution sequences when running multiple scripts.

### 7.3 Event Driven

All ZEN components shall be implemented in an event driven fashion. This is done to ensure code only runs when it is required and allows for modularity through low coupling components.

Event handlers in ZEN are implemented through the CBA Event System. They should be used to trigger or allow triggering of specific functionality.

More information on the [CBA Events System](https://github.com/CBATeam/CBA_A3/wiki/Custom-Events-System) and [CBA Player Events](https://github.com/CBATeam/CBA_A3/wiki/Player-Events) pages.

#### 7.3.1 BI Event Handlers

BI's event handlers (`addEventHandler`, `addMissionEventHandler`, `displayAddEventHandler`, `ctrlAddEventHandler`) are **slow** when passing a large code variable. Use a short code block that calls the function you want.

```sqf
addMissionEventHandler ["Draw3D", FUNC(onDraw3D)]; // Bad
addMissionEventHandler ["Draw3D", {call FUNC(onDraw3D)}]; // Good
```

### 7.4 Hashes

When a key value pair is required, make use of the hash implementation from CBA.

Hashes are a variable type that store key value pairs. They are not implemented natively in SQF, so there are a number of functions provided by CBA for their usage in ZEN. If you are unfamiliar with the idea, they are similar in function to `setVariable`/`getVariable` but do not require an object to use.

Hashes are implemented with SQF arrays, and as such they are passed by reference to other functions. Remember to make copies (using the `+` operator) if you intend for the hash to be modified without changing the original value.

## 8. Performance Considerations

### 8.1 Adding Elements to Arrays

When adding new elements to an array, `pushBack` shall be used instead of the binary addition or `set`. When adding multiple elements to an array `append` may be used instead.

**Good:**

```sqf
_a pushBack _value;
```

**Good:**

```sqf
_a append [1,2,3];
```

**Bad:**

```sqf
_a set [count _a, _value];
_a = _a + [_value];
```

When adding an new element to a dynamic location in an array or when the index is pre-calculated, `set` may be used.

When adding multiple elements to an array, the binary addition may be used for the entire addition.

### 8.2 `createVehicle`

`createVehicle` array shall be used.

### 8.3 `createVehicle(Local)` Position

`createVehicle(Local)` used with a non-`[0, 0, 0]` position performs search for empty space to prevent collisions on spawn.
Where possible `[0, 0, 0]` position shall be used, except on `#` objects (e.g. `#lightsource`, `#soundsource`) where empty position search is not performed.

This code requires **~1.00ms** and will be higher with more objects near wanted position:

```sqf
_vehicle = _type createVehicleLocal _posATL;
_vehicle setposATL _posATL;
```

While this one requires **~0.04ms**:

```sqf
_vehicle = _type createVehicleLocal [0, 0, 0];
_vehicle setposATL _posATL;
```

### 8.4 Unscheduled vs Scheduled

All code that has a visible effect for the user or requires time specific guaranteed execution shall run in the unscheduled environment.

### 8.5 Avoid `spawn` & `execVM`

`execVM` and `spawn` are to be avoided wherever possible.

### 8.6 Empty Arrays

When checking if an array is empty `isEqualTo` shall be used.

### 8.7 `for` Loops

```sqf
for "_y" from # to # step # do { ... }
```

shall be used instead of

```sqf
for [{ ... }, { ... }, { ... }] do { ... };
```

whenever possible.

### 8.8 `while` Loops

While is only allowed when used to perform a unknown finite amount of steps with unknown or variable increments. Infinite `while` loops are not allowed.

**Good:**

```sqf
_original = _object getvariable [QGVAR(value), 0];

while {_original < _weaponThreshold} do {
    _original = [_original, _weaponClass] call FUNC(getNewValue);
}
```

**Bad:**

```sqf
while {true} do {
    // anything
};
```

### 8.9 `waitUntil`

The `waitUntil` command shall not be used. Instead, make use of CBA's `CBA_fnc_waitUntilAndExecute`

```sqf
[{
    params ["_unit"];
    _unit getVariable [QGVAR(myVariable), false];
}, {
    params ["_unit"];
    // Execute any code
}, [_unit]] call CBA_fnc_waitUntilAndExecute;
```
