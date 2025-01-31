extends Node

var high_score = 0
var current_score = 0

func save_score():
	var file = FileAccess.open("user://score.save", FileAccess.WRITE)
	file.store_var(high_score)
	file.close()
	
func load_score():
	if FileAccess.file_exists("user://score.save"):
		var file = FileAccess.open("user://score.save", FileAccess.READ)
		high_score = file.get_var()
		file.close()
