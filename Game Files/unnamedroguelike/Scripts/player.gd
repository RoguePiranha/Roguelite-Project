extends CharacterBody2D

# Movement variables
var speed = 300
var acceleration = 800
var deceleration = 600
var is_attacking = false

# References to animation nodes
var walking_right: AnimatedSprite2D = $WalkRight
var walking_left: AnimatedSprite2D = $WalkLeft
var idle: AnimatedSprite2D = $IdleAnimation

func _ready():
	# Start with the idle animation
	show_idle()

# Get input from the player
func get_input() -> Vector2:
	return Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

func _physics_process(delta):
	var input_direction = get_input()

	# Apply movement logic with acceleration and deceleration
	if input_direction != Vector2.ZERO:
		velocity = velocity.move_toward(input_direction * speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)

	# Move the player
	move_and_slide()

	# Update animations based on movement
	if is_attacking:
		# Add your attack logic here
		pass
	elif velocity.length() > 0.1:
		if velocity.x > 0:
			show_walking_right()
		elif velocity.x < 0:
			show_walking_left()
		else:
			show_idle()
	else:
		show_idle()

# Function to show walking right animation
func show_walking_right():
	idle.visible = false
	walking_left.visible = false
	walking_right.visible = true
	if !walking_right.is_playing():
		walking_right.play("Walking Right")

# Function to show walking left animation
func show_walking_left():
	idle.visible = false
	walking_right.visible = false
	walking_left.visible = true
	if !walking_left.is_playing():
		walking_left.play("Walking Left")

# Function to show idle animation
func show_idle():
	walking_right.visible = false
	walking_left.visible = false
	idle.visible = true
	if !idle.is_playing():
		idle.play("Idle")
