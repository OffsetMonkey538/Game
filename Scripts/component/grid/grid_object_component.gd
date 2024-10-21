class_name GridObjectComponent extends Node2D

var lastGridKey: int;

func _ready():
	lastGridKey = toGridKey();
	GridManager.addObject(self);

# Remove parent from grid when removed/freed
func _exit_tree():
	GridManager.removeObject(self);

func _physics_process(_delta):
	if self.is_queued_for_deletion(): return;
	
	var gridKey: int = toGridKey();
	if lastGridKey != gridKey:
		GridManager.removeObjectFrom(self, lastGridKey);
		GridManager.addObject(self);
	lastGridKey = gridKey;

func toGridPos() -> Vector2:
	return GridManager.gridPosFromPosVector(global_position);

func toGridKey() -> int:
	return GridManager.gridKeyFromGridPosVector(toGridPos());
