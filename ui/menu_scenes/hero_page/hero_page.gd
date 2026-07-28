extends Control

@export var dog: Dog
var is_clicked = false

func _ready():
	await get_tree().create_timer(.3).timeout
	dog.go_right()


func _on_level_selection_pressed():
	if is_clicked: return
	is_clicked = true
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
