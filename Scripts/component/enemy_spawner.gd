class_name EnemySpawner extends Node2D

@export var enemy: PackedScene;
@export var target: Node2D;
@export var initial_spawn_frequency_seconds: float = 1.5;

## Int radius to Int amount
@export var tiers: Dictionary = {};

@onready var spawn_frequency_seconds: float = initial_spawn_frequency_seconds;
var _time: float = 0;

func _ready() -> void:
	spawnRings();
	_time = spawn_frequency_seconds;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	if (_time <= 0):
		spawnRings();
		_time = spawn_frequency_seconds;
		return;
	_time -= _delta;
	
	# TODO: DEBUG thing just to spawn enemies at will
	if Input.is_action_just_pressed("ui_select"):
		spawnEnemies(18, 250);

func spawnRings():
	for key in tiers:
		spawnEnemies(tiers[key], key);
	
func spawnEnemies(amount: int, radius: float):
	var radians_per_enemy: float = TAU / amount;
	
	for i in range(0, amount):
		var new_enemy: Node2D = enemy.instantiate();
		
		new_enemy.position = global_position + Vector2.UP.rotated(i * radians_per_enemy) * radius;
		new_enemy.find_children("PathfindComponent").all(func(pathfind): pathfind.target = target);
		
		LevelManager.current_scene.add_child.call_deferred(new_enemy);
