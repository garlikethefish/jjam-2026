class_name CinematicCamera extends Camera2D

@export var cams_layer: CoverTransitionLayerBase

@export_group("Enter")
@export var enter_duration := .6
@export var enter_ease: Tween.EaseType
@export var enter_transition: Tween.TransitionType
@export var enter_pos_offset := Vector2.ZERO
@export var enter_zoom_offset := Vector2.ZERO

@export_group("Exit")
@export var exit_duration := .6
@export var exit_ease: Tween.EaseType
@export var exit_transition: Tween.TransitionType
@export var exit_pos_offset := Vector2.ZERO
@export var exit_zoom_offset := Vector2.ZERO

var tween: Tween
var original_global_pos: Vector2
var original_zoom: Vector2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !enabled:
		cams_layer.visible = false

	original_global_pos = global_position
	original_zoom = zoom


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func async_enter():
	enabled = true
	cams_layer.visible = true
	make_current()
	play_enter()
	await play_uncover()


func async_exit():
	play_exit()
	await play_cover()

	enabled = false
	cams_layer.visible = false


func play_uncover():
	await cams_layer.async_uncover()


func play_cover():
	await cams_layer.async_cover()


func play_enter() -> void:
	if tween != null and tween.is_valid():
		tween.kill()

	tween = create_tween().set_ease(enter_ease).set_trans(enter_transition).set_parallel()
	tween.tween_property(self, "zoom", original_zoom, enter_duration).from(enter_zoom_offset)
	tween.tween_property(self, "global_position", original_global_pos, enter_duration).from(
		original_global_pos + enter_pos_offset
	)

	await tween.finished


func play_exit() -> void:
	if tween != null and tween.is_valid():
		tween.kill()

	tween = create_tween().set_ease(exit_ease).set_trans(exit_transition).set_parallel()
	tween.tween_property(self, "zoom", original_zoom + exit_zoom_offset, exit_duration).from(
		original_zoom
	)
	tween \
			.tween_property(
		self,
		"global_position",
		original_global_pos + exit_pos_offset,
		exit_duration,
	) \
			.from(original_global_pos)
	await tween.finished
