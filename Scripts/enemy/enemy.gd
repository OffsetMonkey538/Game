extends Node2D

@onready var health: HealthComponent = $HealthComponent;
@onready var hurtbox: HurtboxComponent = $HurtboxComponent;

func _ready():
	health.set_both(health.max_health * LevelData.difficulty_multiplier);
	hurtbox.damage = hurtbox.damage * LevelData.difficulty_multiplier;
