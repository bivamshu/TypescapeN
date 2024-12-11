extends Node
class_name CommandHandler

@onready var ceiling_collider = $CeilingDetector
var player

func set_player(p):
	if p == null:
		push_error("CommandHandler: Player reference is null")
		return
	player = p

func process_command(command: String):
	# Validate player reference
	if player == null:
		push_error("CommandHandler: No player set")
		return
	
	var final_command = command.strip_edges().to_lower()
	
	# Validate word and process command
	if player.word_manager.check_word(final_command):    
		if player._check_ceiling_ahead() and not player._check_wall_ahead():
			player.is_sliding = true
			player.slide()
		else:
			player.jump()        
		player.update_word_display()
	else:
		# Optional: Add feedback for invalid commands
		print("Invalid command: ", final_command)
