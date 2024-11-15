class_name PathfindComponent extends Area2D

@export var velocity_component: VelocityComponent;
@export var self_area: Area2D;
@export var separation_distance: float = 40;
@export var separation_weight: float = 0.6;
@export var target_weight: float = 0.5;

var target: Node2D;


func _process(_delta):
	velocity_component.set_target(_calculateFlockDirection());

func _calculateFlockDirection():
	var thisGlobalPosition = get_global_position();
		
	var separation = Vector2.ZERO;
	var targetVec = Vector2.ZERO;
	
	var flockmates: Array = get_overlapping_areas();
	for flockmate: Area2D in flockmates:
		if (flockmate == self_area || flockmate == null || flockmate.is_queued_for_deletion()): continue;
		
		var flockmateGlobalPosition: Vector2 = flockmate.get_global_position();
		
		var distanceToFlockmate: float = thisGlobalPosition.distance_to(flockmateGlobalPosition);
		
		#separation += (thisGlobalPosition - flockmateGlobalPosition).normalized() * velocity_component.max_speed;
		#separation += (thisGlobalPosition - flockmateGlobalPosition).normalized() * velocity_component.max_speed * (distanceToFlockmate / separation_distance);
		separation -= (flockmateGlobalPosition - thisGlobalPosition).normalized() * (velocity_component.max_speed * (separation_distance / distanceToFlockmate))
		#separation -= (thisGlobalPosition - flockmateGlobalPosition).normalized() * velocity_component.max_speed * (separation_distance / distanceToFlockmate);
		#separation -= (flockmateGlobalPosition - thisGlobalPosition).normalized() * velocity_component.max_speed * (distanceToFlockmate / separation_distance);
		#separation -= (flockmateGlobalPosition - thisGlobalPosition).normalized() * velocity_component.max_speed * (separation_distance / distanceToFlockmate);
		#separation -= (flockmateGlobalPosition - thisGlobalPosition).normalized() * lerpf(0, velocity_component.max_speed, (separation_distance / distanceToFlockmate));
	
	targetVec = _get_target_velocity();
	var desiredDirection = (
		separation * separation_weight +
		targetVec * target_weight
	);
	
	return desiredDirection.normalized() * velocity_component.max_speed;
	
func _get_target_velocity() -> Vector2:
	if (!target):
		push_error("No target!");
		return Vector2.ZERO;
	var desiredDirection: Vector2 = (target.global_position - global_position).normalized();
		
	return desiredDirection * velocity_component.max_speed;
