extends Entity

var Target : Node2D;
var direction : Vector2 = Vector2.RIGHT;

const MaxSpeed : float = 200;
const MinSpeed : float = 190;

var thingy = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	rotation = direction.angle();

	thingy += delta * 5;

	direction = _calculateFlockDirection(thingy);
	
	#direction = _get_target_velocity();
	
	#var currentSpeed = direction.length_squared();
	#
	#if currentSpeed > MaxSpeed:
	#	direction = direction.normalized() * MaxSpeed;
	#elif currentSpeed < MinSpeed:
	#	direction = direction.normalized() * MinSpeed;
	
	position += direction * delta;
	
	super._physics_process(delta);

func _calculateFlockDirection(thingy: float) -> Vector2:
	var thisGlobalPosition = global_position;
	return Vector2(sin(thingy), cos(thingy)) * 200;
