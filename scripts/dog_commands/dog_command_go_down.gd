extends DogCommand

class_name DogCommandGoDown

func _init(_dog: Dog) -> void:
	super(_dog)


func _execute():
	if dog.is_executing_command.is_true(): return
	dog.go_down()
