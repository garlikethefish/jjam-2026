extends Control

@export var buttons: Array[SceneButton] = []
@export var dog: Dog
var is_clicked = false
var dog_speed := 60000

var go_left: Array[DogCommand] = []
var jump_in_well: Array[DogCommand] = []
var go_to_start_pos: Array[DogCommand] = []
var go_to_heaven: Array[DogCommand] = []


func _ready():
	for button in buttons:
		button.pressed.connect(_fall_buttons.bind(button))
		button.pressed.connect(_on_button_pressed)

	go_left = DogCommandBuilder.new().go_till_hits_a_wall(dog_speed, E.FacingDirection.LEFT).build()
	jump_in_well = DogCommandBuilder.new().go_till_x(550, dog_speed).jump(Vector2(225, 1000), 1).build()
	go_to_start_pos = DogCommandBuilder.new().wait(.3).go_till_x(150, dog_speed).build()
	go_to_heaven = DogCommandBuilder.new().jump(Vector2(200, 2000), 1).build()

	dog.append_and_execute_commands(go_to_start_pos)


func _on_level_selection_pressed():
	if is_clicked:
		return
	dog.append_and_execute_commands(jump_in_well)


func _on_disappear_area_body_entered(_body):
	var tween = get_tree().create_tween().set_parallel()

	tween.tween_property(dog, "modulate", Color(1, 1, 1, 0), 1)
	tween.tween_property(dog, "scale", Vector2.ONE * 0.1, .3)

	await tween.finished

	GameManager.go_to_scene(E.Scenes.LEVEL_SELECTION)


func _on_button_pressed():
	is_clicked = true


func _fall_buttons(pressed_button) -> void:
	pass
	#for i in range(buttons.size()):
	#var button = buttons[i]
	#if pressed_button == button:
	#continue
#
#var timer = get_tree().create_timer(0.1 * i)
#timer.timeout.connect(button.fall_off)


func _on_exit_pressed():
	dog.append_and_execute_commands(go_left)

	await get_tree().create_timer(1.5).timeout
	get_tree().quit()


func _on_options_pressed():
	dog.append_and_execute_commands(go_to_heaven)


func _on_sky_area_body_entered(_body):
	GameManager.go_to_scene(E.Scenes.OPTIONS)
