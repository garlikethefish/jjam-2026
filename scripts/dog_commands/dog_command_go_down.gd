extends DogCommand

class_name DogCommandGoDown


func _init(dog: Dog) -> void:
	super(dog)


func _execute():
	_dog.go_down()
