/*
 * Author: mharis001
 * Initializes the "Set Date" Zeus module display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_modules_fnc_gui_setDate
 *
 * Public: No
 */
#include "script_component.hpp"

#define YEARS_START 1982
#define YEARS_END   2050

#define FORMAT_TIME(x) ([floor (x), 2] call CBA_fnc_formatNumber)

#define UPDATE_EDIT_BOXES \
    _ctrlHour   ctrlSetText FORMAT_TIME(_value / 3600); \
    _ctrlMinute ctrlSetText FORMAT_TIME(_value / 60 % 60); \
    _ctrlSecond ctrlSetText FORMAT_TIME(_value % 60)

params ["_display"];

private _ctrlButtonOK = _display displayCtrl IDC_OK;
private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);

date params ["_currentYear", "_currentMonth", "_currentDay", "_currentHour", "_currentMinute"];

private _ctrlYear  = _display displayCtrl IDC_SETDATE_YEAR;
private _ctrlMonth = _display displayCtrl IDC_SETDATE_MONTH;
private _ctrlDay   = _display displayCtrl IDC_SETDATE_DAY;

for "_year" from YEARS_START to YEARS_END do {
    _ctrlYear lbSetValue [_ctrlYear lbAdd str _year, _year];
};

_ctrlMonth lbSetCurSel (_currentMonth - 1);
_ctrlDay lbSetCurSel (_currentDay - 1);

private _fnc_changedYearOrMonth = {
    params ["_ctrl"];

    private _display = ctrlParent _ctrl;
    private _ctrlYear  = _display displayCtrl IDC_SETDATE_YEAR;
    private _ctrlMonth = _display displayCtrl IDC_SETDATE_MONTH;
    private _ctrlDay   = _display displayCtrl IDC_SETDATE_DAY;

    private _year = _ctrlYear lbValue lbCurSel _ctrlYear;
    private _month = _ctrlMonth lbValue lbCurSel _ctrlMonth;

    private _days = if (_month == 2) then {
        [28, 29] select (_year % 4 == 0 && {_year % 100 != 0} || {_year % 400 == 0});
    } else {
        31 - (_month - 1) % 7 % 2;
    };

    private _selectedDay = lbCurSel _ctrlDay;
    lbClear _ctrlDay;

    private _weekdayNames = [
        localize "STR_saturday",
        localize "STR_sunday",
        localize "STR_monday",
        localize "STR_tuesday",
        localize "STR_wednesday",
        localize "STR_thursday",
        localize "STR_friday"
    ];

    // Method for calculating day of the week from:
    // https://en.wikipedia.org/wiki/Determination_of_the_day_of_the_week#Zeller%E2%80%99s_algorithm

    private _isJanOrFeb = _month in [1, 2];
    private _calculationYear = [_year, _year - 1] select _isJanOrFeb;
    private _calculationMonth = [_month, _month + 12] select _isJanOrFeb;
    private _centuryYear = _calculationYear mod 100;
    private _centuryIndex = floor (_calculationYear / 100);

    private _simplifiedTerm = floor (13 * (_calculationMonth + 1) / 5) + _centuryYear + floor (_centuryYear / 4) + floor (_centuryIndex / 4) - 2 * _centuryIndex;

    for "_day" from 1 to _days do {
        private _weekday = (_day + _simplifiedTerm) mod 7;

        if (_weekday < 0) then {
            _weekday = _weekday + 7;
        };

        private _index = _ctrlDay lbAdd str _day;
        _ctrlDay lbSetValue [_index, _day];
        _ctrlDay lbSetTextRight [_index, _weekdayNames select _weekday];

        if (_weekday > 1) then {
            _ctrlDay lbSetColorRight [_index, [1, 1, 1, 0.25]];
        };

        private _moonPhase = moonPhase [_year, _month, _day, 0, 0];
        private _picture = switch (true) do {
            case (_moonPhase > 0.964): {
                "\a3\3DEN\Data\Attributes\Date\moon_full_ca.paa"
            };
            case (_moonPhase < 0.036): {
                "\a3\3DEN\Data\Attributes\Date\moon_new_ca.paa"
            };
            default {
                "#(argb,8,8,3)color(0,0,0,0)"
            };
        };
        _ctrlDay lbSetPictureRight [_index, _picture];
    };

    _ctrlDay lbSetCurSel (_selectedDay min (_days - 1));
};

private _fnc_changedDay = {
    params ["_ctrlDay"];

    private _display = ctrlParent _ctrlDay;
    private _ctrlYear  = _display displayCtrl IDC_SETDATE_YEAR;
    private _ctrlMonth = _display displayCtrl IDC_SETDATE_MONTH;

    private _year = _ctrlYear lbValue lbCurSel _ctrlYear;
    private _month = _ctrlMonth lbValue lbCurSel _ctrlMonth;
    private _day = _ctrlDay lbValue lbCurSel _ctrlDay;

    private _date = [_year, _month, _day, 12, 0];
    (_date call BIS_fnc_sunriseSunsetTime) params ["_sunriseTime", "_sunsetTime"];

    private _ctrlPreview = _display displayCtrl IDC_SETDATE_PREVIEW;
    private _ctrlNight1  = _display displayCtrl IDC_SETDATE_NIGHT1;
    private _ctrlNight2  = _display displayCtrl IDC_SETDATE_NIGHT2;
    private _ctrlDaytime = _display displayCtrl IDC_SETDATE_DAYTIME;
    private _ctrlSunrise = _display displayCtrl IDC_SETDATE_SUNRISE;
    private _ctrlSunset  = _display displayCtrl IDC_SETDATE_SUNSET;
    private _ctrlSun     = _display displayCtrl IDC_SETDATE_SUN;

    private _ctrlNight1Pos  = ctrlPosition _ctrlNight1;
    private _ctrlNight2Pos  = ctrlPosition _ctrlNight2;
    private _ctrlDaytimePos = ctrlPosition _ctrlDaytime;
    private _ctrlSunrisePos = ctrlPosition _ctrlSunrise;
    private _ctrlSunsetPos  = ctrlPosition _ctrlSunset;

    private _width = ctrlPosition _ctrlPreview select 2;
    private _offset = (ctrlPosition _ctrlSunrise select 2) * 0.5;

    if (_sunriseTime >= 0 && {_sunsetTime >= 0}) then {
        _ctrlSunrisePos set [0, _sunriseTime / 24  * _width - _offset];
        _ctrlSunsetPos set [0, _sunsetTime / 24  * _width - _offset];
        _ctrlNight1Pos set [2, _ctrlSunrisePos select 0];
        _ctrlNight2Pos set [0, (_ctrlSunsetPos select 0) + (_ctrlSunsetPos select 2)];
        _ctrlNight2Pos set [2, _width - (_ctrlNight2Pos select 0)];
        _ctrlDaytimePos set [0, (_ctrlSunrisePos select 0) + (_ctrlSunrisePos select 2)];
        _ctrlDaytimePos set [2, (_ctrlSunsetPos select 0) - (_ctrlSunrisePos select 0) - (_ctrlSunrisePos select 2)];
        _ctrlSun ctrlShow true;
    } else {
        _ctrlSunrisePos set [0, -1];
        _ctrlSunsetPos set [0, -1];
        _ctrlNight2Pos set [2, 0];
        if (_sunriseTime < 0) then {
            _ctrlNight1Pos set [2, _width];
            _ctrlDaytimePos set [2, 0];
            _ctrlSun ctrlShow false;
        } else {
            _ctrlNight1Pos set [2, 0];
            _ctrlDaytimePos set [0, 0];
            _ctrlDaytimePos set [2, _width];
            _ctrlSun ctrlShow true;
        };
    };

    _ctrlNight1 ctrlSetPosition _ctrlNight1Pos;
    _ctrlNight1 ctrlCommit 0;

    _ctrlNight2 ctrlSetPosition _ctrlNight2Pos;
    _ctrlNight2 ctrlCommit 0;

    _ctrlDaytime ctrlSetPosition _ctrlDaytimePos;
    _ctrlDaytime ctrlCommit 0;

    _ctrlSunrise ctrlSetPosition _ctrlSunrisePos;
    _ctrlSunrise ctrlCommit 0;

    _ctrlSunset ctrlSetPosition _ctrlSunsetPos;
    _ctrlSunset ctrlCommit 0;
};

_ctrlYear  ctrlAddEventHandler ["LBSelChanged", _fnc_changedYearOrMonth];
_ctrlMonth ctrlAddEventHandler ["LBSelChanged", _fnc_changedYearOrMonth];
_ctrlDay   ctrlAddEventHandler ["LBSelChanged", _fnc_changedDay];

_ctrlYear lbSetCurSel (_currentYear - YEARS_START);

private _ctrlSlider = _display displayCtrl IDC_SETDATE_SLIDER;
_ctrlSlider sliderSetPosition (_currentHour * 3600 + _currentMinute * 60);

_ctrlSlider ctrlAddEventHandler ["SliderPosChanged", {
    params ["_ctrlSlider", "_value"];

    private _display = ctrlParent _ctrlSlider;
    private _ctrlHour   = _display displayCtrl IDC_SETDATE_HOUR;
    private _ctrlMinute = _display displayCtrl IDC_SETDATE_MINUTE;
    private _ctrlSecond = _display displayCtrl IDC_SETDATE_SECOND;

    UPDATE_EDIT_BOXES;
}];

_ctrlSlider ctrlAddEventHandler ["MouseZChanged", {
    params ["_ctrlSlider", "_scroll"];

    private _display = ctrlParent _ctrlSlider;
    private _ctrlHour   = _display displayCtrl IDC_SETDATE_HOUR;
    private _ctrlMinute = _display displayCtrl IDC_SETDATE_MINUTE;
    private _ctrlSecond = _display displayCtrl IDC_SETDATE_SECOND;

    private _value = sliderPosition _ctrlSlider + 600 * round _scroll;
    _ctrlSlider sliderSetPosition _value;
    _value = sliderPosition _ctrlSlider;

    UPDATE_EDIT_BOXES;
}];

private _ctrlHour   = _display displayCtrl IDC_SETDATE_HOUR;
private _ctrlMinute = _display displayCtrl IDC_SETDATE_MINUTE;
private _ctrlSecond = _display displayCtrl IDC_SETDATE_SECOND;

_ctrlHour ctrlSetText str _currentHour;
_ctrlMinute ctrlSetText str _currentMinute;

private _fnc_onKillFocus = {
    params ["_ctrl"];

    private _display = ctrlParent _ctrl;
    private _ctrlSlider = _display displayCtrl IDC_SETDATE_SLIDER;
    private _ctrlHour   = _display displayCtrl IDC_SETDATE_HOUR;
    private _ctrlMinute = _display displayCtrl IDC_SETDATE_MINUTE;
    private _ctrlSecond = _display displayCtrl IDC_SETDATE_SECOND;

    private _value = round (parseNumber ctrlText _ctrlHour * 3600 + parseNumber ctrlText _ctrlMinute * 60 + parseNumber ctrlText _ctrlSecond);
    _ctrlSlider sliderSetPosition _value;
    _value = sliderPosition _ctrlSlider;

    UPDATE_EDIT_BOXES;
};

_ctrlHour   ctrlAddEventHandler ["KillFocus", _fnc_onKillFocus];
_ctrlMinute ctrlAddEventHandler ["KillFocus", _fnc_onKillFocus];
_ctrlSecond ctrlAddEventHandler ["KillFocus", _fnc_onKillFocus];

private _fnc_onUnload = {
    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    if (isNull _logic) exitWith {};

    deleteVehicle _logic;
};

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    if (isNull _display) exitWith {};

    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    if (isNull _logic) exitWith {};

    private _ctrlYear   = _display displayCtrl IDC_SETDATE_YEAR;
    private _ctrlMonth  = _display displayCtrl IDC_SETDATE_MONTH;
    private _ctrlDay    = _display displayCtrl IDC_SETDATE_DAY;
    private _ctrlSlider = _display displayCtrl IDC_SETDATE_SLIDER;

    private _sliderPos = sliderPosition _ctrlSlider;

    private _date = [
        _ctrlYear lbValue lbCurSel _ctrlYear,
        _ctrlMonth lbValue lbCurSel _ctrlMonth,
        _ctrlDay lbValue lbCurSel _ctrlDay,
        floor (_sliderPos / 3600),
        round (floor (_sliderPos / 60 % 60) + _sliderPos % 60 / 60)
    ];

    [QEGVAR(common,setDate), [_date]] call CBA_fnc_serverEvent;
};

_display displayAddEventHandler ["Unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
