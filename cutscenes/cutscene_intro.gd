extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause") or Input.is_action_just_pressed("skip"):
		GameManager.go_to_scene(E.Scenes.LEVEL_SELECTION)




func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	GameManager.go_to_scene(E.Scenes.LEVEL_SELECTION)
