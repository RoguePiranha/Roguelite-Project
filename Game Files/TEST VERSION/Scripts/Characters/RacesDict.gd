extends Node

class_name Races


var race_data = {
	"human": {
		"strength_mult": 1.0, 
		"constitution_mult": 1.0,
		"agility_mult": 1.0, 
		"dexterity_mult": 1.0, 
		"intelligence_mult": 1.0, 
		"wisdom_mult": 1.0,
		"charisma_mult": 1.0
	},    
	"elf": {
		"strength_mult": 0.8, 
		"constitution_mult": 0.9,
		"agility_mult": 1.2, 
		"dexterity_mult": 1.1, 
		"intelligence_mult": 1.25, 
		"wisdom_mult": 1.1,
		"charisma_mult": 1.0
	},
	"dwarf": {
		"strength_mult": 1.3, 
		"constitution_mult": 1.3,
		"agility_mult": 0.8, 
		"dexterity_mult": 1.0, 
		"intelligence_mult": 0.8, 
		"wisdom_mult": 1.0,
		"charisma_mult": 0.9
	},
	"halfling": {
		"strength_mult": 0.6, 
		"constitution_mult": 0.8,
		"agility_mult": 1.3, 
		"dexterity_mult": 1.2, 
		"intelligence_mult": 1.0, 
		"wisdom_mult": 1.0,
		"charisma_mult": 1.2
	},
	"goblin": {
		"strength_mult": 0.7, 
		"constitution_mult": 0.9,
		"agility_mult": 1.3, 
		"dexterity_mult": 1.2, 
		"intelligence_mult": 0.7, 
		"wisdom_mult": 0.8,
		"charisma_mult": 0.4
	},
	"kobold": {
		"strength_mult": 0.7, 
		"constitution_mult": 0.8,
		"agility_mult": 1.2, 
		"dexterity_mult": 1.3, 
		"intelligence_mult": 1.1, 
		"wisdom_mult": 0.9,
		"charisma_mult": 0.8
	},
}

func get_race_multiplier(race_name: String) -> Dictionary:
	return race_data.get(race_name, {})

func get_available_races() -> Array:
	return race_data.keys()
