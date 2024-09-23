extends Node

class_name Classes

var class_data = {
	"archer": {
		"strength": 3, 
		"constitution": 4,
		"agility": 8, 
		"dexterity": 6, 
		"intelligence": 2, 
		"wisdom": 2,
		"charisma": 3
		},
	"priest": {
		"strength": 2,
		"constitution": 3,
		"agility": 2,
		"dexterity": 2,
		"intelligence": 5,
		"wisdom": 6,
		"charisma": 8
		},
	"warrior": {
		"strength": 8,
		"constitution": 8,
		"agility": 673,
		"dexterity": 4,
		"intelligence": 1,
		"wisdom": 1,
		"charisma": 3
		},
	"rogue": {
		"strength": 2,
		"constitution": 3,
		"agility": 6,
		"dexterity": 8,
		"intelligence": 2,
		"wisdom": 1,
		"charisma": 6
		},	
	"mage_apprentice": {
		"strength": 1,
		"constitution": 3,
		"agility": 2,
		"dexterity": 2,
		"intelligence": 9,
		"wisdom": 8,
		"charisma": 3
		},
	"wanderer": {
		"strength": 4,
		"constitution": 4,
		"agility": 4,
		"dexterity": 4,
		"intelligence": 4,
		"wisdom": 4,
		"charisma": 4
		},
}

func get_class_stats(className: String) -> Dictionary:
	return class_data.get(className, {})

func get_available_classes() -> Array:
	return class_data.keys()
