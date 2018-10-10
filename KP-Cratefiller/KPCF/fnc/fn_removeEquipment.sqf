/*
    Killah Potatoes Cratefiller

    Author: Dubjunk - https://github.com/KillahPotatoes
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
    Removes the given amount of the selected item in the crate.

    Parameter(s):
    0 : SCALAR - Amount of the removed item.

    Returns:
    NONE
*/

params [
    "_amount"
];

// Dialog controls
private _dialog = findDisplay 758067;
private _ctrlCrate = _dialog displayCtrl 75801;
private _ctrlStorage = _dialog displayCtrl 75802;
private _ctrlCat = _dialog displayCtrl 75810;
private _ctrlWeapon = _dialog displayCtrl 75811;
private _ctrlEquipment = _dialog displayCtrl 75812;
private _ctrlInventory = _dialog displayCtrl 75820;
private _ctrlInventoryAmount = _dialog displayCtrl 75821;

// Check for inventory clear
if (_amount == 0) exitWith {
    KPCF_inventory = [];
    call KPCF_fnc_setInventory;
};

private _index = lbCurSel _ctrlInventory;

// Check for empty selection
if (_index == -1) exitWith {};

// Item selection
private _item = ((KPCF_inventory select _index) select 0);

private _modify = (((KPCF_inventory select _index) select 1) - _amount);

if (_modify < 0) then {
    _modify = 0;
};

(KPCF_inventory select _index) set [1, _modify];

call KPCF_fnc_setInventory;
