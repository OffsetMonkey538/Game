class_name PlayerHitboxComponent extends HitBoxComponent

func _ready() -> void:
	monitoring = true;

func _process(delta: float) -> void:
	counterSeconds += delta;
	if (counterSeconds < 0.25): return;

	counterSeconds = 0;
	if (!health_component): return;

	for area in get_overlapping_areas():
		if not area is HurtboxComponent: return;
		if get_parent().is_queued_for_deletion(): return;
		health_component.damage(area.damage);