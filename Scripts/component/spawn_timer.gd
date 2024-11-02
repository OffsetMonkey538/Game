class_name SpawnTimer extends Timer

@export var scene: PackedScene;
@export var offsetMonkey: Vector2;
@export var target: Node2D;

func _ready() -> void:
	autostart = true;
	timeout.connect(func():
		var enemy = scene.instantiate();
		enemy.position = get_parent().global_position + offsetMonkey;
		enemy.find_children("PathfindComponent").all(func(pathfind): pathfind.target = target);
		LevelManager.current_scene.add_child(enemy);
	);
