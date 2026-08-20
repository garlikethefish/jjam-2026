class_name PlainButton extends TextureButton

signal delayed_pressed()

@export var click_delay: float

@export_group("Tween Sequences")
@export var hover_enter_effect: TweenSequence
@export var hover_exit_effect: TweenSequence
@export var click_effect: TweenSequence

@onready var whoosh_audio_player: AudioStreamPlayer2D = $WhooshAudioPlayer2D
@onready var click_audio_player: AudioStreamPlayer2D = $ClickAudioPlayer2D
@onready var tween_composer: TweenComposer = $TweenComposer

var saved_mat: ShaderMaterial
var was_clicked = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	saved_mat = material as ShaderMaterial
	material = null

	if disabled:
		disable()
	else:
		enable()

	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_pressed)


func _on_pressed() -> void:
	# go to scene
	if was_clicked:
		return
	
	if should_disable_on_press():
		disabled = true
		
	was_clicked = true
	material = null
	self_modulate = Color(1.093, 0.703, 0.302)

	tween_composer.load_tween_sequence_and_start(click_effect)
	click_audio_player.play()

	await get_tree().create_timer(click_delay).timeout
	delayed_press()


func _on_mouse_entered() -> void:
	if disabled:
		return

	material = saved_mat
	whoosh_audio_player.play()
	tween_composer.load_tween_sequence_and_start_from_current(hover_enter_effect)


func _on_mouse_exited() -> void:
	material = null

	if disabled or hover_exit_effect == null:
		return

	whoosh_audio_player.play()
	tween_composer.load_tween_sequence_and_start_from_current(hover_exit_effect)


func play_tween_sequence(sequence: TweenSequence):
	tween_composer.load_tween_sequence_and_start_from_current(sequence)

func should_disable_on_press() -> bool:
	return true
	
func delayed_press():
	delayed_pressed.emit()

	if not should_disable_on_press():
		was_clicked = false
		enable()

func disable():
	disabled = true
	self_modulate = Color(1, 1, 1, .5)


func enable():
	disabled = false
	self_modulate = Color(1, 1, 1, 1)
