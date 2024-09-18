class_name PathfindComponent extends Node2D

@export var velocity_component: VelocityComponent;
@export var grid_object_component: GridObjectComponent;
@export var detection_distance: float = 35;
@export var separation_distance: float = 25;
@export var separation_weight: float = 0.6;
@export var target_weight: float = 0.5;

var target: Node2D;


func _process(_delta):
	velocity_component.add_velocity(_calculateFlockDirection());

func _calculateFlockDirection():
	var thisGlobalPosition = global_position;
		
	var separation = Vector2.ZERO;
	var targetVec = Vector2.ZERO;
	
	var flockmates: Array = GridManager.getObjectsInRadiusAroundObject(grid_object_component, detection_distance);
	
	for flockmate in flockmates:
		if (flockmate == grid_object_component || flockmate == null || flockmate.is_queued_for_deletion()): continue;
		
		var flockmateGlobalPosition = flockmate.global_position;
		
		var distanceToFlockmate = thisGlobalPosition.distance_to(flockmateGlobalPosition);
		
		if distanceToFlockmate > detection_distance: continue;
		
		separation -= (flockmateGlobalPosition - thisGlobalPosition) * (separation_distance / distanceToFlockmate) * velocity_component.max_speed;
	
	targetVec = _get_target_velocity();
		
	var desiredDirection = (
		separation * separation_weight +
		targetVec * target_weight
	);
	
	return desiredDirection;
	
func _get_target_velocity():
	var desiredDirection = (target.global_position - global_position);
		
	return desiredDirection.normalized() * velocity_component.max_speed;
