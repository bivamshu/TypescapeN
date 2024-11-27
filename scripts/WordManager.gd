#WordManager.gd
extends Node

var jump_words = []
var current_word = ""
var previous_word = ""

func _ready():
	load_words()
	pick_random_word()

func load_words():
	var file = FileAccess.open("res://data/jump_words.txt", FileAccess.READ)
	if file:
		print("file found successfully")
		while !file.eof_reached():
			var line = file.get_line().strip_edges()
			if line != "":
				jump_words.append(line)
	else:
		print("file not found")
func pick_random_word() -> String:
	previous_word = current_word
	if jump_words.size() > 0:
		current_word = jump_words[randi() % jump_words.size()]
		if previous_word == current_word:
			pick_random_word() 	
		return current_word
	return ""

func check_word(input: String) -> bool:
	return input.to_lower() == current_word.to_lower()
