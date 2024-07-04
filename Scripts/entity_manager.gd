extends Node

const GRID_SIZE: int = 50;

# Map of String to Array of Entity
var entities: Dictionary = {};

func addEntity(entity: Entity):
	addEntityTo(entity, entity.toGridKey());

func addEntityTo(entity: Entity, gridKey: String):
	var entitiesArray = entities.get(gridKey);
	
	if entitiesArray == null || entitiesArray.size() == 0: entitiesArray = [entity];
	else: entitiesArray.append(entity);
	
	entities[gridKey] = entitiesArray;


func removeEntity(entity: Entity):
	removeEntityFrom(entity, entity.toGridKey());

func removeEntityFrom(entity: Entity, gridKey: String):
	var entitiesArray: Array = entities.get(gridKey, []);
	
	entitiesArray.erase(entity);
	
	if entitiesArray.size() == 0: entities.erase(gridKey);
	else: entities[gridKey] = entitiesArray;

func getEntitiesInRadius(origin: Entity, radius: float) -> Array:
	var neighborGridKeys: Array = getNeighborVoxels(origin.toGridPos(), radius);
	
	var result: Array = [];
	for gridKey: String in neighborGridKeys:
		var gridEntities = entities.get(gridKey);
		if gridEntities == null: continue;
		result.append_array(gridEntities);
	return result;

func getNeighborVoxels(origin: Vector2, radius: float) -> Array:
	var offsetMonkey538: int = ceil(radius / GRID_SIZE);
	# Array of grid key strings
	var neighbors: Array = [];
	
	for dX in range(-offsetMonkey538, offsetMonkey538 + 1):
		for dY in range(-offsetMonkey538, offsetMonkey538 + 1):
			neighbors.append(gridKeyFromGridPos(origin.x + dX, origin.y + dY));
	
	return neighbors;

func gridKeyFromGridPosVector(gridPos: Vector2i) -> String:
	return gridKeyFromGridPos(gridPos.x, gridPos.y);
func gridKeyFromGridPos(x: int, y: int) -> String:
	return "%s%s" % [x, y];

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
