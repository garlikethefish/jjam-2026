extends TextureButton

@export var jump_force := Vector2(250, 1000)
@export var x_force_duration := 0.3
var jump: Array[DogCommand]
var dog: Dog


func _ready() -> void:
	dog = get_tree().get_first_node_in_group("dog") as Dog
	jump = DogCommandBuilder.new().jump(jump_force, x_force_duration).build()


func _on_pressed() -> void:
	dog.try_execute_commands(jump)
