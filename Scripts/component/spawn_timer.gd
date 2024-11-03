class_name SpawnTimer extends Timer

@export var scene: PackedScene;
@export var offsetMonkey: Vector2;
@export var target: Node2D;

signal before_spawn;

func _ready() -> void:
	autostart = true;
	timeout.connect(func():
		before_spawn.emit();
		
		var enemy = scene.instantiate();
		enemy.position = get_parent().global_position + offsetMonkey;
		enemy.find_children("PathfindComponent").any(func(pathfind): pathfind.target = target);
		LevelManager.current_scene.add_child(enemy);
	);
