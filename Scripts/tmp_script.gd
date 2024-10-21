extends TouchScreenButton

func _on_pressed():
	#print("things: %s", GridManager.grid)
	#$/root/Main/World/Level/Player/EnemySpawner.spawnEnemies(18, 250);
	#HudManager.set_InGameHUD_visible(!HudManager.is_InGameHUD_visible());
	var level: AbstractLevel = SceneManager.current_scene;
	if (level.is_paused()): SceneManager.current_scene.unpause_game();
	else: SceneManager.current_scene.pause_game();
