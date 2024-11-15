class_name BackgroundHandler extends ParallaxBackground

var parallax_layer: ParallaxLayer = ParallaxLayer.new();
@export var sprite: Texture2D;
@export var sprite_scale: float = 1;

@onready var sprite_width: float = sprite.get_width() * sprite_scale;
@onready var sprite_height: float = sprite.get_height() * sprite_scale;

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(parallax_layer);
	_handle_change();
	
	get_viewport().size_changed.connect(func(): _handle_change());

func _handle_change():
	_reset_layer();
	
	print("thing: " + str(get_viewport().get_visible_rect().size));
	var viewport_size: Vector2 = get_viewport().get_visible_rect().size;
	var viewport_width: float = viewport_size.x;
	var viewport_height: float = viewport_size.y;
	
	var required_amount_width: int = ceili((2 * viewport_width) / sprite_width);
	var required_amount_height: int = ceili((2 * viewport_height) / sprite_height);
	
	parallax_layer.set_mirroring(Vector2(
		required_amount_width * sprite_width,
		required_amount_height * sprite_height
	));
	
	for x in range(required_amount_width):
		for y in range(required_amount_height):
			var current_sprite: Sprite2D = Sprite2D.new();
			current_sprite.texture = sprite;
			current_sprite.scale = Vector2(sprite_scale, sprite_scale);
			
			current_sprite.name = "Background node %s/%s" % [x, y];
			
			current_sprite.position = Vector2(
				sprite_width * x,
				sprite_height * y
			);
			
			parallax_layer.add_child(current_sprite);
	print_tree_pretty()

func _reset_layer():
	parallax_layer.queue_free();
	remove_child(parallax_layer);
	
	parallax_layer = ParallaxLayer.new();
	add_child(parallax_layer);
