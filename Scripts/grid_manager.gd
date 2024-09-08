extends Node

const GRID_SIZE: int = 50;

# Map of int to Array of Entity
var grid: Dictionary = {};

func addObject(object: GridObjectComponent):
	addObjectTo(object, object.toGridKey());

func addObjectTo(object: GridObjectComponent, gridKey: int):
	var objectArray = grid.get(gridKey);
	
	if objectArray == null || objectArray.size() == 0: objectArray = [object];
	else: objectArray.append(object);
	
	grid[gridKey] = objectArray;


func removeObject(object: GridObjectComponent):
	removeObjectFrom(object, object.toGridKey());

func removeObjectFrom(object: GridObjectComponent, gridKey: int):
	var objectArray: Array = grid.get(gridKey, []);
	
	objectArray.erase(object);
	
	if objectArray.size() == 0: grid.erase(gridKey);
	else: grid[gridKey] = objectArray;

func getObjectsInRadiusAroundObject(origin: GridObjectComponent, radius: float) -> Array:
	return getObjectsInRadius(origin.toGridPos(), radius);

func getObjectsInRadius(origin: Vector2, radius: float) -> Array:
	var neighborGridKeys: Array = getNeighborVoxels(origin, radius);
	
	var result: Array = [];
	for gridKey: int in neighborGridKeys:
		var gridObjects = grid.get(gridKey);
		if gridObjects == null: continue;
		result.append_array(gridObjects);
	return result;

func getNeighborVoxels(origin: Vector2i, radius: float) -> Array:
	var offsetMonkey538: int = ceil(radius / GRID_SIZE);
	# Array of grid key integers
	var neighbors: Array = [];
	
	for dX in range(-offsetMonkey538, offsetMonkey538 + 1):
		for dY in range(-offsetMonkey538, offsetMonkey538 + 1):
			neighbors.append(gridKeyFromGridPos(origin.x + dX, origin.y + dY));
	
	return neighbors;

func gridKeyFromPosVector(pos: Vector2) -> int:
	return gridKeyFromGridPosVector(gridPosFromPosVector(pos))
func gridKeyFromGridPosVector(gridPos: Vector2i) -> int:
	return gridKeyFromGridPos(gridPos.x, gridPos.y);
# Morton code, interleaves bits of x and y into a single 64-bit integer
func gridKeyFromGridPos(x: int, y: int) -> int:
	var morton: int = 0;
	
	for i in range(32):
		morton |= ((x & (1 << i)) << i) | ((y & (1 << i)) << (i + 1));
	return morton;

func gridPosFromPosVector(pos: Vector2) -> Vector2i:
	return (pos / GRID_SIZE).floor();
