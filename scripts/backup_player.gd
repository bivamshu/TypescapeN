# Player.gd
extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var wall_detector = $WallDetector
@onready var ceiling_detector = $CeilingDetector
@onready var word_label = $WordLabel
@onready var timer = $Timer
@onready var startup_timer = $Timer
@onready var countdown_label = $CountdownLabel
@onready var slider_coillsion = $slider_collision
@onready var normal_collider = $CollisionShape2D
@onready var jump_particles = $"Jump Particles"
@onready var timer_label = $TimerLabel
@onready var wpm_label = $WPMLabel

#remove the command input field.

var gravity = 500
var jump_velocity = -125
var player_speed = 100
var is_jumping = false
var word_manager
var command_handler
var countdown_time = 3
var is_sliding = false
var is_word_mode = true
var run_time = 1.5
var run_time_left = 5
var typed_word = ""
var can_move = false 
var words_typed = 0
var total_time_spent = 0
var current_word_time = 0.0
var log_positions = false
var logged_positions = []

var current_word = ""
var is_typing = true
	
func _ready():
	# Initial setup
	word_label.visible = false
	
	# Setup wall detector	
	wall_detector.enabled = true
	
	#Reset WPM counter at the start
	words_typed = 0
	total_time_spent = 0
	current_word_time = 0
	
	# Setup countdown
	set_physics_process(false)  # Disable physics initially
	set_process_input(false)   # Disable input initially
	countdown_label.text = str(countdown_time)
	countdown_label.visible = true
	
	_setup_managers()
	start_countdown()

func _process(delta):
	if wall_detector.is_colliding():
		var collider = wall_detector.get_collider()
		_stop_running()
		
	if log_positions:
		logged_positions.append(global_position)
		
	if run_time_left <= 0:
		log_positions = false
		print("Logged Positions:", logged_positions)
		print("Final Position after 2 minutes:", logged_positions[-1] if logged_positions else "No ")
		
	if can_move and run_time_left > 0:
		run_time_left -= delta
		timer_label.text = "Time: %.2f" % run_time_left
		
		if run_time_left <= 0:
			run_time_left = 0
			_stop_running()
	if is_typing:
		total_time_spent += delta
	update_wpm()
	
func update_wpm():
	if total_time_spent > 0:
		var wpm = ceil((words_typed / total_time_spent) * 60)
		wpm_label.text = "WPM: %d" % wpm 
	else:
		wpm_label.text = "WPM: 0.0"

func start_countdown():
	startup_timer.wait_time = 1
	startup_timer.start()

func _on_timer_timeout():
	log_positions = true
	logged_positions = []
	countdown_time -= 1
	
	$CountdownSound.play()
	
	if countdown_time > 0:
		countdown_label.text = str(countdown_time)
		startup_timer.start()
	else:
		countdown_label.text = "GO!"
		await get_tree().create_timer(0.5).timeout
		
		# Enable player control
		set_physics_process(true)
		set_process_input(true)
		can_move = false 
		countdown_label.visible = false
		startup_timer.stop()

func _setup_managers():
	word_manager = preload("res://scripts/WordManager.gd").new()
	command_handler = preload("res://scripts/CommandHandler.gd").new()
	command_handler.set_player(self)
	add_child(word_manager)
	word_manager._ready()
	update_word_display()

func _physics_process(delta):
	_apply_gravity(delta)
	_handle_movement()
	_show_jump_prompt()
	_check_wall_ahead()
	move_and_slide()
	_update_animation()
	
	if is_on_floor() and is_jumping:
		is_jumping = false
		jump_particles.emitting = true
	
func _apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func _handle_movement():
	if can_move:
		velocity.x = player_speed
	else:
		velocity.x
	
func _check_wall_ahead():
	if wall_detector.is_colliding() :
		var collider = wall_detector.get_collider()
		
		return true
	else:
		return false

func _check_ceiling_ahead():
	if ceiling_detector.is_colliding() :
		var collider = ceiling_detector.get_collider()
		return true
	else:
		return false

func _show_jump_prompt():
	word_label.visible = true
	if !word_label.text:
		update_word_display()

func _hide_jump_prompt():
	word_label.visible = false

func _input(event):
	if event is InputEventKey and event.pressed:
		var typed_char = event.as_text().to_lower()  # Convert the typed character to lowercase
		if event.keycode == KEY_BACKSPACE:
			# Remove the last character if backspace is pressed
			typed_word = typed_word.substr(0, typed_word.length() - 1)
		elif event.keycode == KEY_ENTER:
			print("Player Position: ", global_position)
		else:
			# Append the typed character
			typed_word += typed_char  
		
		print("Typed so far: ", typed_word)
		
		update_word_display()
		# Check if the typed word matches the word in the label
		if typed_word == word_label.text:
			words_typed += 1
			current_word_time = 0 
			update_wpm()
			typed_word = ""
			run_time_left += 1.5
			_reset_word()
			_start_running()  # Reset typed_word for the next word

func _start_running():
	can_move = true 
	velocity.x = player_speed
	word_label.visible = false
	_update_animation()
	
	if run_time_left <= 0:
		run_time_left = 1.5
	
	timer_label.text = "Timer: %.2f" % run_time_left
	
func _reset_word():
	word_label.text = word_manager.pick_random_word()
	typed_word = ""
	word_label.visible = true

func _stop_running():
	can_move = false
	velocity.x = 0
	_update_animation()
	
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")

func _update_animation():
	if not is_on_floor():
		sprite.play("jump")
		$"Jump Particles".emitting = false 
	elif velocity.x != 0 and not is_sliding:
		sprite.play("run")
		$"Jump Particles".emitting = true 
	elif is_sliding and velocity.x != 0:
		sprite.play("slide")
		$"Jump Particles".emitting = false
	else:
		sprite.play("idle")
		$"Jump Particles".emitting = false 

func jump():
	print("jumping")
	if is_on_floor():
		velocity.y = jump_velocity
		is_jumping = true
		sprite.play("jump")
		jump_particles.emitting = true
		$JumpSound.play()


func slide():
	print("sliding")
	if is_on_floor():
		is_sliding = true
		slider_coillsion.disabled = false
		normal_collider.disabled = true
		sprite.play("slide")
		
		# Create a timer to reset sliding after some second
		var slide_timer = get_tree().create_timer(0.6)
		slide_timer.timeout.connect(func():
			is_sliding = false
			slider_coillsion.disabled = true
			normal_collider.disabled = false
			sprite.play("run") 
		)
	
func update_word_display():
	if typed_word == "" and word_label.text == "":
		word_label.text = word_manager.pick_random_word()
		typed_word = ""
		word_label.clear()
		for i in range(word_label.text.length()):
			var letter = word_label.text[i]
			word_label.push_color(Color.GRAY)
			word_label.add_text("%s" % letter)
			word_label.pop()
		return 
	
	word_label.clear()
	
	for i in range(word_label.text.length()):
		var letter = word_label.text[i]
		if i < typed_word.length():
			if typed_word[i] == letter:
				word_label.push_color(Color.WHITE)
				word_label.add_text("%s" % letter)
				word_label.pop()
			else:
				word_label.push_color(Color.RED)
				word_label.add_text("%s" % letter)
				word_label.pop()
		else:
			word_label.push_color(Color.GRAY)
			word_label.add_text("%s" % letter)
			word_label.pop()
			
	word_label.scroll_to_line(0) #Ensure visibility
