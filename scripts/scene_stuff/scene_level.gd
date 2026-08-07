class_name SceneLevel extends Scene

var is_unlocked = false
var name := ""


func _init(_path, _is_unlocked, _name):
	super(_path)
	is_unlocked = _is_unlocked
	name = _name
