extends Node

var command_map = {
	"jump": "_jump",
	"attack": "_attack",
	"slide": "_slide",
	"hook": "_hook"
}


var Player  # Declare Player variable
var PlayerSprite  # Reference to the AnimatedSprite2D
var is_jumping = false  # Track jump state

func set_player(player):
	Player = player
	PlayerSprite = Player.get_node("AnimatedSprite2D")  # Store reference to the AnimatedSprite2D

func process_command(command: String):
	# Convert command to lowercase to ensure case-insensitive matching
	var finalCommand = command.strip_edges().to_lower()
	if finalCommand in command_map:
		call_deferred(command_map[finalCommand])
	else:
		print("Unknown command:", command)

# Command functions
func _jump():
	if not Player.is_jumping and Player.is_on_floor():  # Check if the player can jump
		PlayerSprite.play("jump")  # Play jump animation
		Player.velocity.y = Player.jump_velocity  # Apply jump velocity
		print("jumping")
		Player.is_jumping = true  # Set jumping state
		
func _attack():
	print("Attacking!")

func _slide():
	print("Sliding!")

func _hook():
	print("Hooking!")
