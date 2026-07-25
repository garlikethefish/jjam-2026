extends AudioStreamPlayer2D


func _ready() -> void:
	play()
	while true:
		await finished
		play()
