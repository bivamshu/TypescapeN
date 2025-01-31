extends Node2D

@onready var restart_button = $ReplayButton
@onready var main_menu_button = $MainMenu
@onready var level_label = $LevelLabel
@onready var wpm_label = $WPMLabel

var current_level_path = ""
var main_menu_path = "res://scenes/Home_Page.tscn"
var player_wpm = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if current_level_path != "":
		var level_name = current_level_path.get_file().get_basename()
		var level_number = level_name.replace("level_", "")  # Remove "level_" prefix
		level_label.text = "Level: " + level_number
	wpm_label.text = "WPM: %d" % player_wpm

# Called every frame. 'delta' is the elapsed time since the previous frame.
	restart_button.pressed.connect(_on_replay_button_pressed)
	main_menu_button.pressed.connect(_on_main_menu_button_pressed)
func _process(delta: float) -> void:
	pass
	

func _on_replay_button_pressed() -> void:
	get_tree().change_scene_to_file(current_level_path)

	 # Replace with function body.

func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file(main_menu_button)
	
func set_level_data(level_path: String, wpm: int) -> void:
		current_level_path = level_path
		player_wpm = wpm
