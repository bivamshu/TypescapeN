extends Node2D

@onready var ray_sensor = $RayCast2D
@onready var run_guide = $"run guide"
@onready var jump_guide = $"jump guide"

const FADE_DURATION = 0.3  # Duration of fade in seconds
var is_transitioning = false

func _ready():
	# Initialize guides' visibility
	jump_guide.modulate.a = 0  # Fully transparent
	run_guide.modulate.a = 1   # Fully visible

func _process(_delta):
	if ray_sensor.is_colliding() and not is_transitioning:
		transition_guides()

func transition_guides():
	is_transitioning = true
	ray_sensor.enabled = false
	
	# Create fade out tween for run guide
	var tween = create_tween()
	tween.parallel()  # Allow parallel animations
	
	# Fade out run guide
	tween.tween_property(run_guide, "modulate:a", 0.0, FADE_DURATION).set_ease(Tween.EASE_IN_OUT)
	
	# Fade in jump guide
	tween.tween_property(jump_guide, "modulate:a", 1.0, FADE_DURATION).set_ease(Tween.EASE_IN_OUT)
	
	# Optional: Connect to know when the animation is finished
	tween.connect("finished", _on_tween_finished)
	
func _on_tween_finished():
	is_transitioning = false
	
# Optional: Function to reset everything
func reset_animations():
	is_transitioning = false
	ray_sensor.enabled = true
	
	var tween = create_tween()
	tween.parallel()
	
	tween.tween_property(run_guide, "modulate:a", 1.0, FADE_DURATION)
	tween.tween_property(jump_guide, "modulate:a", 0.0, FADE_DURATION)
