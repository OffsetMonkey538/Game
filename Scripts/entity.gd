class_name Entity extends Area2D

var lastGridKey: String;

var health: float = getMaxHealth();

# Called when the node enters the scene tree for the first time.
func _ready():
	lastGridKey = toGridKey();
	EntityManager.addEntity(self);

func _physics_process(_delta):
	var gridKey: String = toGridKey();
	if lastGridKey != gridKey:
		EntityManager.removeEntityFrom(self, lastGridKey);
		EntityManager.addEntity(self);
	lastGridKey = gridKey;

func toGridPos() -> Vector2:
	return (global_position / EntityManager.GRID_SIZE).floor();

func toGridKey() -> String:
	return EntityManager.gridKeyFromGridPosVector(toGridPos());

func damage(amount: float):
	health -= amount;
	if health > 0: return;
	
	EntityManager.removeEntity(self);
	queue_free();

func getMaxHealth() -> float:
	push_error("UNIMPLEMENTED METHOD: Entity.getMaxHealth()");
	return -1;
