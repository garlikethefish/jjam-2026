@tool
class_name MainCamera extends Camera2D

@export var focused_follower: Node2D = null
@onready var screen_transition: TransitionLayer = $TransitionLayer
var follow_player := true
var zoom_tween: Tween
var actual_zoom_value := Vector2(2, 2)


func _ready() -> void:
	actual_zoom_value = zoom


func _process(_delta: float) -> void:
	if focused_follower == null or Engine.is_editor_hint():
		return

	if follow_player:
		global_position = focused_follower.global_position


func transition_zoom(target: Vector2):
	if zoom_tween:
		zoom_tween.kill()

	zoom_tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT) # EASE_IN, EASE_OUT, EASE_IN_OUT, EASE_OUT_IN
	zoom_tween.tween_property(self, "zoom", target, 1)


func set_shader(shader: ShaderDataRes):
	screen_transition.set_shader(shader)


func cover_screen():
	screen_transition.cover()


func uncover_screen():
	screen_transition.uncover()
