# This script contains utility functions that are used in multiple scripts


# Check if the body is the player
static func is_player(body):
	if body.get_name() == "Player":
		return true
	return false

# Check if the body is the enemy
static func is_enemy(body):
	if body.get_name() == "Enemy":
		return true
	return false
