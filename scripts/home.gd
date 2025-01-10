extends Sprite2D

func _ready():
	$AnimatedSprite2D.play()  # Play the background animation, if applicable.

func _on_quit_pressed() -> void:
	get_tree().quit()  # This will close the application/game.
