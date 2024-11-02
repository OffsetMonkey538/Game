class_name PlayerHealthComponent extends HealthComponent


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready();
	HudManager.InGameHUD.find_child("HealthBar").set_health_component(self);
	
	death.connect(func():
		LevelManager.unload_scene();
		HudManager.RestartButton.show();
		HudManager.hide_joysticks();
	);
	
