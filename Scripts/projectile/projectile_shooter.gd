class_name ProjectileShooter extends Node2D

@export var shootSpeed: float = 1;
@export var projectileBaseCount: int = 1;
@export var projectileMultishotRangeDegrees: float = 0;
@export var damage: float = 1;
@export var piercing: int = 1;
@export var projectileScene: PackedScene;

@onready var _projectileMultishotRangeRadians: float = deg_to_rad(projectileMultishotRangeDegrees);

var shoot_timer: Timer;

func _ready() -> void:
	shoot_timer = Timer.new();
	shoot_timer.timeout.connect(func(): shootProjectiles());
	shoot_timer.wait_time = shootSpeed;
	shoot_timer.autostart = true;
	shoot_timer.one_shot = false;
	self.add_child(shoot_timer);

func shootProjectiles():
	var projectile_count: int = projectileBaseCount;
	
	for current_projectile in range(0, projectile_count):
		var projectile_rotation: float = (current_projectile - (projectile_count - 1.0) / 2.0) * _projectileMultishotRangeRadians / projectile_count;
		shoot(projectile_rotation);

func shoot(rotation_offset: float):
	var new_projectile: Node = projectileScene.instantiate();
	
	new_projectile.position = global_position;
	new_projectile.rotation = global_rotation + rotation_offset;
	new_projectile.find_child("PiercingComponent").piercing = piercing;
	new_projectile.find_child("HurtboxComponent").damage = damage;
	new_projectile.find_child("ConstantMovementComponent").speed = new_projectile.find_child("ConstantMovementComponent").speed.rotated(new_projectile.rotation);
	new_projectile.find_child("ConstantMovementComponent").speed += get_parent().find_child("VelocityComponent").velocity;
	
	LevelManager.current_scene.add_child(new_projectile);

func set_spread(new_spread_degrees: float):
	projectileMultishotRangeDegrees = new_spread_degrees;
	_projectileMultishotRangeRadians = deg_to_rad(projectileMultishotRangeDegrees);
