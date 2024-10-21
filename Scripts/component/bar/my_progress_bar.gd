class_name MyProgressBar extends TextureProgressBar

@export var velocity_component: VelocityComponent;
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
	label.label_settings = LabelSettings.new();
	label.label_settings.font_size = 64;
	#label.scale = Vector2(0.15, 0.15)
	label.scale = Vector2(0.00125, 0.00125) * max(size.x, size.y);
	#label.scale = Vector2(0.01, 0.01) * max(size.x, size.y);
	#label.scale = Vector2(0.00625, 0.04375) * size;
	#label.size = size / label.scale;
	label.size = size / label.scale;
	add_child(label);
	
	# Set up signals
	if (velocity_component): velocity_component.position_changed.connect(_on_parent_pos_changed);
	
	process_mode = Node.PROCESS_MODE_DISABLED

func _on_parent_pos_changed(new_rotation: float, _position: Vector2):
	self.rotation = -new_rotation;

func _on_value_changed(new_value: float):
	value = new_value;
	label.text = str(value);

func _on_max_value_changed(new_max_value: float):
	max_value = new_max_value;
