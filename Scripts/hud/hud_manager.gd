extends Node

@onready var HUD: CanvasLayer = $/root/Main/HUD;
@onready var InGameHUD: CanvasLayer = $/root/Main/HUD/InGameHUD;

func is_InGameHUD_visible() -> bool:
	return InGameHUD.visible;

func set_InGameHUD_visible(visible: bool):
	InGameHUD.show() if visible else InGameHUD.hide();
	InGameHUD.process_mode = PROCESS_MODE_INHERIT if visible else PROCESS_MODE_DISABLED;
