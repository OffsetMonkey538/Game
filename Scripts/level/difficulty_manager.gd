extends Node

const step: float = 0.5;
const enemy_material: ShaderMaterial = preload("res://Assets/Materials/basic_enemy.tres");

@export var boss_spawner: SpawnTimer;

var timeth: int = 0;

func _ready() -> void:
	enemy_material.set_shader_parameter("hue_shift", 0.0);
	boss_spawner.timeout.connect(func(): _try_increment())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _try_increment() -> void:
	timeth += 1;
	
	var new_multiplier: float = snappedf(timeth**2 * 0.1 + 1, step)
	
	if (new_multiplier <= LevelData.difficulty_multiplier): return;
	
	LevelData.difficulty_multiplier = new_multiplier;
	on_increment();

func on_increment() -> void:
	enemy_material.set_shader_parameter("hue_shift", fmod(timeth * 0.05, 1));

