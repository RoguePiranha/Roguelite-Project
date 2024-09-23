extends Control

# Variables to store user selection
var selected_race = ""
var selected_class = ""

# Reference to RacesDict and ClassesDict
var races = preload("res://Scripts/Characters/RacesDict.gd").new()
var classes = preload("res://Scripts/Characters/ClassesDict.gd").new()

# Player data (you would typically load this from a save file)
var player_data = {
	"unlocked_races": [],  # Initially empty, will be populated from save or defaults
	"unlocked_classes": []  # Initially empty, will be populated from save or defaults
}

# Called when the node enters the scene tree
func _ready():
	# Show available race buttons based on player progress
	#######for race in player_data.unlocked_races:
		########add_race_button(race)
	var available_races = races.get_available_races()	
	for race in available_races:
		add_race_button(race)

	# Show available class buttons based on player progress
	######for className in player_data.unlocked_classes:
		#######add_class_button(className)
	var available_classes = classes.get_available_classes()
	for className in available_classes:
		add_class_button(className)

	# Connect the start game button
	$VBoxContainer/ButtonStartGame.connect("pressed", Callable(self, "_on_start_game"))

# Add a race button based on the race name
func add_race_button(race: String):
	var button = Button.new()
	button.text = race.capitalize()
	button.connect("pressed", Callable(self, "_on_race_selected").bind(race))
	$VBoxContainer/RaceRow/RaceNames.add_child(button)  # Add button to the race container

# Add a class button based on the class name
func add_class_button(className: String):
	var button = Button.new()
	button.text = className.capitalize()
	button.connect("pressed", Callable(self, "_on_class_selected").bind(className))
	$VBoxContainer/ClassRow/ClassNames.add_child(button)  # Add button to the class container

# Race selection function
func _on_race_selected(race: String):
	selected_race = race
	update_race_button_highlight(race)
	print("Selected race: " + race)

# Class selection function
func _on_class_selected(className: String):
	selected_class = className
	update_class_button_highlight(className)
	print("Selected class: " + className)
	
func update_race_button_highlight(selected_race: String):
	for button in $VBoxContainer/RaceRow/RaceNames.get_children():
		if button.text.to_lower() == selected_race:
			button.add_theme_color_override("font_color", Color(1, 1, 0))  # Highlight the selected button
		else:
			button.add_theme_color_override("font_color", Color(1, 1, 1))  # Reset others
			
func update_class_button_highlight(selected_class: String):
	for button in $VBoxContainer/ClassRow/ClassNames.get_children():
		if button.text.to_lower() == selected_class:
			button.add_theme_color_override("font_color", Color(1, 1, 0))  # Highlight the selected button
		else:
			button.add_theme_color_override("font_color", Color(1, 1, 1))  # Reset others

# Start game function
func _on_start_game():
	if selected_race != "" and selected_class != "":
		print("Starting game with race: " + selected_race + " and class: " + selected_class)
		Global.selected_race = selected_race
		Global.selected_class = selected_class
		get_tree().change_scene_to_file("res://Scenes/MainScene.tscn")  # Load MainScene
	else:
		print("Please select both race and class before starting the game.")
