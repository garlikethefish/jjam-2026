class_name DogCommand

var dog: Dog


func _init(_dog: Dog) -> void:
	dog = _dog


func _execute():
	if dog.is_executing_command: return
	GameManager.executed_command_count += 1
