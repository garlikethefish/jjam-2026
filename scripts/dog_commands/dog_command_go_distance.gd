extends DogCommand

class_name DogCommandGoDistance

var _target_distance: float
var _speed: float
var _direction := E.FacingDirection.NONE
var _start_position: float = 0.0


func _init(distance: float, speed: float, direction: E.FacingDirection) -> void:
	super()
	_target_distance = distance
	_speed = speed
	_direction = direction


func execute() -> void:
	super.execute()
	_dog.anim_player.play("run")
	_dog.footstep_player.stream_paused = false
	_dog.facing_direction = _direction

	# Record where the dog started on the X-axis
	_start_position = _dog.global_position.x


func physics_process(_delta: float) -> void:
	if has_finished:
		return

	# Apply desired velocity (your Dog script's drag will naturally smooth this out)
	_dog.velocity.x = _speed * _direction

	# Measure actual distance covered from the start point, factoring in drag/acceleration
	var current_distance = abs(_dog.global_position.x - _start_position)

	# Check if we have reached or passed our target pixel distance
	if current_distance >= _target_distance:
		# Snap position or stop instantly to prevent overshooting due to momentum
		_dog.velocity.x = 0
		_finish()
