class_name ConstantMovementComponent extends Node

@export var speed: float = 0;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var parent = get_parent();
	
	parent.position += Vector2.RIGHT.rotated(parent.rotation) * speed * delta;
