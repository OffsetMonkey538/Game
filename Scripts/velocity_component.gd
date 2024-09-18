class_name VelocityComponent extends Node

@export var max_speed: float = 200;
@export var acceleration: float = 1;

var velocity: Vector2 = Vector2.ZERO;

signal position_changed(rotation: float, position: Vector2);

func _process(delta):
	velocity = velocity.limit_length(max_speed);
	
	var parent = get_parent();
	
	parent.rotation = velocity.angle();
	parent.position += velocity * delta;
	
	position_changed.emit(parent.rotation, parent.position);

func add_velocity(added_velocity: Vector2):
	velocity = lerp(velocity, added_velocity * max_speed, 0.35);
