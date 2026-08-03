extends DogCommand
class_name DogCommandGoTillHitsWall

var _speed := 0.0
var _direction: Enums.FacingDirection


func _init(speed: float, direction: Enums.FacingDirection) -> void:
	super()
	_speed = speed
	_direction = direction


func physics_process(delta):
	if !_has_started or has_finished:
		return

	super(delta)

	if is_already_there():
		_finish()
		return

	_dog.velocity = Vector2.RIGHT * _direction * _speed * delta


func execute():
	super()
	_dog.facing_direction = _direction

	if is_already_there():
		_finish()
		return

	_dog.anim_player.play("run")
	_dog.footstep_player.stream_paused = false


func is_already_there():
	return (_direction == Enums.FacingDirection.LEFT and _dog.left_cast_2d.is_colliding()) \
			or (_direction == Enums.FacingDirection.RIGHT and _dog.right_cast_2d.is_colliding())


func _finish():
	super()
	_dog.velocity = Vector2.ZERO
