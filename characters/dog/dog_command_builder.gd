extends RefCounted

class_name DogCommandBuilder

var _commands: Array[DogCommand] = []
var _target_dog: Dog # Optional, if you want to bind it later


func jump(vec: Vector2, x_duration: float) -> DogCommandBuilder:
	_commands.append(DogCommandJump.new(_target_dog, vec, x_duration))
	return self


func go_for(duration: float, speed: float, direnction: Enums.FacingDirection) -> DogCommandBuilder:
	_commands.append(DogCommandGoFor.new(_target_dog, duration, speed, direnction))
	return self


func go_till_hits_a_wall(speed: float, direnction: Enums.FacingDirection) -> DogCommandBuilder:
	_commands.append(DogCommandGoTillHitsWall.new(_target_dog, speed, direnction))
	return self


func go_till_x(x_pos: float, speed: float) -> DogCommandBuilder:
	_commands.append(DogCommandGoTillX.new(_target_dog, x_pos, speed))
	return self


func go_distance(
	distance: float,
	speed: float,
	direnction: Enums.FacingDirection,
) -> DogCommandBuilder:
	_commands.append(DogCommandGoDistance.new(_target_dog, distance, speed, direnction))
	return self


func _init(dog: Dog) -> void:
	_target_dog = dog


func build() -> Array[DogCommand]:
	return _commands
