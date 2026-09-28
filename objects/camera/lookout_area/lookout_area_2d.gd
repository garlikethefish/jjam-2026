class_name LookoutArea2D extends Area2D

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
var camera_data: LookoutAreaData = null
var cam_manager: CameraManager = null


func _ready() -> void:
	camera_data = get_camera_data()
	cam_manager = get_tree().get_first_node_in_group("camera_manager") as CameraManager
	if cam_manager == null:
		printerr("Cant find camera_manager!")
		return


func _on_body_entered(body: Node2D) -> void:
	body = body as PlayerCharacterBase
	if body == null:
		return

	for cam in cam_manager.cams:
		if cam.target == body:
			cam.enter_lookout_area(self)
			print("body entered")


func _on_body_exited(body: Node2D) -> void:
	body = body as PlayerCharacterBase
	if body == null:
		return

	for cam in cam_manager.cams:
		if cam.target == body:
			cam.exit_lookout_area()
			print("body exited")


func get_camera_data(padding := 1.0) -> LookoutAreaData:
	var shape := collision_shape.shape as RectangleShape2D
	if not shape:
		return LookoutAreaData.new(global_position, Vector2.ONE)

	# global_scale includes scale from CollisionShape2D AND every parent Node2D!
	var world_size := shape.size * collision_shape.global_scale.abs()
	var vp := get_viewport_rect().size

	if world_size.x <= 0.0 or world_size.y <= 0.0:
		return LookoutAreaData.new(collision_shape.global_position, Vector2.ONE)

	# Viewport size divided by real world pixel size
	var ratio_x := vp.x / world_size.x
	var ratio_y := vp.y / world_size.y

	# minf ensures the entire rectangle fits inside the camera view
	var z := minf(ratio_x, ratio_y) / padding

	return LookoutAreaData.new(collision_shape.global_position, Vector2(z, z))
