extends Area2D

@export var cin_camera: CinematicCamera

@export_group("Zoom in")
@export var zoom := Vector2(6, 6)
@export var zoom_in_duration := .6
@export var zoom_in_ease: Tween.EaseType
@export var zoom_in_transition: Tween.TransitionType

@export_group("Zoom out")
@export var zoom_out_duration := .6
@export var zoom_out_ease: Tween.EaseType
@export var zoom_out_transition: Tween.TransitionType

@onready var zoom_camera: Camera2D = $Camera2D
var cam_to_copy_ref: Camera2D = null
var tween: Tween
var is_zoomin := false

var main_camera: MainCamera
var player_in_range: PlayerCharacterBase = null
var is_switching := false

var main_camera_starting_global_pos := Vector2.ZERO
var target_zoom := Vector2(2, 2)


func _ready() -> void:
	main_camera = get_tree().get_first_node_in_group("main_camera")


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and player_in_range != null:
		if cin_camera.cams_layer.state == E.CoverLayerState.CHANGING or is_switching:
			return

		if !cin_camera.enabled:
			is_switching = true
			player_in_range.disable_movement = true
			await async_zoom_into_hole(main_camera)
			await cin_camera.async_enter()

		else:
			is_switching = true
			await cin_camera.async_exit()
			await async_zoom_out_the_hole()
			player_in_range.disable_movement = false

		is_switching = false


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		print("is body!")
		player_in_range = body as CharacterBody2D


func _on_body_exited(body: Node2D) -> void:
	if player_in_range != null and body == player_in_range:
		print("area exited")
		player_in_range = null


func async_zoom_into_hole(cam_to_copy: Camera2D = null):
	if is_zoomin:
		return
	is_zoomin = true

	zoom_camera.enabled = true
	zoom_camera.make_current()

	if cam_to_copy != null:
		cam_to_copy_ref = cam_to_copy
		zoom_camera.zoom = cam_to_copy.zoom
		zoom_camera.global_position = cam_to_copy.global_position

	if tween != null and tween.is_valid():
		tween.kill()

	tween = create_tween().set_ease(zoom_in_ease).set_trans(zoom_in_transition).set_parallel()
	tween.tween_property(zoom_camera, "zoom", zoom, zoom_in_duration)
	tween.tween_property(
		zoom_camera,
		"global_position",
		global_position - Vector2(0, 20),
		zoom_out_duration,
	)

	await tween.finished

	zoom_camera.enabled = false
	is_zoomin = false


func async_zoom_out_the_hole():
	if is_zoomin:
		return
	is_zoomin = true

	zoom_camera.enabled = true
	zoom_camera.make_current()

	var zoom_: Vector2
	var end_pos_: Vector2

	if cam_to_copy_ref != null:
		zoom_ = cam_to_copy_ref.zoom
		end_pos_ = cam_to_copy_ref.global_position
	else:
		zoom_ = Vector2(2, 2)
		end_pos_ = player_in_range.global_position

	if tween != null and tween.is_valid():
		tween.kill()

	tween = create_tween().set_ease(zoom_out_ease).set_trans(zoom_out_transition).set_parallel()
	tween.tween_property(zoom_camera, "zoom", zoom_, zoom_out_duration)
	tween.tween_property(zoom_camera, "global_position", end_pos_, zoom_out_duration)

	await tween.finished

	zoom_camera.enabled = false
	cam_to_copy_ref = null
	is_zoomin = false
