extends StaticBody2D

@export var amount_of_height_to_add := 20
@export var push_direction := "Up"
@export var speed := 20
var finished_action := true
var new_pos : Vector2
var starting_global_position: Vector2

func _ready() -> void:
	starting_global_position = global_position

func _physics_process(delta: float) -> void:
	if !finished_action:
		position = position.move_toward(new_pos, speed * delta)
		
		if position == new_pos:
			finished_action = true

func activate():
	match push_direction:
		"Up":
			new_pos = Vector2(starting_global_position.x, starting_global_position.y - amount_of_height_to_add)
		"Down":
			new_pos = Vector2(starting_global_position.x, starting_global_position.y + amount_of_height_to_add)
		"Left":
			new_pos = Vector2(starting_global_position.x - amount_of_height_to_add, starting_global_position.y)
		"Right":
			new_pos = Vector2(starting_global_position.x + amount_of_height_to_add, starting_global_position.y)	
	finished_action = false
	
func deactivate():
	match push_direction:
		"Up":
			new_pos = starting_global_position
		"Down":
			new_pos = starting_global_position
		"Left":
			new_pos = starting_global_position
		"Right":
			new_pos = starting_global_position
	finished_action = false
