extends DogCommand
class_name DogCommandGoTillHitsWall

var _speed := 0.0
var _direction: Enums.FacingDirection


func _init(dog: Dog, speed: float, direction: Enums.FacingDirection) -> void:
	super(dog)
	_speed = speed
	_direction = direction


func physics_process(delta):
	if !_has_started or _finished:
		return

	super(delta)
	_dog.velocity = Vector2.RIGHT * _direction * _speed * delta

	if _direction == Enums.FacingDirection.LEFT and _dog.left_cast_2d.is_colliding():
		_dog.velocity = Vector2.ZERO
		_finish()

	if _direction == Enums.FacingDirection.RIGHT and _dog.right_cast_2d.is_colliding():
		_dog.velocity = Vector2.ZERO
		_finish()


func execute():
	super()
	_dog.anim_player.play("run")
	_dog.footstep_player.stream_paused = false
	_dog.facing_direction = _direction


func _finish():
	super()
