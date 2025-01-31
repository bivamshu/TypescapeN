extends Node2D

@onready var wpm_label = $WPMLabel
@onready var replay_button = $ReplayButton
@onready var next_button = $NextLevelButton
@onready var menu_button = $MainMenuButton

var final_wpm = 0
var final_score = 0
var next_level_path = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	wpm_label.text = "WPM = %d" % final_wpm
	
	replay_button.pressed.connect(_on_replay_pressed)
	replay_button.pressed.connect(_on_next_pressed)
	menu_button.pressed.connect(_on_menu_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func set_results(wpm, next_level):
	final_wpm = wpm
	next_level_path = next_level
	
func _on_replay_pressed():
	get_tree().reload_curren_scene()
	
func _on_next_pressed():
	if next_level_path != "":
		get_tree().change_scene_to_file(next_level_path)
	else:
		print("No next level found.")

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/Home_Page.tscn")
	
