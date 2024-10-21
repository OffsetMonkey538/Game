extends Node

const FILE_NAME = "user://player-data.tres";

var _data: PlayerDataResource;

func _ready():
	_data = load_data();
	tree_exiting.connect(func(): save_data(_data));

func get_data() -> PlayerDataResource:
	return _data;

func save_data(data: PlayerDataResource) -> PlayerDataResource:
	var result = ResourceSaver.save(data, FILE_NAME);
	assert(result == OK);
	return data;

func load_data() -> PlayerDataResource:
	if !ResourceLoader.exists(FILE_NAME): 
		push_error("File '%s' doesn't exist!" % FILE_NAME);
		return save_data(PlayerDataResource.new());
	
	var data = ResourceLoader.load(FILE_NAME);
	if not data is PlayerDataResource:
		push_error("File '%s' contains invalid data!" % FILE_NAME);
		return save_data(PlayerDataResource.new());
	
	return data;
