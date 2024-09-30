extends Node2D

func _ready():
	# Define scene or level size (e.g., 1024x768)
	var scene_size = Vector2(30000,30000)

	# Create an Area2D to represent the scene boundary
	var boundary = Area2D.new()
	add_child(boundary)

	# Add a CollisionShape2D to represent the boundary
	var collision_shape = CollisionShape2D.new()
	var rectangle_shape = RectangleShape2D.new()
	rectangle_shape.extents = scene_size / 2  # Half extents to cover the full size
	collision_shape.shape = rectangle_shape
	boundary.add_child(collision_shape)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
