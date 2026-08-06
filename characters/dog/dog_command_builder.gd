extends RefCounted

class_name DogCommandBuilder

var _commands: Array[DogCommand] = []


func jump(vec: Vector2, x_duration: float) -> DogCommandBuilder:
	_commands.append(DogCommandJump.new(vec, x_duration))
	return self


func go_for(duration: float, speed: float, direnction: E.FacingDirection) -> DogCommandBuilder:
	_commands.append(DogCommandGoFor.new(duration, speed, direnction))
	return self


func go_till_hits_a_wall(speed: float, direnction: E.FacingDirection) -> DogCommandBuilder:
	_commands.append(DogCommandGoTillHitsWall.new(speed, direnction))
	return self


func go_till_x(x_pos: float, speed: float) -> DogCommandBuilder:
	_commands.append(DogCommandGoTillX.new(x_pos, speed))
	return self


func wait(seconds: float) -> DogCommandBuilder:
	_commands.append(DogCommandWait.new(seconds))
	return self


func go_distance(distance: float, speed: float, direnction: E.FacingDirection) -> DogCommandBuilder:
	_commands.append(DogCommandGoDistance.new(distance, speed, direnction))
	return self


func _init() -> void:
	pass


func build() -> Array[DogCommand]:
	return _commands
