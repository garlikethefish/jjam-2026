extends Node

class_name Timeline

var timeline: Array[TimelinePoint] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func add_point(point: TimelinePoint):
	timeline.push_back(point)


func go_back_an_action():
	pass


func go_back_a_point():
	print(timeline.size())
	if timeline.size() <= 0: return
	
	var last_point = timeline.back()
	last_point.revert()
	
	timeline.pop_back()
