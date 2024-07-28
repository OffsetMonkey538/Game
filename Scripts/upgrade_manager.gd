extends Node

var upgrades: Array = [];

@export var hit_box_component: HitBoxComponent;

func _ready():
	hit_box_component.hit.connect(Callable(self, "pickup_upgrade"));

func pickup_upgrade(upgradeBox: HurtboxComponent):
	var upgrade: DroppedItem = upgradeBox.get_parent();
	if (upgrade.item_name == "coin"):
		PlayerData.get_data().money += 1;
		Utils.deferr_free_node(upgrade);
