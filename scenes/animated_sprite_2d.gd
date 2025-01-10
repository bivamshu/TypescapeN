extends AnimatedSprite2D

var forward = true  # Direction of animation
var frame_time = 0.1  # Time per frame (1 / 10 FPS = 0.1 seconds)
var time_passed = 0.0  # Accumulated time tracker

func _process(delta):
	time_passed += delta
	if time_passed >= frame_time:
		time_passed = 0.0  # Reset the timer

		# Update the frame based on direction
		if forward:
			frame += 1
			if frame == 47:  # If the last frame is reached
				forward = false  # Reverse direction
		else:
			frame -= 1
			if frame == 0:  # If the first frame is reached
				forward = true  # Reverse direction
