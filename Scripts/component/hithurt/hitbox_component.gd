class_name HitBoxComponent extends Area2D

@export var health_component: HealthComponent;

signal hit(by: HurtboxComponent);

func _init():
	area_entered.connect(hurtbox_entered);
	monitorable = false;

func hurtbox_entered(area: Area2D):
	if not area is HurtboxComponent: return;
	if get_parent().is_queued_for_deletion(): return;
	
	hit.emit(area);
	
	if health_component: health_component.damage(area.damage);
