extends Area2D

@export var next_scene_name := ""

func _on_body_entered(body: Node2D) -> void:
	print("entered finish: ", body.name)
	if body is Dog:
		GameManager.go_to_scene(next_scene_name)
		
