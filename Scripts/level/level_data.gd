extends Node

var xp: float = 0;
var xp_level: int = 0;

var coins: int = 0;

var upgrades: UpgradeManager = UpgradeManager.new();

signal xp_changed(old_value: float, new_value: float);
signal xp_level_changed(old_value: float, new_value: float);
signal level_up();

signal coins_changed(old_value: int, new_value: int);

func add_coins(amount: int):
	var old_value: int = coins;
	coins += amount;
	coins_changed.emit(old_value, coins);

func add_xp(amount: float):
	var old_xp: float = xp;
	var old_xp_level: int = xp_level;
	
	var xp_until_next_level: float = get_xp_until_next_level();
	while (amount >= xp_until_next_level):
		xp_level += 1;
		amount -= xp_until_next_level
		xp = amount;
		
		level_up.emit();
		xp_until_next_level = get_xp_until_next_level();
	
	xp += amount;
	if old_xp != xp: xp_changed.emit(old_xp, xp);
	if old_xp_level != xp_level: xp_level_changed.emit(old_xp_level, xp_level);

func get_xp_until_next_level() -> float:
	return get_xp_for_next_level() - xp;

func get_xp_for_next_level() -> int:
	return 10*xp_level + 10;

func reset():
	xp = 0;
	xp_level = 0;
	coins = 0;
	upgrades = UpgradeManager.new();
