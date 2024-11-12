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
		print("Executed command:", finalCommand)  # Feedback
	else:
		print("Unknown command:", command)

# Command functions
func _jump():
	if Player.is_on_floor() and not is_jumping:  # Check if the player is on the floor and not already jumping
		Player.velocity.y = -300  # Set the jump velocity
		PlayerSprite.play("jump")  # Play the jump animation
		is_jumping = true  # Set the jump state to true
		print("Jumping!")
	elif is_jumping:
		# If jumping and falling
		if Player.velocity.y >= 0 and not Player.is_on_floor():
			print("Falling...")
		elif Player.is_on_floor():  # Check if the player has landed
			is_jumping = false  # Reset jump state
			PlayerSprite.play("walk")  # Transition to walking or idle animation when landing
			print("Landed!")

func _attack():
	if PlayerSprite.animation != "attack":  # Check if not already attacking
		PlayerSprite.play("attack")  # Play attack animation
		print("Attacking!")

func _slide():
	if PlayerSprite.animation != "slide":  # Check if not already sliding
		PlayerSprite.play("slide")  # Play slide animation
		print("Sliding!")

func _hook():
	if PlayerSprite.animation != "hook":  # Check if not already hooking
		PlayerSprite.play("hook")  # Play hook animation
		print("Hooking!")
