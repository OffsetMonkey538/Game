extends Node2D

@onready var velocity: VelocityComponent = $VelocityComponent;
@onready var health: PlayerHealthComponent = $PlayerHealthComponent;
@onready var shooter: ProjectileShooter = $ProjectileManager/SimpleProjectileShooter;
@onready var enemy_spawner: EnemySpawner = $EnemySpawner; 
var my_rotation: float = 0;

func _ready() -> void:
	velocity.process_mode = PROCESS_MODE_DISABLED;

func _process(_delta) -> void:
	velocity.target_velocity = Vector2.ZERO;
	
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down");
	
	if direction != Vector2.ZERO:
		velocity.target_velocity += direction;
	
	if velocity.target_velocity.length() > 0:
		velocity.target_velocity = velocity.target_velocity.normalized() * velocity.max_speed;
	
	# Tell velocity component to do movement
	velocity._process(_delta);
	
	# Override its rotation after that
	#rotation = my_rotation;
	
	# Controller and on screen joysticks
	var look_input_direction = Input.get_vector("look_left", "look_right", "look_up", "look_down");
	if look_input_direction != Vector2.ZERO:
		my_rotation = look_input_direction.angle();
	
	if (OS.has_feature("pc")):
		# Follow mouse
		if (Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
			my_rotation = global_position.angle_to_point(get_global_mouse_position())
	
	rotation = my_rotation;