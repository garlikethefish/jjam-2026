extends TextureButton

class_name CustomButton

var tween: Tween
var start_global_position: Vector2
var saved_mat: ShaderMaterial
@export var delay_time := 0.0
@export var scene_name := ""
@onready var whoosh_audio_player: AudioStreamPlayer2D = $WhooshAudioPlayer2D
@onready var click_audio_player: AudioStreamPlayer2D = $ClickAudioPlayer2D
@onready var click_fall_composer: TweenComposer = $ClickedFallTween
@onready var fall_composer: TweenComposer = $FallTween

var was_clicked = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	saved_mat = material as ShaderMaterial
	material = null
	
	start_global_position = global_position
	
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_pressed)


func _on_pressed() -> void:
	# go to scene
	if was_clicked: return
	
	was_clicked = true
	disabled = true
	material = null
	self_modulate = Color(1.093, 0.703, 0.302)
		
	click_fall_composer.play_tween()
	click_audio_player.play()
	
	await get_tree().create_timer(delay_time).timeout
	
	if scene_name != "":
		GameManager.go_to_scene(scene_name)


func _on_mouse_entered() -> void:
	if disabled: return
	
	material = saved_mat
	whoosh_audio_player.play()
	
	if tween != null and tween.is_valid():
		tween.kill()
		
	tween = create_tween().set_parallel(true)
	
	tween.tween_property(self, "scale", Vector2.ONE * 1.1, .1)


func _on_mouse_exited() -> void:
	material = null
	
	if disabled: return

	whoosh_audio_player.play()
	if tween != null and tween.is_valid():
		tween.kill()
		
	tween = create_tween().set_parallel(true)
	
	tween.tween_property(self, "scale", Vector2.ONE, .1)


func fall_off():
	fall_composer.play_tween()
