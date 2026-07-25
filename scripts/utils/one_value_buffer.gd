extends RefCounted

class_name OneValueBoolBuffer

var cur_value: bool
var previous_value: bool

func _init(value: bool) -> void:
	cur_value = value
	previous_value = value
	

func set_value(value: bool):
	previous_value = cur_value
	cur_value = value


func just_true():
	return !previous_value and cur_value
	

func just_false():
	return !cur_value and previous_value


func is_true():
	return cur_value
	
