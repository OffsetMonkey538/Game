class_name MyProgressBar extends TextureProgressBar

@export var health_component: HealthComponent;
var label: Label;

func _ready():
	# Set up progress bar
	nine_patch_stretch = true;
	stretch_margin_left = 3;
	stretch_margin_top = 3;
	stretch_margin_right = 3;
	stretch_margin_bottom = 3;
	texture_under = preload("res://Assets/Textures/GUI/ProgressBar/under.png");
	texture_over = preload("res://Assets/Textures/GUI/ProgressBar/border.png");
	step = 0;
	z_index = 1;
	if (texture_progress == null): texture_progress = preload("res://Assets/Textures/missing.png")
	
	# Create label
	label = Label.new();
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER;
	label.autowrap_mode = TextServer.AUTOWRAP_ARBITRARY;
	label.scale = Vector2(0.3, 0.3);
	label.size = size / label.scale;
	add_child(label);
	
	# Set up signals
	if (health_component): health_component.health_changed.connect(_on_health_changed);
	if (health_component): health_component.max_health_changed.connect(_on_max_health_changed);
	
	if (health_component): health_component.ready.connect(func():
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
