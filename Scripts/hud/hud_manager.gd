extends Node

@onready var HUD: CanvasLayer = $/root/Main/HUD;
@onready var InGameHUD: CanvasLayer = $/root/Main/HUD/InGameHUD;
@onready var JoySticks: CanvasLayer = $/root/Main/HUD/InGameHUD/JoySticks;
@onready var XpBar: XpBar = $/root/Main/HUD/InGameHUD/XpBar;
@onready var CoinsDisplay: HBoxContainer = $/root/Main/HUD/InGameHUD/CoinsDisplay;
@onready var LevelupHUD: CanvasLayer = $/root/Main/HUD/LevelupHUD;
@onready var RestartButton: Button = $/root/Main/HUD/RestartButton

func _ready() -> void:
	RestartButton.pressed.connect(func(): on_restart());

func hide_joysticks():
	for joystick: VirtualJoystick in JoySticks.find_children("*Joystick", "VirtualJoystick", false):
		joystick._reset();
		joystick.hide()
	JoySticks.process_mode = PROCESS_MODE_DISABLED;

func show_joysticks():
	JoySticks.process_mode = PROCESS_MODE_INHERIT;
	
func display_levelup_hud():
	LevelupHUD.show();
	hide_joysticks()
	
func hide_levelup_hud():
	LevelupHUD.hide();
	show_joysticks()

func on_restart():
	get_node("/root/Main").print_tree_pretty()
	LevelData.reset();
	LevelManager._deferred_goto_scene("res://Scenes/level.tscn");
	RestartButton.hide();
	CoinsDisplay.reset();
	XpBar.reset();
	show_joysticks();
	get_node("/root/Main").print_tree_pretty()
