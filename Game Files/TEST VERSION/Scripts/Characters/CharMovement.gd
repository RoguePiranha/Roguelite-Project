extends Node

# Movement variables
var agility: float
var speed = 200.0 + (agility * 5)
var acceleration: float = 800  # Default acceleration
var deceleration: float = 3200.0  # Default deceleration

# Dodge mechanic variables
var is_dodging = false
var dodge_duration = 0.5  # Duration of the dodge in seconds
var dodge_cooldown = 1.0  # Time before dodge can be used again
var dodge_timer = 0.0  # Timer to track dodge cooldown
var dodge_speed_multiplier = 3.0  # Speed multiplier during dodge
var dodge_elapsed_time = 0.0  # Track time during dodge

# Reference to the player's AnimatedSprite2D node
var animated_sprite: AnimatedSprite2D = null 

# External states
var is_attacking = false

# Keep track of the last movement direction
var last_direction = Vector2.ZERO  # Default facing down

# Get input from the player
func get_input() -> Vector2:
	return Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

# Apply movement logic based on input
func apply_movement(delta: float, velocity: Vector2) -> Vector2:
	var input_direction = get_input()
	var target_velocity: Vector2
	var current_acceleration: float

	# Check for dodge input
	if Input.is_action_just_pressed("ui_shift") and dodge_timer <= 0:
		start_dodge()

	if is_dodging:
		# Apply dodge speed multiplier based on the last input direction
		target_velocity = last_direction * speed * dodge_speed_multiplier
		current_acceleration = acceleration
	else:
		# Normal movement when not dodging
		if input_direction != Vector2.ZERO:
			target_velocity = input_direction * speed
			last_direction = input_direction  # Update last direction for dodge
			current_acceleration = acceleration
		else:
			target_velocity = Vector2.ZERO
			current_acceleration = deceleration

	# Smoothly move toward the target velocity
	velocity = velocity.move_toward(target_velocity, current_acceleration * delta)
	return velocity

# Start the dodge
func start_dodge():
	is_dodging = true
	dodge_timer = dodge_duration + dodge_cooldown
	dodge_elapsed_time = 0.0  # Reset dodge timer
	# Keep the last movement direction for the dodge roll

# Handle dodge timer and rotation during dodge
func _process(delta: float):
	if dodge_timer > 0:
		dodge_timer -= delta
		if is_dodging:
			dodge_elapsed_time += delta
			play_dodge_animation(delta, dodge_elapsed_time, dodge_duration)  # Rotate the sprite during dodge
			if dodge_elapsed_time >= dodge_duration:
				is_dodging = false  # End the dodge after the duration
				animated_sprite.rotation_degrees = 0  # Reset rotation after dodge

# Play the dodge animation (rotate sprite using Transform2D)
func play_dodge_animation(delta: float, dodge_elapsed_time: float, dodge_duration: float):
	if not animated_sprite:
		# Ensure animated_sprite is set
		animated_sprite = get_node("AnimatedSprite2D")  # Adjust path if needed

	if animated_sprite:
		# Rotate a total of 360 degrees over the dodge_duration
		var total_rotation = 360.0  # Total degrees for the dodge roll
		var rotation_per_frame = total_rotation / dodge_duration  # Degrees per second

		# Apply rotation for this frame (ensuring it's only during the dodge)
		var rotation_amount = rotation_per_frame * delta
		animated_sprite.rotation_degrees += rotation_amount

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

# Function to get the player's movement direction based on velocity
func get_movement_direction(velocity: Vector2) -> Vector2:
	# Normalize the velocity to get the direction
	return velocity.normalized()

# Play the appropriate walking animation
func play_walk_animation(direction: Vector2):
	# Adjust animations based on direction (e.g. up, down, left, right)
	if direction.y < 0:
		# Walk back
		if animated_sprite.animation != "walk_back":
			animated_sprite.play("walk_back")
	elif direction.y > 0:
		# Walk front
		if animated_sprite.animation != "walk_front":
			animated_sprite.play("walk_front")
	elif direction.x < 0:
		# Walk left
		animated_sprite.flip_h = false
		if animated_sprite.animation != "walk_side":
			animated_sprite.play("walk_side")
	elif direction.x > 0:
		# Walk right
		animated_sprite.flip_h = true
		if animated_sprite.animation != "walk_side":
			animated_sprite.play("walk_side")

# Play idle animation based on the last movement direction (8 directions)
func play_idle_animation(direction: Vector2):
	# Adjust idle animations based on the direction the player last moved
	if direction.y < 0:
		if animated_sprite.animation != "idle_back":
			animated_sprite.play("idle_back")
	elif direction.y > 0:
		if animated_sprite.animation != "idle_front":
			animated_sprite.play("idle_front")
	elif direction.x < 0:
		animated_sprite.flip_h = false
		if animated_sprite.animation != "idle_side":
			animated_sprite.play("idle_side")
	elif direction.x > 0:
		animated_sprite.flip_h = true
		if animated_sprite.animation != "idle_side":
			animated_sprite.play("idle_side")

# Function to play attack animation (if needed)
func play_attack_animation():
	# Implement attack animations for each direction if available
	pass
