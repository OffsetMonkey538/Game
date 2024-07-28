class_name DespawnTimer extends Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	timeout.connect(func(): Utils.deferr_free_node(self.get_parent()));
