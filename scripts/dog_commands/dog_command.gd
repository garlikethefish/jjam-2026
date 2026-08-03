class_name DogCommand

signal finished

var _dog: Dog
var _has_started := false
var _finished := false


func _init(dog: Dog) -> void:
	_dog = dog


func _finish():
	_dog.anim_player.play("idle")
	_finished = true
	_dog.footstep_player.stream_paused = true
	finished.emit()


func physics_process(_delta):
	pass


func execute():
	GameManager.executed_command_count += 1
	_has_started = true
