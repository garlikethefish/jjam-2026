extends Control

@export var buttons: Array[CustomButton] = []
@export var dog: Dog
var is_clicked = false

func _ready():
	for button in buttons:
		button.pressed.connect(_fall_buttons.bind(button))
		button.pressed.connect(_on_button_pressed)
		
	await get_tree().create_timer(.3).timeout
	dog.go_right()


func _on_level_selection_pressed():
	if is_clicked: return
	dog.go_right()


func _on_starting_pos_body_entered(_body):
	if is_clicked: return
	dog.stop()


func _on_jump_pos_body_entered(_body):
	dog.stop()
	dog.jump()


func _on_disappear_area_body_entered(_body):
	var tween = get_tree().create_tween().set_parallel()
	
	tween.tween_property(dog, "modulate", Color(1, 1, 1, 0), 1)
	tween.tween_property(dog, "scale", Vector2.ONE * 0.1, .3)
	
	await tween.finished
	
	GameManager.go_to_scene("LevelSelection")


func _on_button_pressed():
	is_clicked = true


func _fall_buttons(pressed_button) -> void:
	for i in range(buttons.size()):
		var button = buttons[i]
		if pressed_button == button: 
			continue

		var timer = get_tree().create_timer(0.1 * i)
		timer.timeout.connect(button.fall_off)


func _on_exit_pressed():
	dog.stop()
	dog.go_left()
	
	await get_tree().create_timer(1.5).timeout
	get_tree().quit()
