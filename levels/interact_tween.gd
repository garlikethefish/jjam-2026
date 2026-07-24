extends AnimatedSprite2D

var tween: Tween

var start_global_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_global_position = global_position

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		press()
	
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
	#await tween.finished

	tween.tween_property(self, "scale", Vector2.ONE * 1, .1)
	tween.tween_property(
		self, 
		"global_position", 
		start_global_position, 
		.1
	)
