class_name AbstractLevel extends Node

var _data: PlayerDataResource = PlayerDataResource.new();
var _paused: bool = false;

func is_paused() -> bool:
	return _paused;

func pause_game():
	self.process_mode = PROCESS_MODE_DISABLED;
	_paused = true;

func unpause_game():
	self.process_mode = PROCESS_MODE_INHERIT;
	_paused = false;
