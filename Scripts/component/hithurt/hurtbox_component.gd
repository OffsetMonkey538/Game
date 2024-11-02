class_name HurtboxComponent extends Area2D

@export var damage = 10;

signal hit(what: HitBoxComponent);

func _init():
	area_entered.connect(hitbox_entered);

func hitbox_entered(area: Area2D) -> void:
	if not area is HitBoxComponent: return;
	if get_parent().is_queued_for_deletion(): return;

	area.hurtbox_entered(self);
	hit.emit(area);
