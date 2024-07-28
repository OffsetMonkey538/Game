extends Node2D

const speed: float = 200;

func _physics_process(delta):
	var velocity: Vector2 = Vector2.ZERO;
	
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
	#look_at(get_global_mouse_position());
	#rotation_degrees += 90;
