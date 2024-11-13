extends CharacterBody2D  # Use CharacterBody2D for physics support

@onready var UserCommand = $CommandInputField
@onready var PlayerSprite = $AnimatedSprite2D
var CommandHandler  # Declare CommandHandler variable

# Physics variables
var gravity = 500  # Gravity strength
var jump_velocity = -200  # Jump strength (negative to go up)
var player_speed = 200 # Running speed

var is_jumping = false  # Track jump state

func _ready(): 
	UserCommand.visible = false 
	CommandHandler = preload("res://scripts/CommandHandler.gd").new()  
	CommandHandler.set_player(self)  
	
	velocity.x = player_speed #set running velocity as the game start

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if UserCommand.visible:
			CommandHandler.process_command(UserCommand.text)
			UserCommand.text = ""  # Clear text after command execution
		UserCommand.visible = !UserCommand.visible
		if UserCommand.visible:
			UserCommand.grab_focus()

func _physics_process(delta):
	# Apply gravity if not on the ground
	if not is_on_floor():  
		velocity.y += gravity * delta  # Add gravity to the vertical velocity
		is_jumping = true  # Set jumping state
	else:
		if is_jumping:  # Reset jump state when on the ground
			is_jumping = false
		else:
			PlayerSprite.play("idle")  # Ensure idle animation plays when grounded

	# Move the player according to velocity
	move_and_slide()  # Ensure this is called every frame
