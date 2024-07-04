extends TextureProgressBar

@export var target: Entity;
@onready var label: Label = $Label;

# Called when the node enters the scene tree for the first time.
func _ready():
	label.size = size / label.scale;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation = -target.rotation;
	value = target.health / target.getMaxHealth();
	label.text = str(target.health);
