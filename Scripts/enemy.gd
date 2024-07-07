class_name Enemy
extends Entity

const SeparationDistance : float = 25;
const SeparationWeight : float = 0.6;
const TargetWeight : float = 0.5;

const MaxSpeed : float = 200;
const MinSpeed : float = 200;
	
var Target : Node2D;
var direction : Vector2 = Vector2.RIGHT;
	
	# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	rotation = direction.angle();

	direction = _calculateFlockDirection();
	
	#direction = _get_target_velocity();
	
	var currentSpeed = direction.length_squared();
	
	if currentSpeed > MaxSpeed:
		direction = direction.normalized() * MaxSpeed;
	elif currentSpeed < MinSpeed:
		direction = direction.normalized() * MinSpeed;
	
	position += direction * delta;
	
	super._physics_process(delta);
	
func _calculateFlockDirection():
	var thisGlobalPosition = global_position;
		
	var separation = Vector2.ZERO;
	var heading = direction;
	var cohesion = Vector2.ZERO;
	var target = Vector2.ZERO;
	
	var flockmates: Array = EntityManager.getEntitiesInRadius(self, SeparationDistance);
	
	for flockmate in flockmates:
		if (flockmate == self || flockmate == null || flockmate.is_queued_for_deletion()): continue;
		
		var flockmateGlobalPosition = flockmate.global_position;
		
		var distanceToFlockmate = thisGlobalPosition.distance_to(flockmateGlobalPosition);
		
		if distanceToFlockmate > SeparationDistance: continue;
		
		separation -= (flockmateGlobalPosition - thisGlobalPosition) * (SeparationDistance / distanceToFlockmate) * MaxSpeed;
		
	# Take average
	#if flockmates.size() > 0:
		#heading /= flockmates.size();
		#cohesion /= flockmates.size();
		
		#var flockCenterDirection = position.direction_to(cohesion);
		#var flockCenterSpeed = MaxSpeed * flockCenterDirection / $DetectionRange/CollisionShape2D.shape.radius;
		#cohesion = flockCenterDirection * flockCenterSpeed;
		
	target = _get_target_velocity();
		
	var desiredDirection = (
		direction +
		separation * SeparationWeight +
		target * TargetWeight
	);
	
	#return direction.lerp(desiredDirection, 0.35);
	return desiredDirection;
	
func _get_target_velocity():
	var desiredDirection = (Target.global_position - global_position).normalized() * MaxSpeed;
		
	return desiredDirection.normalized() * MaxSpeed;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func onPlayerHit(area):
	super.damage(163.2);

# Override
func getMaxHealth() -> float:
	return 1000;
