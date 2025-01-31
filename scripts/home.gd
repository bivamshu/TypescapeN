extends Sprite2D

func _ready():
	$AnimatedSprite2D.play()  # Play the background animation, if applicable.

func _on_quit_pressed() -> void:
	get_tree().quit()  # This will close the application/game.


func _on_level_four_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_4.tscn")


func _on_level_one_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")
