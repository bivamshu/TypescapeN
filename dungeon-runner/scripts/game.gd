extends Node2D
@onready var player = $player

const GAME_START_POSITION := Vector2i(150, 485)
const CAM_START_POSITION := Vector2i(576, 324)

var speed : float
var score : float

const SPEED_MODIFIER : float = 2
const START_SPEED : float = 1.0
const MAX_SPEED : float = 7

# Called when the node enters the scene tree for the first time.
func _ready():
	score = 5
	player.position = GAME_START_POSITION
	player.velocity = Vector2i(0,0)
	$Camera2D.position = CAM_START_POSITION
	$StaticBody2D.position = Vector2i(0,0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	score += speed
	speed = START_SPEED
	player.position.x += speed
	$Camera2D.position.x += speed
	speed = START_SPEED*score/SPEED_MODIFIER
