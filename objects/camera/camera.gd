@tool
class_name MainCamera extends Camera2D

@export var focused_follower: FollowableObject = null
var objects_to_follow: Array[FollowableObject] = []
var follow_player := true
var actual_zoom_value := Vector2(2, 2)

@onready var screen_transition: TransitionLayer = $TransitionLayer


func set_shader(shader: ShaderDataRes):
	screen_transition.set_shader(shader)


func cover_screen():
	screen_transition.cover()


func uncover_screen():
	screen_transition.uncover()

#func _get_configuration_warnings() -> PackedStringArray:
#var warnings = PackedStringArray()
#var children = get_children()
#
#if children.is_empty():
#warnings.append("Needs follower objects as children!")
#return warnings
#
#for child in children:
#if not (child is FollowableObject):
#warnings.append("Needs follower objects as children!")
#return warnings
#
#return warnings
#
#
#func _notification(what: int) -> void:
#if what == NOTIFICATION_CHILD_ORDER_CHANGED:
#update_configuration_warnings()


func _ready() -> void:
	actual_zoom_value = zoom
	#uncover_screen()
	#for child in get_children():
	#setup_follower(child)
#
#if focused_follower == null:
#switch_focused_follower()


func _process(_delta: float) -> void:
	if focused_follower == null or Engine.is_editor_hint():
		return

	if Input.is_action_just_pressed("move_camera"):
		switch_focused_follower()

	if follow_player:
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


var zoom_tween: Tween


func transition_zoom(target: Vector2):
	if zoom_tween:
		zoom_tween.kill()

	zoom_tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT) # EASE_IN, EASE_OUT, EASE_IN_OUT, EASE_OUT_IN
	zoom_tween.tween_property(self, "zoom", target, 1)
