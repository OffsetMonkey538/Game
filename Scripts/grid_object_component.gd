class_name GridObjectComponent extends Node2D

var lastGridKey: String;

func _ready():
	lastGridKey = toGridKey();
	GridManager.addObject(self);

func _physics_process(_delta):
	var gridKey: String = toGridKey();
	if lastGridKey != gridKey:
		GridManager.removeObjectFrom(self, lastGridKey);
		GridManager.addObject(self);
	lastGridKey = gridKey;

func toGridPos() -> Vector2:
	return GridManager.gridPosFromPosVector(global_position);

func toGridKey() -> String:
	return GridManager.gridKeyFromGridPosVector(toGridPos());
