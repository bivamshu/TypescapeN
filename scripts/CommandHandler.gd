extends Node

var WordManager
var Player
var PlayerSprite
var word_label  # Reference to the Label showing the current word

func set_player(player):
	Player = player
	PlayerSprite = Player.get_node("AnimatedSprite2D")
	
	if !WordManager:
		WordManager = preload("res://scripts/WordManager.gd").new()
		
	add_child(WordManager)
	WordManager._ready()
	
	# Create word display label if it doesn't exist
	if !Player.has_node("WordLabel"):
		var label = Label.new()
		label.name = "WordLabel"
		label.position = Vector2(0, -50)  # Position above player
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		Player.add_child(label)
		print("WordLabel not found")
	else:
		print("word label found")
	
	word_label = Player.get_node("WordLabel")
	update_word_display()

func process_command(command: String):
	var final_command = command.strip_edges().to_lower()
	
	if WordManager.check_word(final_command):
		_jump()
		update_word_display()

func _jump():
	if not Player.is_jumping and Player.is_on_floor():
		PlayerSprite.play("jump")
		Player.velocity.y = Player.jump_velocity
		Player.is_jumping = true

func update_word_display():
	var new_word = WordManager.pick_random_word()
	word_label.text = new_word
