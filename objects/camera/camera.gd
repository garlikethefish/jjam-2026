@tool
extends Camera2D

var objects_to_follow: Array[FollowableObject] = []
@export var focused_follower: FollowableObject = null


func _get_configuration_warnings() -> PackedStringArray:
	var warnings = PackedStringArray()
	var children = get_children()

	if children.is_empty():
		warnings.append("Needs follower objects as children!")
		return warnings

	for child in children:
		if not (child is FollowableObject):
			warnings.append("Needs follower objects as children!")
			return warnings

	return warnings


func _notification(what: int) -> void:
	if what == NOTIFICATION_CHILD_ORDER_CHANGED:
		update_configuration_warnings()


func _ready() -> void:
	for child in get_children():
		setup_follower(child)

	if focused_follower == null:
		switch_focused_follower()


func _process(_delta: float) -> void:
	if focused_follower == null or Engine.is_editor_hint():
		return

	if Input.is_action_just_pressed("move_camera"):
		switch_focused_follower()

	global_position = focused_follower.node.global_position


func setup_follower(follower: FollowableObject):
	objects_to_follow.append(follower)


func switch_focused_follower():
	var id = objects_to_follow.find(focused_follower)

	if id == -1:
		focused_follower = objects_to_follow[0]
		return

	if id + 1 >= objects_to_follow.size():
		id = 0
	else:
		id += 1

	focused_follower = objects_to_follow[id]
