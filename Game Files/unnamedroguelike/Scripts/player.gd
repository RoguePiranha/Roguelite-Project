extends CharacterBody2D

# Movement and attack variables
var is_attacking = false

# Load the Movement script
var movement = preload("res://Scripts/Characters/CharMovement.gd").new()
var character_stats = preload("res://Scripts/Characters/CharStats.gd").new()

# Player stats
var strength: float
var constitution: float
var agility: float
var dexterity: float
var intelligence: float
var wisdom: float
var charisma: float

func _ready():
	# Assign the Walking and Idle AnimatedSprite2D nodes to the movement script
	movement.walking_right = $WalkRight
	movement.walking_left = $WalkLeft
	movement.idle = $IdleAnimation

	# Initialize player stats (example race: human, class: warrior)
	var final_stats = character_stats.calculate_final_stats("elf", "wanderer")
	strength = round(final_stats["strength"])
	constitution = round(final_stats["constitution"])
	agility = round(final_stats["agility"])
	dexterity = round(final_stats["dexterity"])
	intelligence = round(final_stats["intelligence"])
	wisdom = round(final_stats["wisdom"])
	charisma = round(final_stats["charisma"])

	# Adjust speed based on agility stat
	movement.speed = 300 * (agility / 10.0)

	# Start with the idle animation
	movement.show_idle()

func _physics_process(delta):
	# Use movement script to handle movement and animation
	velocity = movement.apply_movement(delta)  # Use built-in velocity

	# Move the player using the built-in velocity
	move_and_slide()

	# Update animations
	movement.is_attacking = is_attacking  # Pass the current attacking state to movement
	movement.update_animations()
