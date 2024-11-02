class_name VelocityComponent extends Node

@export var max_speed: float = 200;
@export var acceleration: float = 1;
@export var instant: bool = false;

var velocity: Vector2 = Vector2.ZERO;
var target_velocity: Vector2 = Vector2.ZERO;

signal position_changed(rotation: float, position: Vector2);

func _process(delta):
	if (instant): velocity = target_velocity;
	else: velocity = lerp(velocity, target_velocity, delta);
	
	velocity = velocity.limit_length(max_speed);
	
	var parent = get_parent();
	
	parent.rotation = velocity.angle();
	parent.position += velocity * delta;
	
	position_changed.emit(parent.rotation, parent.position);

func set_target(new_target: Vector2):
	target_velocity = new_target;
