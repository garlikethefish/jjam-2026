extends TextureButton

var tween: Tween
var start_global_position: Vector2
var saved_mat: ShaderMaterial
@export var delay_time := 0.0
@export var clickable_once := false
@onready var whoosh_audio_player: AudioStreamPlayer2D = $WhooshAudioPlayer2D
@onready var click_audio_player: AudioStreamPlayer2D = $ClickAudioPlayer2D

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
	was_clicked = true
	# go to scene
	if clickable_once and was_clicked:
		disabled = true
		material = null
		self_modulate = Color(1,1,1,.5)
		
		
	press()


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


func press():
	click_audio_player.play()
	if tween != null and tween.is_valid():
		tween.kill()
		
	tween = create_tween().set_parallel(true)
	tween.tween_property(self, "scale", Vector2.ONE * .7, .1)
	tween.tween_property(
		self, 
		"offset_transform_position", 
		Vector2(0, 20), 
		.1
	)
	
	tween.chain()

	tween.tween_property(self, "scale", Vector2.ONE * 1, .1)
	tween.tween_property(
		self, 
		"offset_transform_position", 
		Vector2(0, 0), 
		.1
	)
	await tween.finished
	await get_tree().create_timer(delay_time).timeout
	GameManager.go_to_scene(name)
	
