@tool
class_name CinematicCamera2D extends CharacterBody2D

enum State {
	SNAPED_TO_AREA,
	FOLLOWING_TARGET,
	NONE,
}

@onready var cam: Camera2D = $Camera2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

@export var target: Node2D
@export_custom(PROPERTY_HINT_LINK, "") var default_zoom := Vector2.ONE:
	set(value):
		default_zoom = value.max(Vector2(0.01, 0.01))
@export_custom(PROPERTY_HINT_LINK, "") var follow_speed_multiplier := Vector2.ONE * 3
@export var arrow_to_target_deadzone_for_snap := 0.1

var has_snaped_to_target_at_close_range := false
var state := State.NONE
var entered_lookout_area: LookoutArea2D = null
var cam_manager: CameraManager = null
var zoom_tween: Tween = null

var zoom_target := Vector2.ONE


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	zoom_target = default_zoom

	cam_manager = get_tree().get_first_node_in_group("camera_manager") as CameraManager
	if cam_manager == null:
		printerr("Cant find camera_manager!")
		return
	cam_manager.add_cam(self)

	if cam != null:
		cam.zoom = default_zoom


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if target == null or Engine.is_editor_hint():
		return

	var move_force := Vector2.ZERO
	var end_pos := Vector2.INF

	match state:
		State.NONE:
			state = State.FOLLOWING_TARGET
			print("none")

		State.SNAPED_TO_AREA:
			var data = entered_lookout_area.camera_data
			move_force = data.global_pos - global_position
			end_pos = data.global_pos
			if zoom_target != data.zoom:
				transition_zoom(data.zoom)

		State.FOLLOWING_TARGET:
			move_force = target.global_position - global_position
			end_pos = target.global_position

			if zoom_target != default_zoom:
				transition_zoom(default_zoom)

	if state != State.NONE and end_pos != Vector2.INF:
		scale_collider_to_camera(cam)
		apply_velocity(move_force * follow_speed_multiplier, end_pos)
		move_and_slide()


func enter_lookout_area(area: LookoutArea2D):
	entered_lookout_area = area
	set_collision_mask_value(11, false)
	state = State.SNAPED_TO_AREA


func exit_lookout_area():
	entered_lookout_area = null
	set_collision_mask_value(11, true)
	state = State.NONE


func apply_velocity(vel: Vector2, end_pos: Vector2):
	if (
		!has_snaped_to_target_at_close_range
		and vel.length_squared() < arrow_to_target_deadzone_for_snap
	):
		has_snaped_to_target_at_close_range = true
		global_position = end_pos

		print("snap!")

	elif (
		has_snaped_to_target_at_close_range
		and vel.length_squared() > arrow_to_target_deadzone_for_snap
	):
		has_snaped_to_target_at_close_range = false

	if global_position != end_pos:
		velocity = vel


func scale_collider_to_camera(camera: Camera2D) -> void:
	var shape := collision_shape.shape as RectangleShape2D

	shape.size = get_viewport_rect().size / camera.zoom


func transition_zoom(target_zoom: Vector2):
	zoom_target = target_zoom

	if zoom_tween:
		zoom_tween.kill()

	zoom_tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT) # EASE_IN, EASE_OUT, EASE_IN_OUT, EASE_OUT_IN
	zoom_tween.tween_property(cam, "zoom", target_zoom, 1)
