class_name UpgradeManager extends Object

## String to UpgradeResource
var all_upgrades: Dictionary = {};

## String to int
var normal_upgrades: Dictionary = {};

## String of upgrade name
var super_upgrades: Array[String] = [];

## String to int
var current_upgrades: Dictionary = {};

var buttons: Array[Node] = HudManager.LevelupHUD.find_child("Upgrades").find_children("Upgrade*Button");
var button1: Button = buttons[0];
var button2: Button = buttons[1];
var button3: Button = buttons[2];
var levelups: int = 0;
var normal: bool = true;
var rng: RandomNumberGenerator = RandomNumberGenerator.new();

func _init() -> void:
	# Get the upgrades
	var upgrades: Array[UpgradeResource] = load("res://Resources/upgrade/normal/upgrades.tres").value;
	for upgrade in upgrades:
		normal_upgrades[upgrade.name] = upgrade.max_level;
		all_upgrades[upgrade.name] = upgrade;
	
	upgrades = load("res://Resources/upgrade/super/upgrades.tres").value;
	for upgrade in upgrades:
		super_upgrades.append(upgrade.name);
		all_upgrades[upgrade.name] = upgrade;
	super_upgrades.make_read_only();
	
	
	# Normal upgrades
	LevelData.level_up.connect(func():
		normal = true;
		LevelManager.current_scene.pause_game();

		levelups += 1;
		refresh_options();
		HudManager.display_levelup_hud();
	);
	
	
	# General
	for button in buttons:
		button.pressed.connect(func(): button_pressed());
	button1.pressed.connect(func ():
		upgrade_upgrade(button1.text);
	);
	button2.pressed.connect(func ():
		upgrade_upgrade(button2.text);
	);
	button3.pressed.connect(func ():
		upgrade_upgrade(button3.text);
	);

# Called by BossEnemy on death
func show_super_upgrades() -> void:
	normal = false;
	LevelManager.current_scene.pause_game();
	refresh_options();
	HudManager.display_levelup_hud();

func button_pressed() -> void:
	if (normal): button_pressed_normal();
	else: button_pressed_super();

func button_pressed_normal() -> void:
	levelups -= 1;
	if (levelups <= 0):
		HudManager.hide_levelup_hud();
		LevelManager.current_scene.unpause_game();
		return;
	refresh_options();

func button_pressed_super() -> void:
	HudManager.hide_levelup_hud();
	LevelManager.current_scene.unpause_game();

func get_available_upgrades() -> Array[String]:
	return get_available_upgrades_normal() if normal else get_available_upgrades_super();
func get_available_upgrades_normal() -> Array[String]:
	var result: Array[String] = [];
	result.assign(normal_upgrades.keys().duplicate());
	for key in current_upgrades:
		var max_level = (normal_upgrades[key] if normal_upgrades.has(key) else 0);
		if (max_level == -1):
			continue;
		
		if ((max_level - current_upgrades.get(key, 0)) <= 0):
			result.erase(key);
	return result;
func get_available_upgrades_super() -> Array[String]: 
	var result: Array[String] = super_upgrades.duplicate();
	for key in current_upgrades:
		result.erase(key);
	return result;

func upgrade_upgrade(upgrade: String) -> void:
	if (normal): upgrade_upgrade_normal(upgrade);
	else: upgrade_upgrade_super(upgrade);
func upgrade_upgrade_normal(upgrade: String) -> void:
	if current_upgrades.has(upgrade):
		current_upgrades[upgrade] += 1;
	else:
		current_upgrades[upgrade] = 1;
	
	if !all_upgrades.has(upgrade):
		push_error("Upgrade '" + upgrade + "' doesn't exist!")
		return;
	for effect in all_upgrades[upgrade].effect:
		apply_effect(upgrade, effect);

func upgrade_upgrade_super(upgrade: String) -> void:
	current_upgrades[upgrade] = 1;
	
	if !all_upgrades.has(upgrade):
		push_error("Upgrade '" + upgrade + "' doesn't exist!")
		return;
	
	var upgrade_resource: SuperUpgradeResource = all_upgrades[upgrade];
	
	for effect in upgrade_resource.effect:
		apply_effect(upgrade, effect);
	
	all_upgrades.erase(upgrade);
	if (upgrade_resource.unlock == null): return;
	
	all_upgrades[upgrade_resource.unlock.name] = upgrade_resource.unlock;
	normal_upgrades[upgrade_resource.unlock.name] = upgrade_resource.unlock.max_level;
	print("Added upgrade '" + upgrade_resource.unlock.name + "' from upgrade '" + upgrade + "'!")

func apply_effect(upgrade_name: String, effect: UpgradeModifierResource) -> void:
	match effect.name:
		"health": LevelManager.player.health.heal(effect.value);
		"max_health": LevelManager.player.health.add_max_health(effect.value);
		"speed": LevelManager.player.velocity.max_speed += effect.value;
		"damage": LevelManager.player.shooter.damage += effect.value;
		"shoot_speed": LevelManager.player.shooter.set_shoot_speed(LevelManager.player.shooter.shootSpeedSeconds + effect.value);
		"piercing": LevelManager.player.shooter.piercing += effect.value;
		"bullet_count": LevelManager.player.shooter.projectileBaseCount += effect.value;
		"bullet_spread": LevelManager.player.shooter.set_spread(LevelManager.player.shooter.projectileMultishotRangeDegrees + effect.value);
		var name: push_error("Upgrade '" + upgrade_name + "' has unknown effect '"+ name + "'!");

func refresh_options() -> void:
	var available: Array[String] = get_available_upgrades();

	button1.text = get_random(available);
	button2.text = get_random(available);
	button3.text = get_random(available);

func get_random(available: Array[String]) -> String:
	if (available.size() <= 0): return "nothing";

	var random: int = rng.randi_range(0, available.size() - 1);
	var result = available[random];

	# remove from available
	available.erase(result);

	return result;

