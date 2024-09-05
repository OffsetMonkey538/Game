extends Node

var xp: int = 0;
var xp_level: int = 0;

signal xp_changed(old_value: float, new_value: float);
signal xp_level_changed(old_value: float, new_value: float);
signal level_up();

func add_xp(amount: int):
	var old_xp: int = xp;
	var old_xp_level: int = xp_level;
	
	var xp_until_next_level: int = get_xp_until_next_level();
	while (amount >= xp_until_next_level):
		xp_level += 1;
		amount -= xp_until_next_level
		xp = amount;
		
		level_up.emit();
		xp_until_next_level = get_xp_until_next_level();
	
	xp += amount;
	if old_xp != xp: xp_changed.emit(old_xp, xp);
	if old_xp_level != xp_level: xp_level_changed.emit(old_xp_level, xp_level);

func get_xp_until_next_level() -> int:
	return get_xp_for_next_level() - xp;

func get_xp_for_next_level() -> int:
	return 10*xp_level + 10;
