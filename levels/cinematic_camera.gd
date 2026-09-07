class_name CinematicCamera extends Camera2D

var original_global_pos: Vector2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	original_global_pos = global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func enter():
	enabled = true
	make_current()


func exit():
	enabled = false
