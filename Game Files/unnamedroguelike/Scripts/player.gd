extends CharacterBody2D

# Declare movement speed
var speed = 1000

# Get input from the player
func get_input() -> Vector2:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	return input_vector.normalized()

# Move the player
func _physics_process(_delta):
	# Set the built-in velocity property (from CharacterBody2D)
	velocity = get_input() * speed
	# Use the move_and_slide method without passing the velocity
	move_and_slide()
