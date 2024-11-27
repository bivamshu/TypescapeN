extends CharacterBody2D

@onready var UserCommand = $CommandInputField
@onready var PlayerSprite = $AnimatedSprite2D
var CommandHandler
@onready var ray_cast_2d = $RayCast2D

# Physics variables
var gravity = 500
var jump_velocity = -125
var player_speed = 100
var is_jumping = false
var is_running = false 

func _ready():
	UserCommand.visible = false
	CommandHandler = preload("res://scripts/CommandHandler.gd").new()
	CommandHandler.set_player(self)
	velocity.x = 0  # Start standing still

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if UserCommand.visible:
			CommandHandler.process_command(UserCommand.text)
			UserCommand.text = ""
		UserCommand.visible = !UserCommand.visible
		if UserCommand.visible:
			UserCommand.grab_focus()
			
func _physics_process(delta):
	if ray_cast_2d.is_colliding():
		var collider = ray_cast_2d.get_collider()	
		if collider  and collider.has_method("on_player_collide"):
			collider.on_player_collide(self)
		PlayerSprite.play("idle")

	else:
		if not is_on_floor():
			velocity.y += gravity * delta
			is_jumping = true
			PlayerSprite.play("jump")
		elif is_jumping:
			is_jumping = false
		elif not is_running:
			PlayerSprite.play("idle")
		else:
			pass
			
	move_and_slide()
