extends Node

var current_scene: Node = null;
var player: Node = null;

# Called when the node enters the scene tree for the first time.
func _ready():
	_deferred_goto_scene("res://Scenes/level.tscn");

func unload_scene():
	call_deferred("_deferred_unload_scene")
	
func _deferred_unload_scene():
	Utils.deferr_free_node(current_scene);
	current_scene = null;

func goto_scene(path: String):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:

	call_deferred("_deferred_goto_scene", path)

func _deferred_goto_scene(path: String):
	if current_scene: Utils.free_node(current_scene);
	
	var scene: Resource = ResourceLoader.load(path);
	
	current_scene = scene.instantiate();
	
	get_node("/root/Main/World").add_child(current_scene);
