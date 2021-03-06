/*
    Killah Potatoes Cratefiller

    Author: Dubjunk - https://github.com/KillahPotatoes
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
    Scans the spawn area for possible storages.

    Parameter(s):
    NONE

    Returns:
    NONE
*/

// Dialog controls
private _dialog = findDisplay 758067;
private _ctrlStorage = _dialog displayCtrl 75802;

// Clear the lists
lbClear _ctrlStorage;

// Reset variables
KPCF_nearStorage = [];

// Get near objects and check for storage capacity
{
    private _type = typeOf _x;
    if (_type == "GroundWeaponHolder") exitWith {};
    private _config = [_type] call KPCF_fnc_getConfigPath;
    private _number = getNumber (configfile >> _config >> _type >> "maximumLoad");
    if (_number > 0) then {
        KPCF_nearStorage pushBack _x;
    };
} forEach ((KPCF_activeSpawn nearObjects KPCF_spawnRadius) select {!(typeOf _x in KPCF_cratefillerBase)});

// Fill the list
{
    private _type = typeOf _x;
    private _config = [_type] call KPCF_fnc_getConfigPath;
    _ctrlStorage lbAdd format ["%1m - %2", round (KPCF_activeSpawn distance2D _x), getText (configFile >> _config >> _type >> "displayName")];
} forEach KPCF_nearStorage;

// Check if dialog is closed
if (isNull _dialog) exitWith {};

[{call KPCF_fnc_getNearStorages;}, [], 5] call CBA_fnc_waitAndExecute;
