extends Area2D

var upgrades: Array = [];

func _ready():
	area_entered.connect(Callable(self, "pickup_upgrade"));

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
