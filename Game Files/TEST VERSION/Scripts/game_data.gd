# Holds all unlockables and whether or not the player has seen it.
# Also holds achievements and quests and things

#Demon_King:
	#has_seen[]
	#has_killed[]


var total_playtime: float = 0.0  # In seconds
var enemies_seen: Dictionary = {
	"Rat": false,
	"Bat": false,
	"Cat": false,
	"Hat": false,
	"Pat": false,
	"Matt": false,
	"Watt": false,
	"Gnat": false,
	"Oat": false,
	"Goat": false,
	"Boat": false,
	"Coat": false,
	"Float": false,
	"Moat": false,
	"Throat": false,
	"Quote": false,
	"Note": false,
	"Vote": false,
	# etc
}
var learned_skills: Dictionary = {
	# We need to define what some of these are
	"": false,
	"1": false,
	"2": false,
	"3": false,
	"4": false,
	"5": false
}  # key: skill_name, value: level or data
var learned_spells: Dictionary = {
	"mana_bolt": false,
	"firebolt": false,
	"icebolt": false,
	"lightning_bolt": false,
	"earth_shard": false,
	"minor_heal": false,
	"heal": false,
	"greater_heal": false,
	"fireball": false,
	"iceball": false,
}  # key: spell_name, value: level or data

### Why is this an array and not a dictionary?
var completed_quests: Array = []  # List of completed quest_ids
var commonClassesPlayedAs: Dictionary = {
	"Warrior": 0, 
	"Mage Apprentice": 0,
	"Rogue": 0,
	"Priest": 0,
	"Wanderer": 0,
	"Archer": 0,
	"Duelist": 0,
	"Paladin": 0,
	"Ranger": 0,
	"Thief": 0,
	"Beast Tamer": 0,
	"Squire": 0,
	"Monk": 0,
	"Necromancer": 0,
	"Spellsword": 0,
	"Elementalist": 0,
	"Berserker": 0
}
var uncommonClassesPlayedAs: Dictionary = {
	"Assassin": 0, 
	"Fencer": 0,
	"Ranger2": 0,
	"Thief2": 0,
	"Marksman": 0,
	"Beast Tamer2": 0,
	"Berserker": 0,
	"Gladiator": 0,
	"Crusader": 0,
	"Man-at-Arms": 0,
	"Fallen Paladin": 0,
	"High Priest": 0,
	"Cultist": 0,
	"Grave Warden": 0,
	"Fire Elementalist": 0,
	"Mage": 0,
	"Mageblade": 0,
	"Forsaken": 0
}
var rareClassesPlayedAs: Dictionary = {
	"": 0, 
}
var epicClassesPlayedAs: Dictionary = {
	"": 0, 
}
var legendaryClassesPlayedAs: Dictionary = {
	"": 0, 
}
var mythicClassesPlayedAs: Dictionary = {
	"Paragon of Light": 0, 
	"Paragon of the Void": 0, 
}


var RacesPlayedAs: Dictionary = {
	"Human": 0,
	"Elf": 0,
	"Dwarf": 0,
	"Goblin": 0,
	"Kobold": 0,
	"Halfling": 0
}
var unlockedStarterClasses: Dictionary = { 
	"Warrior": true,
	"Mage Apprentice": true,
	"Rogue": true,
	"Priest": true,
	"Wanderer": true,
	"Archer": true,
	"Duelist": false,
	"Paladin": false,
	"Ranger": false,
	"Thief": false,
	"Beast Tamer": false,
	"Squire": false,
	"Monk": false,
	"Necromancer": false,
	"Spellsword": false,
	"Elementalist": false,
	"Berserker": false
}
var unlockedStarterRaces: Dictionary = {
	"Human": true,
	"Elf": true,
	"Dwarf": true,
	"Goblin": true,
	"Kobold": true,
	"Halfling": true
}

var longestRunForEachPlayerClassCombo: Dictionary = {}
var totalPlaytimeForEachPlayerClassCombo: Dictionary = {}
