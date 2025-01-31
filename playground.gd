extends Node

var word = "space"
var typed_input = ""

#write program to take an inout and print true if the input matches with the word

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		var char = event.as_text().to_lower()
		if event.keycode == KEY_BACKSPACE:
			typed_input = typed_input.substr(0, typed_input.length() - 1)
		else:
			typed_input += char
		
		print("Typed so far: ", typed_input)
		
		if typed_input == word:
			print(true)
			typed_input = ""
