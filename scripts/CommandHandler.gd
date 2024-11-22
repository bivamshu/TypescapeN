extends Node

var command_map = {
	"jump": "_jump",
	"run": "_run",
	"stop": "_stop"
}

var Player
var PlayerSprite

func set_player(player):
	Player = player
	PlayerSprite = Player.get_node("AnimatedSprite2D")

func process_command(command: String):
	var final_command = command.strip_edges().to_lower()
	
	if final_command in command_map:
		call_deferred(command_map[final_command])
	else:
		print("Unknown command:", command)

func _jump():
	if not Player.is_jumping and Player.is_on_floor():
		PlayerSprite.play("jump")
		Player.velocity.y = Player.jump_velocity
		Player.is_jumping = true

func _run():
	Player.is_running = true  # Set running state
	Player.velocity.x = Player.player_speed
	PlayerSprite.play("run")   

func _stop():
	Player.is_running = false  # Clear running state
	Player.velocity.x = 0
	if Player.is_on_floor():
		PlayerSprite.play("idle")
