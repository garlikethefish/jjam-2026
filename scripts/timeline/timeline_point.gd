extends Node

class_name TimelinePoint

var object: Node2D
var object_state: Node2D

func _init(obj: Node2D) -> void:
	object = obj
	#object_state = obj.cop
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
