class_name SceneButton extends PlainButton

@export var scene := E.Scenes.NONE
@export var change_scene := true

var level: SceneLevel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()


func _on_pressed() -> void:
	if was_clicked:
		return

	super()


func _on_mouse_entered() -> void:
	if disabled:
		return

	super()


func _on_mouse_exited() -> void:
	material = null

	if disabled:
		return

	super()


func delayed_press():
	if change_scene:
		super()
		GameManager.go_to_scene(scene)


func disable():
	super()


func enable():
	super()
