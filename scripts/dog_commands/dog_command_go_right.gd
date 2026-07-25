extends DogCommand
class_name DogCommandGoRight

func _init(_dog: Dog) -> void:
	super(_dog)


func _execute():
	super()
	if dog.is_executing_command.is_true(): return
	dog.go_right()
