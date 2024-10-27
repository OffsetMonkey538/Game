extends Node

@onready var buttons: Array[Node] = HudManager.LevelupHUD.find_child("Upgrades").find_children("Upgrade*Button");
@onready var button1: Button = buttons[0];
@onready var button2: Button = buttons[1];
@onready var button3: Button = buttons[2];
var levelups: int = 0;
var rng: RandomNumberGenerator = RandomNumberGenerator.new();

func _ready() -> void:
	LevelData.level_up.connect(func():
		LevelManager.current_scene.pause_game();

		levelups += 1;
		refresh_options();
		HudManager.display_levelup_hud();
	);
	
	for button in buttons:
		button.pressed.connect(func(): button_pressed());
	button1.pressed.connect(func ():
		LevelData.upgrades.add(button1.text);
	);
	button2.pressed.connect(func ():
		LevelData.upgrades.add(button2.text);
	);
	button3.pressed.connect(func ():
		LevelData.upgrades.add(button3.text);
	);

func button_pressed() -> void:
	levelups -= 1;
	if (levelups <= 0):
		HudManager.hide_levelup_hud();
		LevelManager.current_scene.unpause_game();
		return;
	refresh_options();

func refresh_options() -> void:
	var available = LevelData.upgrades.get_available_upgrades();

	button1.text = get_random(available);
	button2.text = get_random(available);
	button3.text = get_random(available);
	
func get_random(available) -> String:
	var keys = available.keys();
	
	if (keys.size() <= 0): return "health";
	
	var random: int = rng.randi_range(0, keys.size() - 1);
	var result = keys[random];
	
	# remove from available
	available[result] = available[result] - 1;
	if (available[result] <= 0): available.erase(result);
	
	return result;