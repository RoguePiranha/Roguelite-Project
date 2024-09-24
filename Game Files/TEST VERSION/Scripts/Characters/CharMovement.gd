extends Node

var character_stats = preload("res://Scripts/Characters/ClassesDict.gd").new()

var selected_race = ""
var selected_class = ""

# Animation state (to hold specific animations for the selected race and class)
var current_animations

# Movement variabl
var acceleration = 800
var deceleration = 3200
var base_speed = 100
var speed_multiplier = 5
var agility: float
var speed: float

	
# Animation reference (single AnimatedSprite2D node)
var animated_sprite: AnimatedSprite2D

# External states
var is_attacking = false
var velocity = Vector2()
var last_horizontal_direction = -1  # 1 for right, -1 for left

func init(race: String, className: String):
	# Ensure selected race and class are initialized from Global
	selected_race = Global.selected_race
	selected_class = Global.selected_class

	# Load specific animations based on race and class
	current_animations = "res://Animations/Character/"+ selected_race.capitalize() + "/" + selected_class.capitalize() + "/Animations.tres"
	var spriteFrames = load(current_animations)
	animated_sprite.frames = spriteFrames
	if current_animations.is_empty():
		print("Error: No animations found for " + selected_race + ", " + selected_class)
	else:
		print("Animations successfully loaded for " + selected_race + ", " + selected_class)
		
func set_sprite(sprite: AnimatedSprite2D):
	animated_sprite = sprite
	if animated_sprite:
		print("AnimatedSprite2D set successfully.")
	else:
		print("Error: AnimatedSprite2D node not found!")
		

# Get input from the player
func get_input() -> Vector2:
	return Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

# Apply movement logic based on input
func apply_movement(delta: float) -> Vector2:
	var input_direction = get_input()
	speed = base_speed + (agility * speed_multiplier)
	
	# Apply movement logic with acceleration and deceleration
	if input_direction != Vector2.ZERO:
		velocity = velocity.move_toward(input_direction * speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
		velocity *= .95
		
	## Stops movement if the player hits a wall or something
	#if is_colliding:
		#velocity = Vector2(0,0)
		#velocity = velocity.move_toward(input_direction * speed, acceleration * delta)

	# Move the player (the caller will need to handle this)
	return velocity

# Handle animations based on movement
func update_animations():
	if is_attacking:
		# Add attack logic here if needed
		animated_sprite.flip_h = last_horizontal_direction == 1
		show_attack()
		return
	
	if velocity.length() > 0:
		if velocity.x != 0:
			last_horizontal_direction = sign(velocity.x)
		# Flip the sprite based on last_horizontal_direction
		animated_sprite.flip_h = last_horizontal_direction == 1
		show_walking()
	else:
		# Maintain the flip direction when idle
		animated_sprite.flip_h = last_horizontal_direction == 1
		show_idle()

# Function to show walking animation
func show_walking():
	if animated_sprite.animation != "walk" or !animated_sprite.is_playing():
		animated_sprite.play("walk")

# Function to show idle animation
func show_idle():
	if animated_sprite.animation != "idle" or !animated_sprite.is_playing():
		animated_sprite.play("idle")

# Function to show attack animation (if needed)
func show_attack():
	if animated_sprite.animation != "attack" or !animated_sprite.is_playing():
		animated_sprite.play("attack")