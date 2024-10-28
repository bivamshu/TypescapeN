extends Node

@onready var UserCommand = $CommandInputField

var command_map = {
	"jump": "_jump",
	"attack": "_attack",
	"slide": "_slide",
	"hook": "_hook"
}

func _ready():
	UserCommand.visible = false 

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if UserCommand.visible:
			process_command(UserCommand.text)
			UserCommand.text = ""  # Clear text after command execution
		UserCommand.visible = !UserCommand.visible
		if UserCommand.visible:
			UserCommand.grab_focus()

func process_command(command: String):
	# Convert command to lowercase to ensure case-insensitive matching
	var finalCommand = command.strip_edges().to_lower()
	
	if finalCommand in command_map:
		call(command_map[finalCommand])
		
	else:
		print("Unknown command:", command)

# Command functions
func _jump():
	print("Jumping!")

func _attack():
	print("Attacking!")

func _slide():
	print("Sliding!")

func _hook():
	print("Hooking!")
