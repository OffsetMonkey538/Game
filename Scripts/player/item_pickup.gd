extends Node

var upgrades: Array = [];

@export var hit_box_component: HitBoxComponent;

func _ready():
	hit_box_component.hit.connect(Callable(self, "pickup_upgrade"));

func pickup_upgrade(upgradeBox: HurtboxComponent):
	var upgrade: DroppedItem = upgradeBox.get_parent();
	Utils.deferr_free_node(upgrade);
	
	if (upgrade.item_name == "xp"):
		LevelData.add_xp(1);
		return;
	if (upgrade.item_name == "coin"):
		#TODO: Increment some LevelData instead and once player dies, add that to the persistant PlayerData
		LevelData.add_coins(1);
		return;
