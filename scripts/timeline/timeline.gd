extends Node

class_name Timeline

var timeline: Array[TimelineAction] = []
var current_action: TimelineAction

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func add_action(point: TimelineAction):
	timeline.push_back(point)


func go_back_an_action():
	if timeline.size() <= 0: return
	
	current_action = timeline.back()
	current_action.revert()
	
	
	#timeline.pop_back()
