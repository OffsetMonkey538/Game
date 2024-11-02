class_name HitBoxComponent extends Area2D

@export var health_component: HealthComponent;

signal hit(by: HurtboxComponent);

var counterSeconds: float = 0;

func _ready() -> void:
	monitoring = false;

func hurtbox_entered(area: Area2D) -> void:
	if not area is HurtboxComponent: return;
	if area.get_parent().is_queued_for_deletion(): return;
	if get_parent().is_queued_for_deletion(): return;
	
	hit.emit(area);
	
	if (health_component): health_component.damage(area.damage);
