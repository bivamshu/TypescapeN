var player
var typed_word = ""
var words_typed = 0
var total_time_spent = 0.0

func _init(p):
	player = p
	
func handle_input(event):
	if event is InputEventKey and event.pressed:
		var typed_char = event.as_text().to_lower()
		if event.keycode == KEY_BACKSPACE:
			typed_word = typed_word.substr(0, typed_word.length() - 1)
		elif event.keycode == KEY_ENTER:
			print("Player Position: ", player.global_position)
		else:
			typed_word += typed_char
		update_word_display()
		if typed_word == player.word_label.text:
			words_typed += 1
			typed_word = "" #resets the word
			player.game_state.extend_run_time()
			reset_word()
			player.game_state.start_running()

func update_word_display():
	player.word_label.text = typed_word

func update_wpm():
	if total_time_spent > 0:
		var wom = ceil((words_typed / total_time_spent) * 60)
		player.wom_label.text = "WPM: 0"
	else:
		player.wpm_label.text = "WPM: 0.0"

func reset_word():
	player.word_label.text = player.word_manager.pick_random_word()
	typed_word = ""
