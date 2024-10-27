extends Node

var _data: PlayerDataResource = PlayerDataResource.new();
var _paused: bool = false;

func is_paused() -> bool:
	return _paused;

func pause_game():
	call_deferred("_internal_pause_game", true);
	_paused = true;

func unpause_game():
	call_deferred("_internal_pause_game", false);
	_paused = false;

func _internal_pause_game(pause: bool):
	self.process_mode = PROCESS_MODE_DISABLED if pause else PROCESS_MODE_INHERIT;
