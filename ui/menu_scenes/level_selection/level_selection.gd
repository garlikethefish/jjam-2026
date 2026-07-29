extends Control

@export var dog: Dog
@export var fall_initiator_buttons: Array[CustomButton] = []
@export var falling_buttons: Array[CustomButton] = []

@onready var back_button: TextureButton = $BackButton
var is_button_pressed = false
var is_going_back = false

func _ready():
	for button in fall_initiator_buttons:
		button.pressed.connect(_fall_buttons.bind(button))
		button.pressed.connect(_on_button_pressed)

	await get_tree().create_timer(.3).timeout
	dog.go_right()


func _on_stop_area_2d_body_entered(_body):
	if is_button_pressed: return
	print("stop ", is_button_pressed)
	dog.stop()


func _on_end_area_2d_body_entered(_body):
	if is_button_pressed: return
	dog.stop()


func _on_back_area_2d_body_entered(_body):
	print("back")
	GameManager.go_to_scene("HeroScene")


func _on_back_button_pressed():
	is_going_back = true
	is_button_pressed = true
	dog.stop()
	dog.go_left()


func _on_button_pressed():
	is_button_pressed = true
	if is_going_back: return
	dog.stop()
	dog.go_right()


func _fall_buttons(pressed_button) -> void:
	for i in range(falling_buttons.size()):
		var button = falling_buttons[i]
		if pressed_button == button: 
			continue

		button.fall_off()
