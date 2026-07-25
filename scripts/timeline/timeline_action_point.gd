extends Node

class_name TimelineActionPoint

var object: Node2D
var object_state: Node2D

func _init(obj: Node2D) -> void:
	object = obj
	object_state = obj.duplicate()


func revert():
	object.global_position = object_state.global_position
	object.rotation = object_state.rotation
