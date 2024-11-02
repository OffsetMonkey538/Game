class_name ProjectileShooter extends Node2D

@export var shootSpeedSeconds: float = 1;
@export var projectileBaseCount: int = 1;
@export var projectileMultishotRangeDegrees: float = 20;
@export var damage: float = 10;
@export var piercing: int = 1;
@export var projectileScene: PackedScene;

@onready var _projectileMultishotRangeRadians: float = deg_to_rad(projectileMultishotRangeDegrees);

signal shoot_speed_changed(old_speed: float);

func shootProjectiles():
	var projectile_count: int = projectileBaseCount;
	
	for current_projectile in range(0, projectile_count):
		var projectile_rotation: float = (current_projectile - (projectile_count - 1) / 2) * _projectileMultishotRangeRadians / projectile_count;
		shoot(projectile_rotation);

func shoot(rotation_offset: float):
	var new_projectile = projectileScene.instantiate();
	
	new_projectile.position = global_position;
	new_projectile.rotation = global_rotation + rotation_offset;
	new_projectile.find_child("PiercingComponent").piercing = piercing;
	new_projectile.find_child("HurtboxComponent").damage = damage;
	
	LevelManager.current_scene.add_child(new_projectile);

func set_shoot_speed(new_shoot_speed: float):
	var old_speed: float = shootSpeedSeconds;
	shootSpeedSeconds = new_shoot_speed;
	shoot_speed_changed.emit(old_speed);

func set_spread(new_spread_degrees: float):
	projectileMultishotRangeDegrees = new_spread_degrees;
	_projectileMultishotRangeRadians = deg_to_rad(projectileMultishotRangeDegrees);