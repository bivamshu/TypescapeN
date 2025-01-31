extends Button

func _on_Start_pressed():
	# Ensure the path is correct for the levels scene
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn") #when start button on the home scene is pressed, the level_1 scene is loaded.
