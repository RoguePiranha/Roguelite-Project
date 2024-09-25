extends Node

# Movement variables (will be set from player.gd)
var speed: float
var acceleration: float
var deceleration: float

# External states
var is_attacking = false

# Direction constants
enum Direction { UP, DOWN, LEFT, RIGHT }

# Keep track of the last movement direction
var last_direction = Direction.DOWN  # Default facing down

# Reference to the player's AnimatedSprite2D node (set from player.gd)
var animated_sprite: AnimatedSprite2D

# Get input from the player
func get_input() -> Vector2:
	return Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

# Apply movement logic based on input
func apply_movement(delta: float, velocity: Vector2) -> Vector2:
	var input_direction = get_input()
	var target_velocity: Vector2
	var current_acceleration: float

	if input_direction != Vector2.ZERO:
		target_velocity = input_direction * speed
		current_acceleration = acceleration
	else:
		target_velocity = Vector2.ZERO
		current_acceleration = deceleration

	velocity = velocity.move_toward(target_velocity, current_acceleration * delta)
	return velocity

# Handle animations based on movement
func update_animations(velocity: Vector2):
	if is_attacking:
		# Add attack logic here if needed
		play_attack_animation()
		return

	if velocity.length() > 0:
		# Determine movement direction
		var direction: Direction = get_movement_direction(velocity)
		last_direction = direction
		play_walk_animation(direction)
	else:
		# Play idle animation based on last movement direction
		play_idle_animation(last_direction)

# Determine movement direction based on velocity
func get_movement_direction(velocity: Vector2) -> Direction:
	if abs(velocity.x) > abs(velocity.y):
		if velocity.x > 0:
			return Direction.RIGHT
		else:
			return Direction.LEFT
	else:
		if velocity.y > 0:
			return Direction.DOWN
		else:
			return Direction.UP

# Play the appropriate walking animation
func play_walk_animation(direction: Direction):
	match direction:
		Direction.UP:
			if animated_sprite.animation != "unarmed_walk_back" or !animated_sprite.is_playing():
				animated_sprite.play("unarmed_walk_back")
		Direction.DOWN:
			if animated_sprite.animation != "unarmed_walk_front" or !animated_sprite.is_playing():
				animated_sprite.play("unarmed_walk_front")
		Direction.LEFT:
			if animated_sprite.animation != "unarmed_walk_left" or !animated_sprite.is_playing():
				animated_sprite.play("unarmed_walk_left")
		Direction.RIGHT:
			if animated_sprite.animation != "unarmed_walk_right" or !animated_sprite.is_playing():
				animated_sprite.play("unarmed_walk_right")

# Play the appropriate idle animation
func play_idle_animation(direction: Direction):
	match direction:
		Direction.UP:
			if animated_sprite.animation != "unarmed_idle_back" or !animated_sprite.is_playing():
				animated_sprite.play("unarmed_idle_back")
		Direction.DOWN:
			if animated_sprite.animation != "unarmed_idle_front" or !animated_sprite.is_playing():
				animated_sprite.play("unarmed_idle_front")
		Direction.LEFT:
			if animated_sprite.animation != "unarmed_idle_left" or !animated_sprite.is_playing():
				animated_sprite.play("unarmed_idle_left")
		Direction.RIGHT:
			if animated_sprite.animation != "unarmed_idle_right" or !animated_sprite.is_playing():
				animated_sprite.play("unarmed_idle_right")

# Function to play attack animation (if needed)
func play_attack_animation():
	# Implement attack animations for each direction if available
	pass

# Function to initialize any required variables or settings
func init():
	# Initialize variables if needed
	pass
