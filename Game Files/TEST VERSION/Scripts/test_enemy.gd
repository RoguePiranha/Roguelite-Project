extends CharacterBody2D

@export var patrol_speed: float = 100.0  # Speed of the enemy while patrolling
@export var chase_speed: float = 150.0   # Speed when chasing the player
@export var turn_speed: float = 5.0  # Speed at which the enemy turns
@export var attack_range: float = 50.0   # Range for attacking the player
@export var detection_area: Area2D       # Area2D for player detection

var patrol_area: Area2D  # Reference to the patrol area
var current_target: Vector2  # Current target position for the enemy to move towards
var is_chasing: bool = false  # Whether the enemy is chasing the player
var player: CharacterBody2D = null  # Reference to the player

func _ready():
	# Reference the PatrolArea (Area2D)
	patrol_area = get_parent().get_node("PatrolArea")  # Adjust path if needed
	
	# Connect signals to the detection area
	detection_area.body_entered.connect(Callable(self, "_on_player_detected"))
	detection_area.body_exited.connect(Callable(self, "_on_player_lost"))

	# Start by choosing a random point within the patrol area
	current_target = _get_random_point_in_patrol_area()

func _physics_process(delta: float):
	var target_direction = Vector2.ZERO
	
	if is_chasing and player != null:
		# Chase the player
		target_direction = (player.global_position - global_position).normalized()
		velocity = target_direction * chase_speed
		
	else:
		# Patrol within the area
		target_direction = (current_target - global_position).normalized()
		velocity = target_direction * patrol_speed
		
		# If the enemy reaches the current target, pick a new random point
		if global_position.distance_to(current_target) < 10:
			current_target = _get_random_point_in_patrol_area()
	
	# Smooth the enemy's rotation to follow the direction of movement
	_smooth_rotation(target_direction, delta)
	
	# Add a bit of natural movement smoothing (can be further adjusted)
	velocity = velocity.move_toward(Vector2.ZERO, 10 * delta)  # Optional smoothing
	move_and_slide()

# Function to smoothly rotate the enemy toward its movement direction
func _smooth_rotation(target_direction: Vector2, delta: float):
	if target_direction.length() > 0:
		# Calculate the angle to face the movement direction
		var target_angle = atan2(target_direction.y, target_direction.x)
		
		# Smoothly rotate toward the target angle (you can tweak turn_speed)
		rotation = lerp_angle(rotation, target_angle, turn_speed * delta)

# Function to get a random point within the patrol Area2D
func _get_random_point_in_patrol_area() -> Vector2:
	# Check if the patrol area has a RectangleShape2D or CircleShape2D
	var collision_shape = patrol_area.get_node("CollisionShape2D").shape

	if collision_shape is RectangleShape2D:
		return _get_random_point_in_rectangle(collision_shape as RectangleShape2D)
	elif collision_shape is CircleShape2D:
		return _get_random_point_in_circle(collision_shape as CircleShape2D)

	# Fallback: return patrol area position if no shape is detected
	return patrol_area.global_position

# Get a random point inside a rectangle shape (RectangleShape2D)
func _get_random_point_in_rectangle(rect_shape: RectangleShape2D) -> Vector2:
	var patrol_position = patrol_area.global_position
	var extents = rect_shape.extents * 2  # Get full size from extents
	
	var random_x = randf_range(patrol_position.x - extents.x / 2, patrol_position.x + extents.x / 2)
	var random_y = randf_range(patrol_position.y - extents.y / 2, patrol_position.y + extents.y / 2)
	
	return Vector2(random_x, random_y)

# Get a random point inside a circle shape (CircleShape2D)
func _get_random_point_in_circle(circle_shape: CircleShape2D) -> Vector2:
	var patrol_position = patrol_area.global_position
	var radius = circle_shape.radius
	
	var angle = randf_range(0, 2 * PI)
	var distance = randf_range(0, radius)
	
	var x = patrol_position.x + cos(angle) * distance
	var y = patrol_position.y + sin(angle)
	
	return Vector2(x, y)

# Player detection logic
func _on_player_detected(body: Node2D):
	if body.name == "Player":  # Ensure it's the player
		player = body as CharacterBody2D  # Start chasing the player
		is_chasing = true

# Player lost logic
func _on_player_lost(body: Node2D):
	if body == player:
		player = null  # Stop chasing the player
		is_chasing = false
		# Resume patrol by setting a new target point
		current_target = _get_random_point_in_patrol_area()

# Function to handle player attack
func attack_player():
	if player:
		# Apply damage to the player (assuming the player has a health property)
		player.health -= 10  # Modify as needed
		print("Attacked player! Remaining health: ", player.health)
