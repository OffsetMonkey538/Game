extends Node2D

# Map of shooting interval (float) to List of first entry the time since last shoot (float) and rest ProjectileShooters
var projectile_shooters: Dictionary = {};

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in find_children("*", "ProjectileShooter"):
		addProjectileShooter(child);
		child.shoot_speed_changed.connect(func(old_speed):
			remove_projectile_shooter(child, old_speed);
			addProjectileShooter(child);
		);

func _process(delta: float) -> void:
	for interval in projectile_shooters.keys():
		var shooters_array: Array = projectile_shooters.get(interval);
		shooters_array[0] += delta;

		if shooters_array[0] < interval: continue;

		shooters_array[0] = 0;
		# Start at index 1 because the time since last trigger is stored at index 0
		for i in range(1, shooters_array.size()):
			var shooter: ProjectileShooter = shooters_array[i];
			shooter.shootProjectiles();

		projectile_shooters[interval] = shooters_array;


func addProjectileShooter(projectile_shooter: ProjectileShooter) -> void:
	var shoot_speed: float = projectile_shooter.shootSpeedSeconds;
	
	if not projectile_shooters.has(shoot_speed):
		projectile_shooters[shoot_speed] = [0.0, projectile_shooter];
		return;
	
	projectile_shooters[shoot_speed] += projectile_shooter

func remove_projectile_shooter(projectile_shooter: ProjectileShooter, from_speed: float) -> void:
	if not projectile_shooters.has(from_speed):
		push_error("Can't remove projectile shooter '" + str(projectile_shooter) + "' from projectile shooters as list for speed '" + str(from_speed) + "' doesn't exist!")
		return;
	
	if not projectile_shooters[from_speed].has(projectile_shooter):
		push_error("Can't remove projectile shooter '" + str(projectile_shooter) + "' from projectile shooters it doesn't exist in list for '" + str(from_speed) + "'!")
		return;
	
	projectile_shooters[from_speed].erase(projectile_shooter);
	if (projectile_shooters[from_speed].size() <= 1): projectile_shooters.erase(from_speed);
