extends AudioStreamPlayer2D

@export var loop_from_start = true

func _ready() -> void:
	if !loop_from_start: return
	
	play()
	while true:
		await finished
		play()
