extends Node

# Movement variables
var agility: float
var speed = 200.0 + (agility * 5)
var acceleration: float = 800  # Default acceleration
var deceleration: float = 3200.0  # Default deceleration
# External states
var is_attacking = false

# Direction constants
enum Direction { UP, DOWN, LEFT, RIGHT }

# Keep track of the last movement direction
var last_direction = Vector2.ZERO  # Default facing down

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

# Handle animations based on velocity
func update_animations(velocity: Vector2):
	if is_attacking:
		# Add attack logic here if needed
		play_attack_animation()
		return

	if velocity.length() > 0:
		# Determine movement direction
		var direction: Vector2 = get_movement_direction(velocity)
		last_direction = direction
		play_walk_animation(direction)
	else:
		# Play idle animation based on last movement direction
		play_idle_animation(last_direction)

# Determine movement direction based on velocity for 8 directions
func get_movement_direction(velocity: Vector2) -> Vector2:
	velocity = velocity.normalized()
	return velocity

# Play the appropriate walking animation
func play_walk_animation(direction: Vector2):
	direction = direction.normalized()
	# Check for diagonal movements first
	if direction.x != 0 and direction.y != 0:
		# Top left of screen
		if direction.x < 0 and direction.y < 0:
			animated_sprite.flip_h = false
			if animated_sprite.animation != "walk_back_diag" or !animated_sprite.is_playing():
				animated_sprite.play("walk_back_diag")
		# Top right of screen
		elif direction.x > 0 and direction.y < 0:
			animated_sprite.flip_h = true
			if animated_sprite.animation != "walk_back_diag" or !animated_sprite.is_playing():
				animated_sprite.play("walk_back_diag")
		# Bottom left of screen
		elif direction.x < 0 and direction.y > 0:
			animated_sprite.flip_h = false
			if animated_sprite.animation != "walk_front_diag" or !animated_sprite.is_playing():
				animated_sprite.play("walk_front_diag")
		# Bottom right of screen
		elif direction.x > 0 and direction.y > 0:
			animated_sprite.flip_h = true
			if animated_sprite.animation != "walk_front_diag" or !animated_sprite.is_playing():
				animated_sprite.play("walk_front_diag")
	# Handle single direction movement
	elif direction.x != 0:
		if direction.x < 0:
			animated_sprite.flip_h = false
			if animated_sprite.animation != "walk_side" or !animated_sprite.is_playing():
				animated_sprite.play("walk_side")
		else:
			animated_sprite.flip_h = true
			if animated_sprite.animation != "idle_side" or !animated_sprite.is_playing():
				animated_sprite.play("idle_side")
	elif direction.y != 0:
		if direction.y < 0:
			animated_sprite.flip_h = false
			if animated_sprite.animation != "walk_back" or !animated_sprite.is_playing():
				animated_sprite.play("walk_back")
		else:
			animated_sprite.flip_h = false
			if animated_sprite.animation != "walk_front" or !animated_sprite.is_playing():
				animated_sprite.play("walk_front")

# Play idle animation based on the last movement direction (8 directions)
func play_idle_animation(direction: Vector2):
	# Diagonal animations
	# Top left of screen
	if direction.x < 0 and direction.y < 0:
		if animated_sprite.animation != "walk_back_diag" or !animated_sprite.is_playing():
			animated_sprite.play("walk_back_diag")
	# Top right of screen
	elif direction.x > 0 and direction.y < 0:
		if animated_sprite.animation != "walk_back_diag" or !animated_sprite.is_playing():
			animated_sprite.play("walk_back_diag")
	# Bottom left of screen
	elif direction.x < 0 and direction.y > 0:
		if animated_sprite.animation != "walk_front_diag" or !animated_sprite.is_playing():
			animated_sprite.play("walk_front_diag")
	# Bottom right of screen
	elif direction.x > 0 and direction.y > 0:
		if animated_sprite.animation != "walk_front_diag" or !animated_sprite.is_playing():
			animated_sprite.play("walk_front_diag")
	# Single direction animations
	elif direction.y < 0:
		if animated_sprite.animation != "idle_back" or !animated_sprite.is_playing():
			animated_sprite.play("idle_back")
	elif direction.y > 0:
		if animated_sprite.animation != "idle_front" or !animated_sprite.is_playing():
			animated_sprite.play("idle_front")
	elif direction.x < 0:
		if animated_sprite.animation != "idle_side" or !animated_sprite.is_playing():
			animated_sprite.play("idle_side")
	elif direction.x > 0:
		if animated_sprite.animation != "idle_side" or !animated_sprite.is_playing():
			animated_sprite.play("idle_side")

# Function to play attack animation (if needed)
func play_attack_animation():
	# Implement attack animations for each direction if available
	pass

# Function to initialize any required variables or settings
func init():
	# Initialize variables if needed
	pass
