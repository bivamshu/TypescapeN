# LevelManager.gd
extends Node

class_name LevelManager

signal level_completed
signal game_completed

var current_level: int = 1
var max_levels: int = 3
var levels: Dictionary = {}

func _ready() -> void:
	_initialize_levels()

func _initialize_levels() -> void:
	# Load level configurations from a JSON file or create them programmatically
	levels = {
		1: {
			"scene_path": "res://scenes/levels/Level_1.tscn",
			"required_score": 100,
			"difficulty": "easy"
		},
		2: {
			"scene_path": "res://scenes/levels/Level_2.tscn",
			"required_score": 200,
			"difficulty": "medium"
		},
		3: {
			"scene_path": "res://scenes/levels/Level_3.tscn",
			"required_score": 300,
			"difficulty": "hard"
		}
	}

func load_level(level_number: int) -> Error:
	if not levels.has(level_number):
		return ERR_DOES_NOT_EXIST
		
	var level_data = levels[level_number]
	var level_scene = load(level_data.scene_path)
	if level_scene:
		get_tree().change_scene_to_packed(level_scene)
		return OK
	return ERR_CANT_CREATE

func next_level() -> void:
	if current_level < max_levels:
		current_level += 1
		load_level(current_level)
		emit_signal("level_completed")
	else:
		emit_signal("game_completed")
