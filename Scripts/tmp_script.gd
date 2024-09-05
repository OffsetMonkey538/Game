extends TouchScreenButton

func _on_pressed():
	HudManager.set_InGameHUD_visible(!HudManager.is_InGameHUD_visible());
