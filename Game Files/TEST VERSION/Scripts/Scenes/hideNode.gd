extends TransformArea


# Called when the node enters the scene tree for the first time.
func _transform(node):
	node.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _untransform(node):
	node.show()
