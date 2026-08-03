extends TextureButton

var command: DogCommand
var dog: Dog


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dog = get_tree().get_first_node_in_group("dog") as Dog
	var ledog = Dog.new().go_left_for(23, 2)
	command = DogCommandGoLeft.new(dog)


func _on_pressed() -> void:
	command._execute()
