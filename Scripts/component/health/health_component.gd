class_name HealthComponent extends Node

@export var max_health: float = 100;

@onready var health: float = max_health;

var max_health_modifiers: Array = [];
var is_dead = false;

signal death;
signal health_changed(old_value: float, new_value: float);
signal max_health_changed(old_value: float, new_value: float);

func damage(amount: float):
	if is_dead: return;
	
	var old_health = health;
	health -= amount;
	
	health_changed.emit(old_health, health);
	if health > 0: return;
	
	is_dead = true;
	
	death.emit();
	Utils.deferr_free_node(get_parent())

func heal(amount: float):
	if is_dead: return;
	
	var old_health = health;
	health += amount;
	if health > get_max_health(): health = get_max_health();
	
	if old_health == health: return;
	health_changed.emit(old_health, health);

func add_max_health(amount: float):
	var old_health = health;
	var old_max_health = get_max_health();
	
	var ratio = old_health / old_max_health;
	
	max_health += amount;
	
	health = ratio * get_max_health();
	
	health_changed.emit(old_health, health);
	max_health_changed.emit(old_max_health, get_max_health());

func set_max_health(amount: float):
	var old_max_health = get_max_health();
	max_health = amount;
	max_health_changed.emit(old_max_health, get_max_health())
	

func get_max_health() -> float:
	# TODO: Apply health modifiers, whatever those are
	return max_health;
