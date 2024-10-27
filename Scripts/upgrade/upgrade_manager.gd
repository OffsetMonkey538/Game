class_name UpgradeManager extends RefCounted

signal upgrade_applied(upgrade: String, count: int);

## String to int
const all_upgrades: Dictionary = {
	"max_health": 3,
	"speed": 3
};

## String to int
var current_upgrades: Dictionary = {};

func get_available_upgrades() -> Dictionary:
	var result: Dictionary = all_upgrades.duplicate();
	for key in current_upgrades:
		result[key] = (all_upgrades[key] if all_upgrades.has(key) else 0) - current_upgrades.get(key, 0);
		if (result[key] <= 0):
			result.erase(key);
	print(result)
	return result;

func add(upgrade: String) -> void:
	if current_upgrades.has(upgrade):
		current_upgrades[upgrade] += 1;
	else:
		current_upgrades[upgrade] = 1;
	upgrade_applied.emit(upgrade, current_upgrades[upgrade])