extends TextureButton

@export var speed := 10000.0
var go_left_till_wall: Array[DogCommand] = []
var dog: Dog


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dog = get_tree().get_first_node_in_group("dog") as Dog
	go_left_till_wall = DogCommandBuilder.new() \
			.go_till_hits_a_wall(speed, E.FacingDirection.LEFT) \
			.build()


func _on_pressed() -> void:
	dog.try_execute_commands(go_left_till_wall)
