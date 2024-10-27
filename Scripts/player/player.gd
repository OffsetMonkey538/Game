extends Node2D

var speed: float = 200;
var velocity: Vector2;

func _ready() -> void:
	LevelData.upgrades.upgrade_applied.connect(func(upgrade, _level):
		if (not upgrade == "speed"): return;
		speed += 100;
	);

func _process(delta):
	velocity = Vector2.ZERO;
	
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down");
	
	if direction != Vector2.ZERO:
		velocity += direction;
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed;
	
	position += velocity * delta;
	
	
	
	## TODO: this should be configurable tghrough a settings thing once that exists
	
	# Controller and on screen joysticks
	var look_input_direction = Input.get_vector("look_left", "look_right", "look_up", "look_down");
	if look_input_direction != Vector2.ZERO:
		rotation = look_input_direction.angle();
	
	## Follow mouse
	#if (Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
	#	look_at(get_global_mouse_position());
