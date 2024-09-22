extends Node

class_name CharacterStats

var races = preload("res://Scripts/Characters/RacesDict.gd").new()
var classes = preload("res://Scripts/Characters/ClassesDict.gd").new()

func calculate_final_stats(race_name: String, classes_name: String) -> Dictionary:
	var final_stats = {}
	var race_multipliers = races.get_race_multiplier(race_name)
	var class_stats = classes.get_class_stats(classes_name)
	
	for stat in class_stats.keys():
		final_stats[stat] = class_stats[stat] * race_multipliers[stat + "_mult"]

	return final_stats
