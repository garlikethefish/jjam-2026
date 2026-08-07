extends Area2D

@export var scene := E.Scenes.NONE


func _on_body_entered(body: Node2D) -> void:
	if body is not Dog:
		return

	var level = SceneData.scenes[scene] as SceneLevel
	if level != null:
		level.is_unlocked = true

	GameManager.go_to_scene(scene)
