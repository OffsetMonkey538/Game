extends Node2D

# Map of shooting interval (float) to List of first entry the time since last shoot (float) and rest ProjectileShooters
var projectile_shooters: Dictionary = {};

@onready var shootTimer: Timer = $ShootTimer;

# Called when the node enters the scene tree for the first time.
func _ready():
	get_children().all(func(child):
		if not child is ProjectileShooter: return;
		addProjectileShooter(child);
	);
	
	shootTimer.timeout.connect(Callable(self, "timerTimeout"));
	shootTimer.start();

func addProjectileShooter(projectile_shooter: ProjectileShooter):
	add_child(projectile_shooter);
	var shoot_speed: float = projectile_shooter.shootSpeedSeconds;
	
	if not projectile_shooters.has(shoot_speed):
		projectile_shooters[shoot_speed] = [0.0, projectile_shooter];
		return;
	
	projectile_shooters[shoot_speed] += projectile_shooter

func timerTimeout():
	for interval in projectile_shooters.keys():
		var shooters_array: Array = projectile_shooters.get(interval);
		shooters_array[0] += shootTimer.wait_time;
		
		if shooters_array[0] < interval: continue;
		
		shooters_array[0] = 0;
		# Start at index 1 because the time since last trigger is stored at index 0
		for i in range(1, shooters_array.size()):
			var shooter: ProjectileShooter = shooters_array[i];
			shooter.shootProjectiles();
		
		projectile_shooters[interval] = shooters_array;

# TODO: Remove
func testingThing():
	var shooter: ProjectileShooter = preload("res://Scenes/simple_projectile_shooter.tscn").instantiate();
	addProjectileShooter(shooter)
	pass;
