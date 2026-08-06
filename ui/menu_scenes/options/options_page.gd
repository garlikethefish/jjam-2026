extends Control

@export var dog: Dog
var DIR = Enums.FacingDirection

var dog_speed := 30000

var go_left: Array[DogCommand] = []
var jump_in_well: Array[DogCommand] = []
var go_to_start_pos: Array[DogCommand] = []
var go_to_heaven: Array[DogCommand] = []


func _ready():
	go_left = DogCommandBuilder.new().go_till_hits_a_wall(dog_speed, DIR.LEFT).build()


func _on_back_area_body_entered(_body):
	GameManager.go_to_scene("HeroScene")


func _on_back_button_pressed():
	dog.append_and_execute_commands(go_left)
