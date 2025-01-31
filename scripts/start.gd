extends Button

func _on_Start_pressed():
	# Ensure the path is correct for the levels scene
	get_tree().change_scene_to_file("res://scenes/LevelList.tscn")
	#print("Start button pressed")
