class_name CoverTransitionLayerBase extends CanvasLayer

@export var state := E.CoverLayerState.UNCOVERED

@export_group("Cover")
@export var cover_duration := .6
@export var cover_ease: Tween.EaseType
@export var cover_transition: Tween.TransitionType

@export_group("Uncover")
@export var uncover_duration := .6
@export var uncover_ease: Tween.EaseType
@export var uncover_transition: Tween.TransitionType


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func async_uncover():
	pass


func async_cover():
	pass
