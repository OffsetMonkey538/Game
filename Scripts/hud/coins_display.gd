extends HBoxContainer

@onready var label: Label = $Label;

# Called when the node enters the scene tree for the first time.
func _ready():
	LevelData.coins_changed.connect(func(_old_value: int, new_value: int):
		label.text = str(new_value);
	);
