class_name TransformArea
extends Area2D

# call utils.gd
var Utils = preload("res://Scripts/utils.gd")


func _ready() -> void:
	self.connect("body_entered", Callable(self, "_on_body_entered"))
	self.connect("body_exited", Callable(self, "_on_body_exited"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_body_entered(body):
	if Utils.is_player(body):
		var parent = get_parent()
		_transform(parent)


func _on_body_exited(body):
	if Utils.is_player(body):
		var parent = get_parent()
		_untransform(parent)

func _transform(_node):
	pass

func _untransform(_node):
	pass
