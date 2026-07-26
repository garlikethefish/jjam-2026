extends CanvasLayer

@export var open_on_start := true
@onready var texture_rect: TextureRect = $TextureRect
var mat: ShaderMaterial
var tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mat = (texture_rect.material as ShaderMaterial)
	if open_on_start:
		override_open()
	else:
		override_close()


func open():
	if !mat: return
	if tween != null and tween.is_valid():
		tween.kill()
		
	tween = create_tween()
	tween.tween_property(mat, "shader_parameter/progress", 0, .5)
	return tween
	

func close():
	if !mat: return
	if tween != null and tween.is_valid():
		tween.kill()
		
	tween = create_tween()
	tween.tween_property(mat, "shader_parameter/progress", 1.0, .5)
	return tween


func override_close():
	if !mat: return
	if tween != null and tween.is_valid():
		tween.kill()
		
	tween = create_tween()
	tween.tween_property(mat, "shader_parameter/progress", 1.0, .5).from(0)
	return tween

func override_open():
	if !mat: return
	if tween != null and tween.is_valid():
		tween.kill()
		
	tween = create_tween()
	tween.tween_property(mat, "shader_parameter/progress", 0, .5).from(1)
	return tween
