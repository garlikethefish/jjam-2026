extends DogCommand

class_name DogCommandGoFor

var _duration := 0.0
var _cur_duration := 0.0
var _speed := 0.0
var _direction := Enums.FacingDirection.NONE


func _init(dog: Dog, duration: float, speed: float, direction: Enums.FacingDirection) -> void:
	super(dog)
	_speed = speed
	_duration = duration
	_direction = direction


func physics_process(delta):
	if !_has_started or _finished:
		return

	super(delta)
	_dog.velocity.x = Vector2.RIGHT.x * _direction * _speed * delta
	_cur_duration = clamp(_cur_duration + delta, 0, _duration)

	if _cur_duration == _duration:
		_dog.velocity = Vector2.ZERO
		_finish()


func execute():
	super()
	_dog.anim_player.play("run")
	_dog.footstep_player.stream_paused = false
	_dog.facing_direction = _direction


func _finish():
	super()
