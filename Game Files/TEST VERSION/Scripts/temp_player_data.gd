# Holds current game data
# 518 is the number of stat points a person would
# have at level 100 assuming they evolved classes
# at the lowest possible levels (10,25,50,75)
# and then reached level 100.
	# 3 * 10 = 30
	# 4 * 15 = 60
	# 5 * 25 = 125
	# 6 * 25 = 150
	# 7 * 25 = 175

#var base_speed: float
# Actual movement speed is the base_speed + ((current - base agility) * (base_speed * .01))

# PlayerData.gd
extends Resource  # Use 'Resource' to allow saving/loading, or 'Reference' if not saving directly

class_name PlayerData

# Player's basic information
var race: String = ""
var className: String = ""
var base_stats: Dictionary = {}
var current_stats: Dictionary = {}
var actual_stats: Dictionary = {}

# Level and experience
var level: int = 1
var experience_points: int = 0

# Health and resource stats
var max_hp: int = 100
var current_hp: int = 100
var max_mp: int = 50
var current_mp: int = 50
var max_fp: int = 50
var current_fp: int = 50

var kills = 0
var damageDealt = 0
var damageReceived = 0

# Player position and current level
var position: Vector2 = Vector2.ZERO  # Use Vector3 if your game is 3D
var current_level: String = ""  # Identifier for the current level or area

# Quests
var active_quests: Dictionary = {}  # key: quest_id, value: progress data
var completed_quests: Array = []  # List of completed quest_ids
var quest_progress: Dictionary = {}  # Detailed progress for each quest

# Skills and spells
# example of data structure for learned_skills:
# { "fireball": 3, "heal": 2, "dodge": 1 }
var learned_skills: Dictionary = {}  # key: skill_name, value: level or data
var skill_levels: Dictionary = {}  # key: skill_name, value: skill level
var skill_cooldowns: Dictionary = {}  # key: skill_name, value: remaining cooldown time
var learned_spells: Dictionary = {}  # key: spell_name, value: level or data
var spell_cooldowns: Dictionary = {}  # key: spell_name, value: remaining cooldown time

# Equipment and inventory
var equipped_items: Dictionary = {}  # key: equipment_slot, value: item data
var inventory_items: Array = []  # List of item data
var gold: int = 0

# Achievements and unlockables
var achievements_earned: Array = []  # List of achievement_ids
var unlocked_content: Array = []  # List of content identifiers

# Relationships and reputation
var npc_relationships: Dictionary = {}  # key: npc_id, value: relationship value (e.g., fear level)
var faction_reputation: Dictionary = {}  # key: faction_id, value: reputation value

# Active effects and buffs
var status_effects: Dictionary = {}  # key: effect_name, value: effect data (e.g., duration, strength)
var effect_durations: Dictionary = {}  # key: effect_name, value: remaining duration

# Character appearance
var character_appearance: Dictionary = {
	"hair_style": "",
	"hair_color": Color(1, 1, 1),
	"skin_color": Color(1, 1, 1),
	"eye_color": Color(1, 1, 1),
	# Add other appearance attributes as needed
}
var cosmetic_items: Array = []  # List of cosmetic item identifiers

# Playtime and session data
var total_playtime: float = 0.0  # In seconds
var session_playtime: float = 0.0  # In seconds

# Game version
var game_version: String = "1.0.0"

# Error logs and performance metrics (optional)
var error_logs: Array = []  # List of error messages or codes
var performance_metrics: Dictionary = {}  # Key: metric_name, value: metric_value
