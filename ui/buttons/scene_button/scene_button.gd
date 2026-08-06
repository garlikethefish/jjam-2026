class_name SceneButton extends TextureButton

@export var click_delay: float
@export var scene := E.Scenes.NONE

@export_group("Tween Sequences")
@export var hover_effect: TweenSequence
@export var click_effect: TweenSequence

@onready var whoosh_audio_player: AudioStreamPlayer2D = $WhooshAudioPlayer2D
@onready var click_audio_player: AudioStreamPlayer2D = $ClickAudioPlayer2D
@onready var tween_composer: TweenComposer = $TweenComposer

var saved_mat: ShaderMaterial
var was_clicked = false
var level: SceneLevel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	saved_mat = material as ShaderMaterial
	material = null

	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_pressed)


func _on_pressed() -> void:
	# go to scene
	if was_clicked:
		return

	was_clicked = true
	disabled = true
	material = null
	self_modulate = Color(1.093, 0.703, 0.302)

	tween_composer.load_tween_sequence_and_start(click_effect)
	click_audio_player.play()

	await get_tree().create_timer(click_delay).timeout

	GameManager.go_to_scene(scene)


func _on_mouse_entered() -> void:
	if disabled:
		return

	material = saved_mat
	whoosh_audio_player.play()
#
#if tween != null and tween.is_valid():
#tween.kill()
#
#tween = create_tween().set_parallel(true)
#
#tween.tween_property(self, "scale", Vector2.ONE * 1.1, .1)


func _on_mouse_exited() -> void:
	material = null

	if disabled:
		return

	whoosh_audio_player.play()
	#if tween != null and tween.is_valid():
	#tween.kill()
#
#tween = create_tween().set_parallel(true)
#
#tween.tween_property(self, "scale", Vector2.ONE, .1)

#func fall_off():
#fall_composer.play_tween()


func disable():
	disabled = true
	self_modulate = Color(1, 1, 1, .5)


func enable():
	disabled = false
	self_modulate = Color(1, 1, 1, 1)
