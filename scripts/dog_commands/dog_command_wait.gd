extends DogCommand

class_name DogCommandWait

var duration_seconds := 0.0
var spent_time := 0.0


func _init(seconds: float) -> void:
	super._init()
	duration_seconds = seconds


func physics_process(delta: float) -> void:
	if has_finished or !_has_started:
		return

	print("physics wait")
	super(delta)

	if spent_time == duration_seconds:
		_finish()

	spent_time = clamp(spent_time + delta, 0, duration_seconds)


func execute():
	print("executed")
	super()
