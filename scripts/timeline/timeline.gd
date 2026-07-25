extends RefCounted

class_name Timeline

var timeline: Array[TimelineAction] = []
var current_action: TimelineAction


func process(delta):
	if current_action != null:
		current_action.process(delta)

func add_action(point: TimelineAction):
	var cur_action_index = timeline.find(current_action)
	
	timeline = timeline.slice(0, cur_action_index + 1)
	timeline.push_back(point)
	current_action = point
	
	print("added action ", timeline.size())


func go_back_an_action():
	if timeline.size() <= 0 or current_action == null or current_action.is_reverting: return
	
	# take previous action
	if current_action.finished_reverting:
		var cur_action_index = timeline.find(current_action)
		if cur_action_index - 1 == -1: return
		current_action = timeline.get(cur_action_index - 1)
		if current_action == null: return
	
	current_action.revert()
