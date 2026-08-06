extends Control

@export var dog: Dog
#@export var fall_initiator_buttons: Array[CustomButton] = []
#@export var falling_buttons: Array[CustomButton] = []

@export var level_buttons: Array[SceneButton] = []

@onready var back_button: TextureButton = $BackButton
var is_button_pressed = false
var is_going_back = false

var dog_speed := 60000

var go_back: Array[DogCommand] = []
var start_level: Array[DogCommand] = []
var go_to_start_pos: Array[DogCommand] = []


func _ready():
	#for button in fall_initiator_buttons:
	#button.pressed.connect(_fall_buttons.bind(button))
	#button.pressed.connect(_on_button_pressed)
	for button in level_buttons:
		var level = SceneData.scenes[button.scene] as SceneLevel
		if level == null:
			push_error("Invalid level scene: ", button.scene)
			return

		if level.is_unlocked:
			button.enable()
		else:
			button.disable()

	go_back = DogCommandBuilder.new().go_till_hits_a_wall(dog_speed, E.FacingDirection.LEFT).build()
	start_level = DogCommandBuilder.new().go_till_hits_a_wall(dog_speed, E.FacingDirection.RIGHT).build()
	go_to_start_pos = DogCommandBuilder.new().wait(.3).go_till_x(80, dog_speed).build()

	dog.append_and_execute_commands(go_to_start_pos)


func _on_end_area_2d_body_entered(_body):
	if is_button_pressed:
		return


func _on_back_area_2d_body_entered(_body):
	GameManager.go_to_scene(E.Scenes.HERO)


func _on_back_button_pressed():
	is_going_back = true
	is_button_pressed = true

	dog.append_and_execute_commands(go_back)


func _on_button_pressed():
	is_button_pressed = true
	if is_going_back:
		return

	dog.append_and_execute_commands(start_level)


func _fall_buttons(pressed_button) -> void:
	pass
	#for i in range(falling_buttons.size()):
	#var button = falling_buttons[i]
	#if pressed_button == button:
	#continue
#
#button.fall_off()
