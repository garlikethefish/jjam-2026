extends DogCommand

class_name DogCommandGoTillX

var _target_x: float
var _starting_x: float
var _speed: float
var dir := E.FacingDirection.NONE


func _init(x_pos: float, speed: float) -> void:
	super()
	_target_x = x_pos
	_speed = speed


func execute() -> void:
	super.execute()

	_starting_x = _dog.global_position.x

	_dog.anim_player.play("run")
	_dog.footstep_player.stream_paused = false

	dir = get_facing_direction()
	_dog.facing_direction = dir


func physics_process(delta: float) -> void:
	if has_finished:
		return

	_dog.velocity.x = _speed * dir * delta

	# Check if we have reached or passed the target based on our starting side
	if _starting_x < _target_x and _dog.global_position.x >= _target_x:
		_finish()

	elif _starting_x > _target_x and _dog.global_position.x <= _target_x:
		_finish()


func _finish():
	super()
	_dog.velocity.x = 0
	_dog.global_position.x = _target_x


func get_facing_direction():
	var dog_x = _dog.global_position.x
	if _target_x - dog_x < 0:
		return E.FacingDirection.LEFT
	else:
		return E.FacingDirection.RIGHT
