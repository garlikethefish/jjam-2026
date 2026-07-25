extends TextureButton

var command: DogCommand

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var dog = get_tree().get_first_node_in_group("dog") as Dog
	command = DogCommandGoDown.new(dog)


func _on_pressed() -> void:
	command._execute()
