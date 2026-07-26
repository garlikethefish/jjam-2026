extends Camera2D

# array values: left, top, right, bottom of camera limits
@export var top_pos_limits: Array[int] = [-1,210,714,-76]
@export var middle_pos_limits: Array[int] = [-1,538,714,-76]
@export var bottom_pos_limits: Array[int] = [-1,210,714,-195]

var current_pos_limits = []

# cam levels: 1 = top, 2 = middle, 3 = bottom
@export var current_cam_level := 2 # middle

func _ready() -> void:
	set_camera_limits()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("move camera"):
		set_camera_limits()

func set_camera_limits():
	match current_cam_level:
		1:
			print(1)
			current_pos_limits = middle_pos_limits
			current_cam_level = 2
		2:
			print(2)
			current_pos_limits = bottom_pos_limits
			current_cam_level = 3
		3:
			print(3)
			current_pos_limits = top_pos_limits
			current_cam_level = 1
	self.limit_left = current_pos_limits[0]
	self.limit_top = current_pos_limits[1]
	self.limit_right = current_pos_limits[2]
	self.limit_bottom = current_pos_limits[3]
