extends Node

var player 
var countdown_time = 3
var run_time_left = 5

func _init(p):
	player = p
	
func start_countdown():
	player.startup_timer.wait_time = 1
	player.startup_timer.start()
	player.startup_timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	countdown_time -= 1
	if countdown_time > 0:
		player.countdown_label.text = str(countdown_time)
	else:
		player.countdown_label.text = "GO!"
		await get_tree().create_timer(0.5).timeout
		player.can_move = true
		player.countdown_label.visible = false

func update_timer(delta):
	if player.can_move and run_time_left > 0:
		run_time_left -=delta
		player.timer_label.text = "Time: %.2f" % run_time_left
		if run_time_left <= 0:
			run_time_left = 0
			stop_running()
			
func extend_run_time():
	run_time_left += 1.5
	
func start_running():
	player.can_move = true 
	player.velocity.x = 0
	player.word_label.visible = false
	player.movement.update_animation()
	
func stop_running():
	player.can_move = false
	player.velocity.x = 0
	player.movement.update_animation()
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
