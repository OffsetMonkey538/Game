extends Node2D

@export var enemy: PackedScene;
@export var target: Node2D;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# TODO: DEBUG thing just to spawn enemies at will
	if Input.is_action_just_pressed("ui_select"):
		spawnEnemies(18, 250);
	if Input.is_action_just_pressed("ui_right"):
		spawnEnemies(1, 250);
	pass

func spawnEnemies(amount: int, radius: float):
	var radians_per_enemy: float = TAU / amount;
	
	for i in range(0, amount):
		var new_enemy: Node2D = enemy.instantiate();
		
		new_enemy.position = global_position + Vector2.UP.rotated(i * radians_per_enemy) * radius;
		new_enemy.find_children("PathfindComponent").all(func(pathfind): pathfind.target = target);
		
		SceneManager.current_scene.add_child(new_enemy);
