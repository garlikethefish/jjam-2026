extends DogCommand

class_name DogCommandInteract

func _init(_dog: Dog) -> void:
	super(_dog)


func _execute():
	super()
	if dog.is_executing_command: return

	dog.interact()
