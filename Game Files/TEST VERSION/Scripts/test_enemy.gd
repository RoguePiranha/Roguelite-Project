extends CharacterBody2D

@export var patrol_speed: float = 100.0  # Speed of the enemy while patrolling
@export var chase_speed: float = 150.0   # Speed when chasing the player
@export var turn_speed: float = 5.0      # Speed at which the enemy turns
@export var attack_range: float = 50.0   # Range for attacking the player
@export var detection_area: Area2D       # Area2D for player detection

var patrol_area: Area2D                  # Reference to the patrol area
var is_chasing: bool = false             # Whether the enemy is chasing the player
var player: CharacterBody2D = null       # Reference to the player

# Variables for noise-based movement
var noise := FastNoiseLite.new()
var noise_time: float = 0.0              # Time variable for noise input
var noise_speed: float = 1.0             # Speed at which the noise time increases

func _ready():
	# Reference the PatrolArea (Area2D)
	patrol_area = get_parent().get_node("PatrolArea")  # Adjust path if needed

	# Configure the noise parameters
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	noise.seed = rng.randi()

	noise.frequency = 0.1  # Adjust as needed
	noise.noise_type = FastNoiseLite.NoiseType.TYPE_PERLIN  # Choose the noise type
	noise.fractal_type = FastNoiseLite.FractalType.FRACTAL_FBM  # Optional

	# Correct property names
	noise.fractal_octaves = 3           # Corrected from noise.octaves
	noise.fractal_lacunarity = 2.0      # Corrected from noise.lacunarity
	noise.fractal_gain = 0.5            # Corrected from noise.gain

	# Connect signals to the detection area
	detection_area.body_entered.connect(_on_player_detected)
	detection_area.body_exited.connect(_on_player_lost)

func _physics_process(delta: float):
	if is_chasing and player != null:
		# Chase the player
		var target_direction = (player.global_position - global_position).normalized()
		velocity = target_direction * chase_speed
	else:
		# Patrol using noise
		patrol_with_noise(delta)

	# Smooth the enemy's rotation to follow the direction of movement
	_smooth_rotation(velocity.normalized(), delta)

	move_and_slide()

func patrol_with_noise(delta: float):
	# Increment the noise time
	noise_time += delta * noise_speed

	# Generate noise-based offsets
	var noise_x = noise.get_noise_2d(noise_time, 0.0)
	var noise_y = noise.get_noise_2d(0.0, noise_time)

	# Create a direction vector based on the noise
	var noise_direction = Vector2(noise_x, noise_y).normalized()

	# Move within the patrol area bounds
	var target_velocity = noise_direction * patrol_speed

	# Ensure the enemy stays within the patrol area
	var collision_shape = patrol_area.get_node("CollisionShape2D")
	var shape = collision_shape.shape
	var local_position = patrol_area.to_local(global_position)

	if shape is RectangleShape2D:
		var extents = shape.extents
		# Check if the local position is within the rectangle defined by -extents to +extents
		if abs(local_position.x) > extents.x or abs(local_position.y) > extents.y:
			# Enemy is outside the patrol area, move back towards the center
			var center_direction = (patrol_area.global_position - global_position).normalized()
			target_velocity = center_direction * patrol_speed
	else:
		# Handle other shape types if needed
		pass

	velocity = target_velocity

# Function to smoothly rotate the enemy toward its movement direction
func _smooth_rotation(target_direction: Vector2, delta: float):
	if target_direction.length() > 0:
		# Calculate the angle to face the movement direction
		var target_angle = target_direction.angle()
		# Smoothly rotate toward the target angle
		rotation = lerp_angle(rotation, target_angle, turn_speed * delta)

# Player detection logic
func _on_player_detected(body: Node):
	if body.name == "Player":  # Ensure it's the player
		player = body as CharacterBody2D  # Start chasing the player
		is_chasing = true

# Player lost logic
func _on_player_lost(body: Node):
	if body == player:
		player = null  # Stop chasing the player
		is_chasing = false

# Function to handle player attack (placeholder)
func attack_player():
	if player:
		# Apply damage to the player (assuming the player has a health property)
		player.health -= 10  # Modify as needed
		print("Attacked player! Remaining health: ", player.health)
		
