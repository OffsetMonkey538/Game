class_name PlayerHealthComponent extends HealthComponent


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready();
	HudManager.InGameHUD.find_child("HealthBar").set_health_component(self);
	
	# Upgrades
	LevelData.upgrades.upgrade_applied.connect(func(upgrade_name, _level):
		if (upgrade_name == "health"):
			heal(20);
			return;
		if (upgrade_name == "max_health"):
			add_max_health(20);
			return;
	);
	
	death.connect(func():
		LevelManager.unload_scene();
		HudManager.RestartButton.show();
	);
	
