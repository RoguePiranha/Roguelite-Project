extends Node

class_name CharacterStats

var races = preload("res://Scripts/Characters/RacesDict.gd").new()
var classes = preload("res://Scripts/Characters/ClassesDict.gd").new()

# Get base stats from class and race
var class_base_stats = {}
var race_multipliers = {}

func calculate_final_stats(race_name: String, className: String) -> Dictionary:
	var final_stats = {}
	
	#retrieves race and class multipliers
	race_multipliers = races.get_race_multiplier(race_name)
	class_base_stats = classes.get_class_stats(className)
	
	#calculates final stats
	for stat in class_base_stats.keys():
		final_stats[stat] = class_base_stats[stat] * race_multipliers[stat + "_mult"]

	return final_stats

# Function to distribute stats on leveling
func distribute_stat_points(stat_points: Dictionary) -> Dictionary:
	# Add distributed points to the base stats
	for stat in stat_points.keys():
		class_base_stats[stat] += stat_points.get(stat, 0)

	# Apply race multipliers to the new base stats and recalculate final stats
	var final_stats = {}
	for stat in class_base_stats.keys():
		final_stats[stat] = class_base_stats[stat] * race_multipliers[stat + "_mult"]

	return final_stats
