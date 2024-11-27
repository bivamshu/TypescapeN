extends Node
class_name CommandHandler

var player

func set_player(p):
	player = p

func process_command(command: String):
	var final_command = command.strip_edges().to_lower()
	
	if player.word_manager.check_word(final_command):	 
		player.jump()
		player.update_word_display()
