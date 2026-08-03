class_name DogCommand

signal finished

var _dog: Dog
var _has_started := false
var has_finished := false


func _init() -> void:
	pass


func _finish():
	_dog.anim_player.play("idle")
	has_finished = true
	_has_started = false
	_dog.footstep_player.stream_paused = true
	finished.emit()


func assign_dog(dog: Dog):
	_dog = dog


func physics_process(_delta):
	pass


func execute():
	GameManager.executed_command_count += 1
	has_finished = false
	_has_started = true
