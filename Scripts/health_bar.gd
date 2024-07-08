extends TextureProgressBar

@export var health_component: HealthComponent;
@onready var label: Label = $Label;

func _ready():
	label.size = size / label.scale;
	
	# Set up signals
	health_component.health_changed.connect(_on_health_changed);
	health_component.max_health_changed.connect(_on_max_health_changed);
	
	health_component.ready.connect(func():
		value = health_component.health;
		label.text = str(value);
	);

func _on_health_changed(_old_health: float, health: float):
	value = health;
	label.text = str(value);

func _on_max_health_changed(_old_max_health: float, max_health: float):
	max_value = max_health;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	rotation = -get_parent().rotation;
	
	#value = health_component.health / health_component.getMaxHealth();
	#label.text = str(target.health);
