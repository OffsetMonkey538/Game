extends Node2D

@export var enemy: PackedScene;
@export var target: Node2D;
@export var level: Node;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawnEnemies(amount: int, radius: float):
	var radians_per_enemy: float = TAU / amount;
	
	for i in range(0, amount):
		var new_enemy: Enemy = enemy.instantiate();
		
		new_enemy.position = global_position + Vector2.UP.rotated(i * radians_per_enemy) * radius;
		new_enemy.Target = target;
		
		level.add_child(new_enemy);
