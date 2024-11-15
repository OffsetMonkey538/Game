class_name RangedPathfindComponent extends Node2D

@export var velocity_component: VelocityComponent;
@export var detection_distance: float = 60;
@export var separation_distance: float = 40;
@export var separation_weight: float = 0.6;
@export var target_weight: float = 0.5;
@export var target_separation_distance: float = 150;

var target: Node2D;


func _process(_delta):
	velocity_component.set_target(_get_target_velocity());
	if (target): rotation = (target.global_position - global_position).normalized().angle();

func _calculateFlockDirection():
	var separation = Vector2.ZERO;
	var targetVec = Vector2.ZERO;
	
	targetVec = _get_target_velocity();
		
	var desiredDirection = (
		separation * separation_weight +
		targetVec * target_weight
	);
	
	return desiredDirection;
	
func _get_target_velocity() -> Vector2:
	if (!target):
		push_error("No target!");
		return Vector2.ZERO;
	var desiredDirection: Vector2 = (target.global_position - global_position);
	var distance_to_target: float = desiredDirection.length();
	
	var speed_factor: float = 0;
	if distance_to_target < target_separation_distance: speed_factor = 0.01;
	else: speed_factor = clamp((distance_to_target - separation_distance) / (detection_distance - separation_distance), 0, 1);
	
	return desiredDirection.normalized() * velocity_component.max_speed * speed_factor;
