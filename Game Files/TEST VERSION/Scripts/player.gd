extends CharacterBody2D

# Movement and attack variables
var is_attacking = false

# Load the Movement script
var movement = preload("res://Scripts/Characters/CharMovement.gd").new()
var character_stats = preload("res://Scripts/Characters/CharStats.gd").new()

var selected_race = ""
var selected_class = ""

# Player stats
var strength: float
var constitution: float
var agility: float
var dexterity: float
var intelligence: float
var wisdom: float
var charisma: float

# Stores stats player has earned through leveling
var available_stat_points: int = 0

func _ready():
	# Retrieve race and class from Global
	selected_race = Global.selected_race
	selected_class = Global.selected_class

	# Assign the AnimatedSprite2D node to CharMovement
	movement.animated_sprite = $AnimatedSprite2D  # Pass the sprite node
	movement.init()

	print("Player race: " + selected_race + ", Player class: " + selected_class)

	# Testing logic (if Global variables are empty)
	if selected_race == "" or selected_class == "":
		selected_race = "human"  # Default race
		selected_class = "warrior"  # Default class

	# Initialize player stats based on race and class
	var final_stats = character_stats.calculate_final_stats(selected_race, selected_class)

	# ERROR CHECKING
	if final_stats.is_empty():
		print("Error: final_stats dictionary is empty!")
	else:
		print("Final stats: ", final_stats)

	assign_stats(final_stats)

	# Start with the idle animation
	movement.play_idle_animation(Vector2.ZERO)
	
	# initialize velocity
	self.velocity = Vector2.ZERO

func assign_stats(final_stats: Dictionary):
	strength = round(final_stats["strength"])
	constitution = round(final_stats["constitution"])
	agility = round(final_stats["agility"])
	dexterity = round(final_stats["dexterity"])
	intelligence = round(final_stats["intelligence"])
	wisdom = round(final_stats["wisdom"])
	charisma = round(final_stats["charisma"])

	movement.agility = agility

func _physics_process(delta):
	# Use movement script to handle movement and animation
	self.velocity = movement.apply_movement(delta, velocity)  # Pass current velocity

	# Move the player using the built-in velocity
	move_and_slide()

	# Update animations
	movement.is_attacking = is_attacking  # Pass the current attacking state to movement
	movement.update_animations(self.velocity)

# Function to apply stat points during gameplay
func apply_stat_points(points_to_distribute: Dictionary):
	# Distribute earned stat points
	var final_stats = character_stats.distribute_stat_points(points_to_distribute)
	assign_stats(final_stats)

# Function to update race and class mid-game if necessary
func update_race_and_class():
	# Retrieve updated race and class from Global
	selected_race = Global.selected_race
	selected_class = Global.selected_class

	print("Updated Player race: " + selected_race + ", Updated Player class: " + selected_class)

	# Recalculate stats based on new race and class
	var final_stats = character_stats.calculate_final_stats(selected_race, selected_class)
	assign_stats(final_stats)

	# Apply any other necessary changes based on the updated race and class
