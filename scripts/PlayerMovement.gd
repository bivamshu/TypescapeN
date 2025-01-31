extends Node

var player 
var gravity = 500
var jump_velocity = -125
var player_speed = 100
var is_jumping = false
var is_sliding = false 

# Called when the node enters the scene tree for the first time.
func _init(p):
	player = p

func apply_gravity(delta):
	if not player.is_on_floor():
		player.velocity.y += gravity * delta
		
func handle_movement():
	if player.can_move:
		player.velocity.x = player_speed
	else:
		player.velocity.x = 0

func check_wall_ahead():
	if player.wall_detector.is_colliding():
		player.game_state.stop_running()
		
func update_animation():
	if not player.is_on_floor():
		player.sprite.play("jump")
		player.jump_particles.emitting = false
	elif player.velocity.x != 0 and not is_sliding:
		player.sprite.play("run")
		player.jump_particles.emitting = false
	elif is_sliding:
		player.sprite.play("slide")
		player.jump_particles.emitting = false 
	else:
		player.sprite.play("idle")
		player.jump_particles.emitting = false  
