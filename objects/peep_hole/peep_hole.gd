extends Area2D

@export var peep_camera: Camera2D
var main_camera: MainCamera
var player_in_range: CharacterBody2D = null
var is_switching := false
var is_peepin := false

var main_camera_starting_global_pos := Vector2.ZERO
var target_zoom := Vector2(2, 2)


func _ready() -> void:
	main_camera = get_tree().get_first_node_in_group("main_camera")


func _process(_delta: float) -> void:
	if !player_in_range:
		return

	if Input.is_action_just_pressed("interact"):
		if !is_peepin:
			switch_camera_A_to_B()
		else:
			switch_camera_B_to_A()

		print("is peepin: ", is_peepin)


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		print("is body!")
		player_in_range = body as CharacterBody2D


func _on_body_exited(body: Node2D) -> void:
	print("is body in range: ", player_in_range, " body: ", body)

	if player_in_range != null and body == player_in_range:
		player_in_range = null


func switch_camera_A_to_B():
	if is_switching:
		return

	is_switching = true
	#
	## capturing starting state
	#main_camera_starting_global_pos = main_camera.global_position
	#
	## zoom to point A
	#main_camera.follow_player = false
	#main_camera.transition_zoom(Vector2(9, 9))
	#main_camera.set_shader(peep_shader)
	#main_camera.cover_screen()
	#
	#await get_tree().create_timer(.6).timeout
	#
	## transition to point B
	#main_camera.global_position = peep_camera.global_position
	#
	#await get_tree().create_timer(.6).timeout
	#
	#main_camera.set_shader(grand_reveal_shader)
	#main_camera.uncover_screen()
	#
	#main_camera.transition_zoom(peep_camera.zoom)
	is_switching = false
	is_peepin = true


func switch_camera_B_to_A():
	if is_switching:
		return

	is_switching = true

	# zoom to point B
	#main_camera.transition_zoom(Vector2(5, 5))
	#main_camera.global_position = peep_camera.global_position
	#
	#main_camera.set_shader(grand_reveal_shader)
	#main_camera.cover_screen()
	#
	#await get_tree().create_timer(.5).timeout
	#
	## go back to point A
	#main_camera.global_position = main_camera_starting_global_pos - Vector2(0, -60)
	#
	#await get_tree().create_timer(.5).timeout
	#
	#main_camera.set_shader(peep_shader)
	#main_camera.uncover_screen()
	#
	#main_camera.transition_zoom(Vector2(2, 2))
	#print(main_camera.actual_zoom_value)
	#main_camera.follow_player = true
	is_switching = false
	is_peepin = false
