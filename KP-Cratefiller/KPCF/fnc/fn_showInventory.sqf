/*
    Killah Potatoes Cratefiller

    Author: Dubjunk - https://github.com/KillahPotatoes
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
    Displays the items of the active crate.

    Parameter(s):
    NONE

    Returns:
    NONE
*/

// Dialog controls
private _dialog = findDisplay 758067;
private _ctrlInventory = _dialog displayCtrl 75822;
private _ctlrProgress = _dialog displayCtrl 75823;

// Reset variables
lbClear _ctrlInventory;

// Fill the controls
{
    private _config = [_x select 0] call KPCF_fnc_getConfigPath;
    _ctrlInventory lbAdd (format ["%1x %2", str (_x select 1), (getText (configFile >> _config >> _x select 0 >> "displayName"))]);
} forEach KPCF_inventory;

// Maths for the progress bar
private _load = 0;
private _type = "";
private _config = "";
private _itemMass = 0;

// Get the mass of each item
{
    _type = (_x select 0);
    _config = [_type] call KPCF_fnc_getConfigPath;
    if (_config == "CfgWeapons") then {
        _itemMass = getNumber (configfile >> _config >> _type >> "WeaponSlotsInfo" >> "mass");
        if (_itemMass == 0) then {
            _itemMass = getNumber (configfile >> _config >> _type >> "ItemInfo" >> "mass");
        };
    } else {
        _itemMass = getNumber (configFile >> _config >> _type >> "mass");
    };
    _load = _load + (_itemMass * (_x select 1));
} forEach KPCF_inventory;

private _type = typeOf KPCF_activeStorage;
private _config = [_type] call KPCF_fnc_getConfigPath;
private _maxLoad = getNumber (configFile >> _config >> _type >> "maximumLoad");
private _loadFactor = _load / _maxLoad;

_ctlrProgress progressSetPosition _loadFactor;

