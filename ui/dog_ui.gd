extends CanvasLayer

@export var show_up_button := true
@export var show_right_button := true
@export var show_left_button := true
@export var show_go_back_in_time_button := true

@onready var up_button: TextureButton = $Panel/UpButton
@onready var left_button: TextureButton = $Panel/LeftButton
@onready var right_button: TextureButton = $Panel/RightButton
@onready var go_back_in_time: TextureButton = $Panel/GoBackInTime
@onready var level_name: Label = $LevelNameLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	up_button.visible = show_up_button
	right_button.visible = show_right_button
	left_button.visible = show_left_button
	go_back_in_time.visible = show_go_back_in_time_button

	level_name.text = GameManager.current_scene_name
