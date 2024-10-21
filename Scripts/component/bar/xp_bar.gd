class_name XpBar extends MyProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready();
	
	
	LevelData.xp_changed.connect(func(_old_xp, new_xp):
		value = new_xp;
	);
	
	LevelData.xp_level_changed.connect(func(_old_level, new_level):
		value = LevelData.xp;
		label.text = str(new_level);
		max_value = LevelData.get_xp_for_next_level();
	);
	
	value = 0;
	label.text = "0";
	
	texture_progress = preload("res://Assets/Textures/GUI/ProgressBar/xp.png")
