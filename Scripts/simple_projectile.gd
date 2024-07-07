extends Area2D

@export var damage: int = 200;
@export var speed: int = 250;
var direction: Vector2;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * speed * delta;


func _on_enemy_hit(area):
	if not area is Enemy: return;
	
	var enemy: Enemy = area;
	enemy.damage(damage);
	queue_free();
