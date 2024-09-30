extends Node2D

# Path to the Enemy scene
@export var enemy_scene: PackedScene
@export var spawn_interval: float = 2.0  # Time between spawns
@export var max_enemies: int = 10  # Maximum number of enemies on the map at once
@export var spawn_radius: float = 50.0  # Radius within which enemies spawn around the point

var enemies_spawned: int = 0  # Track the number of spawned enemies
var spawn_timer: float = 0.0  # Timer for tracking spawn intervals

func _ready():
	# Initialize any required variables here
	spawn_timer = spawn_interval  # Start the spawn timer

func _process(delta: float):
	# Update the spawn timer
	if enemies_spawned < max_enemies:
		spawn_timer -= delta
		if spawn_timer <= 0:
			spawn_enemy()  # Spawn a new enemy
			spawn_timer = spawn_interval  # Reset the spawn timer

func spawn_enemy():
	if enemy_scene:
		# Instantiate the enemy scene
		var new_enemy = enemy_scene.instantiate()
		
		# Set the enemy's position around the spawn point with a slight random offset
		new_enemy.position = global_position + Vector2(
			randf_range(-spawn_radius, spawn_radius),
			randf_range(-spawn_radius, spawn_radius)
		)
		
		# Add the enemy to the scene
		get_parent().add_child(new_enemy)
		
		# Track the number of enemies spawned
		enemies_spawned += 1
