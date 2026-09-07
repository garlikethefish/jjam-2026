class_name PlainFadeCoverTransitionLayerBase extends CoverTransitionLayerBase

@onready var color_rect: ColorRect = $ColorRect
var tween: Tween


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()


func async_cover() -> void:
	if state == E.CoverLayerState.CHANGING:
		return
	state = E.CoverLayerState.CHANGING

	if tween != null and tween.is_valid():
		tween.kill()

	tween = create_tween().set_ease(cover_ease).set_trans(cover_transition)
	tween.tween_property(color_rect, "modulate", Color.WHITE, cover_duration)

	await tween.finished

	state = E.CoverLayerState.COVERED


func async_uncover() -> void:
	if state == E.CoverLayerState.CHANGING:
		return
	state = E.CoverLayerState.CHANGING

	if tween != null and tween.is_valid():
		tween.kill()

	tween = create_tween().set_ease(uncover_ease).set_trans(uncover_transition)
	tween.tween_property(color_rect, "modulate", Color.TRANSPARENT, uncover_duration)

	await tween.finished

	state = E.CoverLayerState.UNCOVERED
