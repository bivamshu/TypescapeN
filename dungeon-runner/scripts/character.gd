extends Node

@onready var line_edit = $LineEdit

var command_map = {
	"jump": "_jump",
	"attack": "_attack",
	"slide": "_slide",
	"hook": "_hook"
}

func _ready():
	line_edit.visible = false

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if line_edit.visible:
			process_command(line_edit.text)
			line_edit.text = ""  # Clear text after command execution
		line_edit.visible = !line_edit.visible
		if line_edit.visible:
			line_edit.grab_focus()

func process_command(command: String):
	# Convert command to lowercase to ensure case-insensitive matching
	var normalized_command = command.to_lower()
	
	if normalized_command in command_map:
		call(command_map[normalized_command])
		
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
