class_name CameraManager extends Node2D

var cams: Array[CinematicCamera2D] = []
var selected_cam: CinematicCamera2D = null


func _ready() -> void:
	switch_cam()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("move_camera"):
		switch_cam()


func add_cam(cam: CinematicCamera2D):
	cams.append(cam)


func remove_cam(cam: CinematicCamera2D):
	cams.erase(cam)


func switch_cam():
	if cams.size() == 0:
		return

	var i = cams.find(selected_cam)
	if i >= cams.size() - 1 or i == -1:
		selected_cam = cams[0]
	else:
		selected_cam = cams[i + 1]

	selected_cam.cam.make_current()
