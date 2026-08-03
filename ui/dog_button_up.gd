extends TextureButton

@export var jump_force := Vector2.ZERO
@export var x_duration := 0.0
var command: Array[DogCommand]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var dog = get_tree().get_first_node_in_group("dog") as Dog
	dog_command = dog.jump(jump_force, x_duration)


func _on_pressed() -> void:
	dog_command.execute()
