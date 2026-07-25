extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_pressed() -> void:
	GameManager.level_timeline.go_back_an_action()
