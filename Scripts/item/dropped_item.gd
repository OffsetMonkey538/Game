class_name DroppedItem extends Node2D

var item_name: String = "missing";
var _sprite_texture = preload("res://Assets/Textures/missing.png"); #TODO: set type

@onready var sprite: Sprite2D = $Sprite2D;

func _ready():
	sprite.texture = _sprite_texture;

func set_item(new_item_name: String):
	print("Item name: %s" % new_item_name); 
	item_name = new_item_name;
	_sprite_texture = load("res://Assets/Textures/Item/%s.png" % new_item_name);
