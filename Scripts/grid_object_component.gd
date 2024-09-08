class_name GridObjectComponent extends Node2D

var lastGridKey: int;
@export var health_component: HealthComponent;

func _ready():
	lastGridKey = toGridKey();
	GridManager.addObject(self);
	
	if health_component:
		health_component.death.connect(func(): GridManager.removeObject(self));

func _physics_process(_delta):
	var gridKey: int = toGridKey();
	if lastGridKey != gridKey:
		GridManager.removeObjectFrom(self, lastGridKey);
		GridManager.addObject(self);
	lastGridKey = gridKey;

func toGridPos() -> Vector2:
	return GridManager.gridPosFromPosVector(global_position);

func toGridKey() -> int:
	return GridManager.gridKeyFromGridPosVector(toGridPos());
