class_name ConstantMovementComponent extends Node

@export var speed: Vector2 = Vector2.ZERO;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_parent().position += speed * delta;
