extends CharacterBody2D

@onready var Player = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		Player.play("walk")
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		Player.play("jump")
	
	
	move_and_slide()
	
