extends TextureButton

@export var speed := 10000.0
var go_right_till_wall: Array[DogCommand] = []
var dog: Dog


func _ready() -> void:
	dog = get_tree().get_first_node_in_group("dog") as Dog
	go_right_till_wall = DogCommandBuilder.new() \
			.go_till_hits_a_wall(speed, Enums.FacingDirection.RIGHT) \
			.build()


func _on_pressed() -> void:
	dog.try_execute_commands(go_right_till_wall)
