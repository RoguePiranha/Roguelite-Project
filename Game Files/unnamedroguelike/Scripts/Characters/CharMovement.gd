extends Node

# Movement variables
var speed = 300
var acceleration = 800
var deceleration = 600

# Animation references (to be passed in)
var walking_right: AnimatedSprite2D
var walking_left: AnimatedSprite2D
var idle: AnimatedSprite2D

# External states
var is_attacking = false
var velocity = Vector2()

# Get input from the player
func get_input() -> Vector2:
	return Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

# Apply movement logic based on input
func apply_movement(delta: float):
	var input_direction = get_input()

	# Apply movement logic with acceleration and deceleration
	if input_direction != Vector2.ZERO:
		velocity = velocity.move_toward(input_direction * speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)

	# Move the player (the caller will need to handle this)
	return velocity

# Handle animations based on movement
func update_animations():
	if is_attacking:
		# Add attack logic here if needed
		return
	
	if velocity.length() > 0.1:
		if velocity.x > 0:
			show_walking_right()
		elif velocity.x < 0:
			show_walking_left()
	else:
		show_idle()

# Function to show walking right animation
func show_walking_right():
	idle.visible = false
	walking_left.visible = false
	if !walking_right.visible:
		walking_right.visible = true
	if walking_right.animation != "walk_right" or !walking_right.is_playing():
		walking_right.play("walk_right")

# Function to show walking left animation
func show_walking_left():
	idle.visible = false
	walking_right.visible = false
	if !walking_left.visible:
		walking_left.visible = true
	if walking_left.animation != "walk_left" or !walking_left.is_playing():
		walking_left.play("walk_left")

# Function to show idle animation
func show_idle():
	walking_right.visible = false
	walking_left.visible = false
	if !idle.visible:
		idle.visible = true
	if !idle.is_playing():
		idle.play("idle")
