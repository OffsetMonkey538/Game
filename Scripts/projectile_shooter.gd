extends Node2D

@export var projectile: PackedScene;
@export var level: Node;
@export var shooter: Node2D;

func _update():
	pass;

func getProjectileAmount() -> int:
	return 30;
	pass;

func shootAllProjectiles():
	var numProjectiles = getProjectileAmount();
	
	for currentProjectile in range(0, numProjectiles):
		var projectileRotation: float = -0.345 + currentProjectile * 0.69 / numProjectiles;
		shoot(projectileRotation);
	
func shoot(rotationOffsetRadians: float):
	var newProjectile = projectile.instantiate();
	newProjectile.position = shooter.global_position;
	newProjectile.rotation = shooter.rotation + rotationOffsetRadians;
	newProjectile.direction = Vector2.RIGHT.rotated(newProjectile.rotation).normalized();
	
	level.add_child(newProjectile);
