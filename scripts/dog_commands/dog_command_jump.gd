extends DogCommand

class_name DogCommandJump

var jump_vel := Vector2.ZERO
var max_x_velocity_duration := 0.0
var cur_x_velocity_duration := max_x_velocity_duration


func _init(vel: Vector2, x_duration: float) -> void:
	super()
	max_x_velocity_duration = x_duration
	jump_vel = vel


func physics_process(_delta):
	if !_has_started or has_finished:
		return

	super(_delta)

	cur_x_velocity_duration = clamp(cur_x_velocity_duration + _delta, 0, max_x_velocity_duration)

	# applies x force
	if cur_x_velocity_duration != max_x_velocity_duration:
		_dog.velocity.x = jump_vel.x * _dog.facing_direction

	if cur_x_velocity_duration == max_x_velocity_duration and _dog.is_on_floor():
		_finish()


func execute():
	super()
	_dog.anim_player.play("run")
	cur_x_velocity_duration = 0.0

	# pushes up
	_dog.velocity.y = -jump_vel.y
