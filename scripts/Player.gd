extends CharacterBody2D

@onready var UserCommand = $CommandInputField
@onready var PlayerSprite = $AnimatedSprite2D
var CommandHandler

# Physics variables
var gravity = 500
var jump_velocity = -125
var player_speed = 100
var is_jumping = false
var is_running = false  # New variable to track running state

func _ready():
	UserCommand.visible = false
	CommandHandler = preload("res://scripts/CommandHandler.gd").new()
	CommandHandler.set_player(self)
	velocity.x = 0  # Start standing still

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if UserCommand.visible:
			CommandHandler.process_command(UserCommand.text)
			UserCommand.text = ""
		UserCommand.visible = !UserCommand.visible
		if UserCommand.visible:
			UserCommand.grab_focus()

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta
		is_jumping = true
		PlayerSprite.play("jump")
	else:
		if is_jumping:
			is_jumping = false
			#if is_running:  # Resume running animation if we were running
				#PlayerSprite.play("run")
			#else:
				#PlayerSprite.play("idle")
		elif not is_running:  # Only play idle if we're not running
			PlayerSprite.play("idle")
		
	# Maintain running velocity
	if is_running:
		velocity.x = player_speed
		if is_on_floor():  # Only play run animation when on floor
			PlayerSprite.play("run")

	move_and_slide()
