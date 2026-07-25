extends RefCounted

class_name TimelineAction

var points: Array[TimelineActionPoint] = []

var save_gap_delay = .01
var cur_save_gap_delay = save_gap_delay

var is_reverting := false
var finished_reverting := false
var cur_point: TimelineActionPoint
var cur_point_index := 0

var revert_step_delay := .01
var cur_revert_step_delay := revert_step_delay


# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(delta: float) -> void:
	if !is_reverting: return
	
	cur_revert_step_delay = clamp(cur_revert_step_delay - delta, 0, revert_step_delay)

	print("Doing revert process ", cur_revert_step_delay, points.size())
	
	if cur_revert_step_delay == 0 and points.size() > 0:
		print("going through points: ", cur_point_index)
		cur_point = points[cur_point_index]
		cur_point.revert()
		cur_point_index -= 1
		cur_revert_step_delay = revert_step_delay
		
	if cur_point_index <= 0:
		print("cur_point_index finished")
		is_reverting = false
		finished_reverting = true


func add_point(point: TimelineActionPoint):
	points.push_back(point)


func phisics_add_point(point: TimelineActionPoint, delta):
	if cur_save_gap_delay == 0:
		add_point(point)
		cur_save_gap_delay = save_gap_delay
	else:
		cur_save_gap_delay = clamp(cur_save_gap_delay - delta, 0, save_gap_delay)


func revert():
	is_reverting = true
	cur_point_index = points.size() - 1
	
	print("Started to revert ", cur_point_index)
