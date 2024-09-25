# Holds all unlockables and whether or not the player has seen it.
# Also holds achievements and quests and things

#Demon_King:
	#has_seen[]
	#has_killed[]


var total_playtime: float = 0.0  # In seconds
var learned_skills: Dictionary = {}  # key: skill_name, value: level or data
var learned_spells: Dictionary = {}  # key: spell_name, value: level or data
var completed_quests: Array = []  # List of completed quest_ids
var classesPlayedAs: Dictionary = {}
var RacesPlayedAs: Dictionary = {}
var unlockedStarterClasses: Dictionary = {}
var unlockedStarterRaces: Dictionary = {}
var longestRunForEachPlayerClassCombo: Dictionary = {}
