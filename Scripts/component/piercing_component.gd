class_name PiercingComponent extends Node

@export var hurtbox: HurtboxComponent;

var piercing: int = 1;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (!hurtbox):
		push_error("Piercing component doesn't have hurtbox set!");
		return;
	
	hurtbox.hit.connect(func(_what: HitBoxComponent):_on_hit());

func _on_hit() -> void:
	piercing -= 1;
	if (piercing > 0): return;
	Utils.deferr_free_node(get_parent());
