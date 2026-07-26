extends Area2D

@export var next_scene_name := ""

func _on_body_entered(body: Node2D) -> void:
	print("entered finish: ", body.name)
	if body is Dog:
		# trigger level complete
		await TransitionScreen.close().finished
		get_tree().change_scene_to_file(GameManager.level_scenes[next_scene_name])
		await TransitionScreen.open().finished
