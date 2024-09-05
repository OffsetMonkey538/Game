extends MyProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready();
	LevelData.xp_changed.connect(_xp_changed);
	LevelData.xp_level_changed.connect(_level_changed);
	
	value = 0;
	label.text = "0";
	
	process_mode = Node.PROCESS_MODE_DISABLED;

func _xp_changed(_old_max_health: int, max_health: int):
	value = max_health;

func _level_changed(_old_max_health: int, max_health: int):
	value = LevelData.xp;
	label.text = str(max_health);
	max_value = LevelData.get_xp_for_next_level();
