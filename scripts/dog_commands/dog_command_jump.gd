extends DogCommand

class_name DogCommandJump

var jump_vel := Vector2.ZERO

var max_x_velocity_duration := 0.0
var cur_x_velocity_duration := max_x_velocity_duration


func _init(dog: Dog, vel: Vector2, x_duration: float) -> void:
	super(dog)
	jump_vel = vel
	max_x_velocity_duration = x_duration
	cur_x_velocity_duration = x_duration


func physics_process(_delta):
	if !_has_started or _finished:
		return

	super(_delta)

	if cur_x_velocity_duration == max_x_velocity_duration:
		_dog.velocity.y = -jump_vel.y

	cur_x_velocity_duration = clamp(cur_x_velocity_duration - _delta, 0, max_x_velocity_duration)

	# applies x force
	if cur_x_velocity_duration != 0:
		print("jump_vel.x: ", jump_vel.x, " _dog.facing_direction: ", _dog.facing_direction)
		_dog.velocity.x = jump_vel.x * _dog.facing_direction

	if cur_x_velocity_duration == 0 and _dog.is_on_floor():
		_finish()


func execute():
	super()
	_dog.anim_player.play("run")
	print("start: ", _dog.facing_direction)


func _finish():
	super()
	print("end: ", _dog.facing_direction)
