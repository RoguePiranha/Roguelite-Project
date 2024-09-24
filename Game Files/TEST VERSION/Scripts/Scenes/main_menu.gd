extends MarginContainer

var new_game = load("res://Scenes/CharacterSelection.tscn")
var library = load("res://Scenes/Library.tscn")
var settings = load("res://Scenes/Settings.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


# Buttons script
func _on_new_game_pressed() -> void:
	get_tree().change_scene_to_packed(new_game)

func _on_library_pressed() -> void:
	get_tree().change_scene_to_packed(library)

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_packed(settings)
