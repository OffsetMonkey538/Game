class_name PlayerHealthBar extends MyProgressBar

var health_component: PlayerHealthComponent;

func _ready():
	super._ready();

	texture_progress = preload("res://Assets/Textures/GUI/ProgressBar/health.png")

func set_health_component(new_health_component: PlayerHealthComponent):
	health_component = new_health_component;
	call_deferred("_internal_update_health_component")

func _internal_update_health_component():
	health_component.health_changed.connect(func(_old_value, new_value): _on_value_changed(new_value));
	health_component.max_health_changed.connect(func(_old_value, new_value): _on_max_value_changed(new_value));

	value = health_component.get_health();
	max_value = health_component.get_max_health();
	label.text = str(value);