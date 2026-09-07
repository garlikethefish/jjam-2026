class_name TransitionLayer extends CanvasLayer

@export var open_on_start := true

@export_group("Shader progress")
@export var progress_property_name := ""
@export var max_value := 0.0
@export var min_value := 0.0

@onready var texture_rect: TextureRect = $TextureRect
var mat: ShaderMaterial
var tween: Tween


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mat = (texture_rect.material as ShaderMaterial)
	if open_on_start:
		override_uncover()
	else:
		override_cover()


func uncover():
	if !mat:
		return

	print("uncover mat: ", mat, " shader: ", mat.shader.resource_path if mat.shader else "null")
	if tween != null and tween.is_valid():
		tween.kill()

	tween = create_tween()
	tween.tween_property(mat, shad_prop(progress_property_name), min_value, .5)
	return tween


func cover():
	if !mat:
		return
	if tween != null and tween.is_valid():
		tween.kill()

	tween = create_tween()
	tween.tween_property(mat, shad_prop(progress_property_name), max_value, .5)
	return tween


func override_cover():
	if !mat:
		return
	if tween != null and tween.is_valid():
		tween.kill()

	tween = create_tween()
	tween.tween_property(mat, shad_prop(progress_property_name), max_value, .5).from(0)
	return tween


func override_uncover():
	if !mat:
		return
	if tween != null and tween.is_valid():
		tween.kill()

	tween = create_tween()
	tween.tween_property(mat, shad_prop(progress_property_name), min_value, .5).from(1)
	return tween


func set_shader(shader: ShaderDataRes):
	mat = shader.shader_mat
	texture_rect.material = mat
	min_value = shader.min_v
	max_value = shader.max_v
	progress_property_name = shader.progres_prop_name


func shad_prop(prop: String):
	return "shader_parameter/%s" % [prop]
