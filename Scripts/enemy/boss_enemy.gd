extends Node2D

@onready var sprite: Sprite2D = $Sprite2D;
@onready var health: HealthComponent = $HealthComponent;
@onready var shooter: ProjectileShooter = $ProjectileManager/SimpleProjectileShooter;

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.material.set_shader_parameter("hue_shift", randf_range(0, 1));
	health.set_both(health.max_health * LevelData.difficulty_multiplier);
	shooter.damage = shooter.damage * LevelData.difficulty_multiplier;
	shooter.projectileBaseCount = floori(LevelData.difficulty_multiplier) * 2 - 1
	shooter.set_spread(min(70, round(shooter.projectileBaseCount * 5)))
	
	health.death.connect(func():
		LevelData.upgrades.show_super_upgrades();
	);
