extends TextureButton

var tween: Tween
var start_global_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_global_position = global_position
	
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_pressed)


func _on_pressed() -> void:
	# go to scene
	press()


func _on_mouse_entered() -> void:
	if tween != null and tween.is_valid():
		tween.kill()
		
	tween = create_tween().set_parallel(true)
	
	tween.tween_property(self, "scale", Vector2.ONE * .8, .1)
	


func _on_mouse_exited() -> void:
	if tween != null and tween.is_valid():
		tween.kill()
		
	tween = create_tween().set_parallel(true)
	
	tween.tween_property(self, "scale", Vector2.ONE, .1)
	
	

func press():
	if tween != null and tween.is_valid():
		tween.kill()
		
	tween = create_tween().set_parallel(true)
	tween.tween_property(self, "scale", Vector2.ONE * .7, .1)
	tween.tween_property(
		self, 
		"global_position", 
		start_global_position - Vector2(0, -10), 
		.1
	)
	
	tween.chain()

	tween.tween_property(self, "scale", Vector2.ONE * 1, .1)
	tween.tween_property(
		self, 
		"global_position", 
		start_global_position, 
		.1
	)
	await tween.finished
	
	await TransitionScreen.close().finished
	
	get_tree().change_scene_to_packed(GameManager.level_scenes[name])
	#await get_tree().create_timer(.3).timeout
	await TransitionScreen.open().finished
	
	
	print("delayed call")
