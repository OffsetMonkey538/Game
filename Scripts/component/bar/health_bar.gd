class_name HealthBar extends MyProgressBar

@export var health_component: HealthComponent;

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready();
	
	# Signals
	if (health_component): health_component.health_changed.connect(func(_old_value, new_value): _on_value_changed(new_value));
	if (health_component): health_component.max_health_changed.connect(func(_old_value, new_value): _on_max_value_changed(new_value));
	
	if (health_component): health_component.ready.connect(func():
		max_value = health_component.max_health;
		value = max_value;
		label.text = str(max_value);
	);
	
	texture_progress = preload("res://Assets/Textures/GUI/ProgressBar/health.png")
