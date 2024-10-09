extends TransformArea


# Called when the node enters the scene tree for the first time.
func _transform(node):
	_fade(node)
	
func _untransform(node):
	_unfade(node)

func _fade(node):
	if _can_fade(node):
		# sets transparency to half
		node.modulate.a = 0.5
	else:
		for child in node.get_children():
			_fade(child)
			

func _unfade(node):
	if _can_fade(node):
		# resets transparency
		node.modulate.a = 1
	else:
		for child in node.get_children():
			_unfade(child)

func _can_fade(node):
	return "modulate" in node
	
