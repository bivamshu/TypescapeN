extends CharacterBody2D  # Use CharacterBody2D for physics support

@onready var UserCommand = $CommandInputField
@onready var PlayerSprite = $AnimatedSprite2D  # Rename for clarity
var CommandHandler  # Declare CommandHandler variable

# Physics variables
var gravity = 500  # Gravity strength
var jump_velocity = -300  # Jump strength (negative to go up)

func _ready(): 
	UserCommand.visible = false 
	CommandHandler = preload("res://scripts/CommandHandler.gd").new()  # Load and instantiate CommandHandler
	CommandHandler.set_player(self)  # Set the player reference to the CharacterBody2D instance

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
	if not is_on_floor():  # Call is_on_floor from CharacterBody2D
		velocity.y += gravity * delta
	else:
		velocity.y = 0  # Reset vertical velocity when on the ground
		
	# Move the player according to velocity
	move_and_slide()  
	
